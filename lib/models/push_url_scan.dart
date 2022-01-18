import 'package:equatable/equatable.dart';

class PushUrlScan extends Equatable {
  final int ? responsecode;
  final String ? verbosemsg;
  final String ? scanid;
  final String ? scandate;
  final String ? permalink;

  const PushUrlScan(
      {this.responsecode,
      this.verbosemsg,
      this.scanid,
      this.scandate,
      this.permalink});
  factory PushUrlScan.fromJson(Map<String, dynamic> json) {
    return PushUrlScan(
        responsecode: json["response_code"],
        verbosemsg: json["verbose_msg"],
        scanid: json["scan_id"],
        scandate: json["scan_date"],
        permalink: json["permalink"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "response_code": responsecode,
      "verbose_msg": verbosemsg,
      "scan_id": scanid,
      "scan_date": scandate,
      "permalink": permalink
    };
  }

  @override
  List<Object> get props => [];
}
