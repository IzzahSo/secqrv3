
// ignore_for_file: prefer_const_declarations

import 'package:dio/dio.dart';
import 'package:secqrv3/models/push_url_scan.dart';
import 'package:secqrv3/models/url_scan.dart';
import 'package:secqrv3/models/url_scan_report.dart';

class UrlScanService {
  late Response response;
  Dio dio = Dio();
  final String urlApi = "https://www.virustotal.com/vtapi/v2/url/report?";
  final String apiKey =
      "a4a74bd3c0849dc2fb20c713114a08d3baef20ff9ee43f321707824d79c2ec89";
  static String urlResource = "";
  //Push Url to server
  Future<int?> pushUrlScan() async {
    final String url = "https://www.virustotal.com/vtapi/v2/url/scan";
    try {
      FormData formData =
          FormData.fromMap({"apikey": apiKey, "url": urlResource});
      response = await dio.post(
        url,
        data: formData,
      );
      dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
      if (response.statusCode == 200) {
        var a = PushUrlScan.fromJson(response.data);
        //Future.delayed(Duration(seconds: 5));
        return a.responsecode;
      } else {
        throw ("Error status code in pushUrlScan");
      }
    } catch (exception) {
      throw ("=======Error in pushUrlScan method ====== " +
          exception.toString());
    }
  }

  //Get UrlScanReport
  Future<UrlScanReport> fetchUrlScanReport() async {
    try {
      response = await dio
          .get(urlApi + "apikey=" + apiKey + "&resource=" + urlResource);
      if (response.statusCode == 200) {
        var urlScanReport = UrlScanReport.fromJson(response.data);
        return urlScanReport;
      } else {
        print("\nError status code in fetchUrlScanReport\n");
      }
    } catch (exception) {
      throw ("\nError in fetchUrlScanReport====== " + exception.toString());
    }
    return UrlScanReport();
  }

  //Get URL scan list.
  Future<List<UrlScan>> fetchUrlScanList() async {
    try {
      List<UrlScan> scans = <UrlScan>[];
      var urlScanReport = await fetchUrlScanReport();
      for (var s in urlScanReport.urlScans!.values.toList()) {
        scans.add(s);
      }
      return scans;
    } catch (exception) {
      throw ("\nError in fetchUrlScanList: " + exception.toString());
    }
  }
}
