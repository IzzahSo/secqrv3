// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secqrv3/models/url_scan.dart';


//TODO: add collections into firebase, need to tweak the parameters

class FirestoreProvider{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference urlCollection =
    FirebaseFirestore.instance.collection('url');

  final CollectionReference reportsCollection =
    FirebaseFirestore.instance.collection('reports');

  Future<void> createOrUpdateUrl({String ? title, String ? url})async {
    await urlCollection
      .doc()
      .set({'title': title, 'url': url});
  }

  Future <void> createReports(
    String scanId, 
    String resource, 
    String url,
    int responseCode,
    DateTime scanDate,
    String permalink,
    String verboseMsg,
    dynamic filescanId,
    int positives,
    int total,
    Map<String, UrlScan> urlScans,) async{
      await reportsCollection
      .doc()
      .set({scanId: scanId, resource: resource, url: url, 
      responseCode: responseCode, scanDate: scanDate,
      permalink: permalink, verboseMsg: verboseMsg,
      filescanId: filescanId, positives: positives,
      total: total
      });
    }
}