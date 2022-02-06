// ignore_for_file: annotate_overrides

import 'package:equatable/equatable.dart';
import 'package:secqrv3/models/url_scan.dart';
import 'package:secqrv3/models/url_scan_report.dart';

abstract class UrlScanState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialScanUrlState extends UrlScanState {}

class LoadingScanUrlState extends UrlScanState {}

//Scan state
class SucceedScanUrlState extends UrlScanState {
  final UrlScanReport urlScanReport;
  final List<UrlScan>  urlScan;
  SucceedScanUrlState({required this.urlScanReport, required this.urlScan});
  List<Object> get props => [urlScan, urlScanReport];
}

class FailedScanUrlState extends UrlScanState {}
