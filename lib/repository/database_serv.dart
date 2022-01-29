// ignore_for_file: unused_field,

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:secqrv3/models/url_scan.dart';
import 'package:secqrv3/views/viewmodel/bloc/url_scan_bloc.dart';
import 'package:secqrv3/views/viewmodel/events/url_scan_event.dart';


//TODO: add collections into firebase, need to tweak the parameters

class FirestoreProvider{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference urlCollection =
    FirebaseFirestore.instance.collection('url');

  final CollectionReference textCollection =
      FirebaseFirestore.instance.collection('text');

  final CollectionReference reportCollection =
    FirebaseFirestore.instance.collection('reports');

  Future<void> createOrUpdateUrl({String ? title, String ? url, String? status})async {
    await urlCollection
      .doc()
      .set({'title': title, 'url': url, 'status': status});
  }

  Future<void> updateText(
      {String? title, String? qrCodeText}) async {
    await urlCollection
        .doc()
        .set({'title': title, 'text': qrCodeText,});
  }

  Future <void> insertUrlReport(
    String scanId,
    String resource,
    String url,
    String responseCode,
    DateTime scanDate,
    String permalink,
    String verboseMsg,
    dynamic filescanId,
    int positives,
    int total,
    Map<String, UrlScan> urlScans,) async{
      await reportCollection
      .doc()
      .set({
        'scanId': scanId, 
        'resource': resource, 
        'url': url, 
        'responseCode': responseCode,
        'scanDate': scanDate,
        'permalink': permalink,
        'verboseMsg': verboseMsg,
        'filescanId': filescanId,
        'positives': positives,
        'total': total, 
        'urlScans': urlScans,
      });
  }

}