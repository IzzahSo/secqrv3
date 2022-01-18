import 'package:equatable/equatable.dart';

class UrlScan extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
  final String keyname;
  final bool detected;
  final String result;

  
  const UrlScan({this.keyname = "", this.detected = false, this.result = ""});
  
  factory UrlScan.fromJson(String keyname, Map<String, dynamic> json) =>
      UrlScan(
          keyname: keyname, detected: json["detected"], result: json["result"]);

  // Map<String, dynamic> toJson(){
  //   return {
  //     "detected": detected,
  //     "result": result
  //   };
  // }
}
