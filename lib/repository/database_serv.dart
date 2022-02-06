// ignore_for_file: unused_field,

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:secqrv3/models/url_scan.dart';
import 'package:secqrv3/viewmodel/bloc/url_scan_bloc.dart';
import 'package:secqrv3/viewmodel/events/url_scan_event.dart';

class FirestoreProvider{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference urlCollection =
    FirebaseFirestore.instance.collection('url');

  // final CollectionReference textCollection =
  //     FirebaseFirestore.instance.collection('text');

  // final CollectionReference reportCollection =
  //   FirebaseFirestore.instance.collection('reports');

  // Future<void> createOrUpdateUrl({String ? title, String ? url, String? status})async {
  //   await urlCollection
  //     .doc()
  //     .set({'title': title, 'url': url, 'status': status});
  // }

  Future<void> updateText(
      {String? title, String? qrCodeText}) async {
    await urlCollection
        .doc()
        .set({'title': title, 'text': qrCodeText,});
  }

  //Write data to Firestore
  Future<void> addData({
    required String title,
    required String url,
    required int positives,
    required int total,
    required int statusCode,
    required DateTime scanDate,
  }) async {
    DocumentReference documentReference = urlCollection.doc();

    Map<String, dynamic> data = <String, dynamic> {
      "title": title,
      "url": url,
      "positives": positives,
      "total": total,
      "scanDate": scanDate,
      "statusCode": statusCode
    };

    await documentReference
      .set(data)
      .whenComplete(() => print('Data is added into Firestore database'))
      .catchError((e) => print(e));
  }

  //Only change the title according to preference
  Future<void> updateData({
    required String title,
    // required String url,
    // required int positives,
    // required int total,
  }) async {
    DocumentReference documentReference = urlCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      // "url": url,
      // "positives": positives,
      // "total": total,
    };

    await documentReference
        .update(data)
        .whenComplete(() => print('Data is added into Firestore database'))
        .catchError((e) => print(e));
  }

  //Dekete data
  Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReference = urlCollection.doc().collection('url').doc(docId);

    await documentReference
      .delete()
      .whenComplete(() => print('Data is deleted from Firestore Database'))
      .catchError((e) => print(e));
  }

  // Future <void> insertUrlReport(
  //   String scanId,
  //   String resource,
  //   String url,
  //   String responseCode,
  //   DateTime scanDate,
  //   String permalink,
  //   String verboseMsg,
  //   dynamic filescanId,
  //   int positives,
  //   int total,
  //   Map<String, UrlScan> urlScans,) async{
  //     await reportCollection
  //     .doc()
  //     .set({
  //       'scanId': scanId, 
  //       'resource': resource, 
  //       'url': url, 
  //       'responseCode': responseCode,
  //       'scanDate': scanDate,
  //       'permalink': permalink,
  //       'verboseMsg': verboseMsg,
  //       'filescanId': filescanId,
  //       'positives': positives,
  //       'total': total, 
  //       'urlScans': urlScans,
  //     });
  // }

}