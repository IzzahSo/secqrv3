import 'package:equatable/equatable.dart';

abstract class UrlScanEvent extends Equatable {}

class FetchUrlScanReportEvent extends UrlScanEvent {
  @override
  List<Object> get props => [];
}
