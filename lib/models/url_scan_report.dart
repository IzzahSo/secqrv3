import 'package:equatable/equatable.dart';
// import 'package:secqrv3/models/file_scan.dart';
import 'package:secqrv3/models/url_scan.dart';

class UrlScanReport extends Equatable {
  @override
  List<Object> get props => [];

  const UrlScanReport({
    this.scanId,
    this.resource,
    this.url,
    this.responseCode,
    this.scanDate,
    this.permalink,
    this.verboseMsg,
    this.filescanId,
    this.positives,
    this.total,
    this.urlScans,
  });

  final String ? scanId;
  final String ? resource;
  final String ? url;
  final int ? responseCode;
  final DateTime ? scanDate;
  final String ? permalink;
  final String ? verboseMsg;
  final dynamic filescanId;
  final int ? positives;
  final int ? total;
  final Map<String, UrlScan> ? urlScans;

  factory UrlScanReport.fromJson(Map<String, dynamic> json) => UrlScanReport(
      scanId: json["scan_id"],
      resource: json["resource"],
      url: json["url"],
      responseCode: json["response_code"],
      scanDate: DateTime.parse(json["scan_date"]),
      permalink: json["permalink"],
      verboseMsg: json["verbose_msg"],
      filescanId: json["filescan_id"],
      positives: json["positives"],
      total: json["total"],
      urlScans: Map.from(json["scans"]).map((key, value) =>
          MapEntry<String, UrlScan>(key, UrlScan.fromJson(key, value))));
  // Map<String, dynamic> toJson() => {
  //   "scan_id": scanId,
  //   "resource": resource,
  //   "url": url,
  //   "response_code": responseCode,
  //   "scan_date": scanDate.toIso8601String(),
  //   "permalink": permalink,
  //   "verbose_msg": verboseMsg,
  //   "filescan_id": filescanId,
  //   "positives": positives,
  //   "total": total,
  //   "scans": Map.from(urlScans).map((key, value) => MapEntry<String,dynamic>(key,value.toJson())),
  // };
}
