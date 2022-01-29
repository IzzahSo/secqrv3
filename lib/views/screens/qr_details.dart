// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secqrv3/services/url_scan_service.dart';
import 'package:secqrv3/themes/themes.dart';
import 'package:secqrv3/views/screens/url/components/input_and_scan_button.dart';
import 'package:secqrv3/views/viewmodel/bloc/url_scan_bloc.dart';
import 'package:secqrv3/views/viewmodel/events/url_scan_event.dart';
import 'package:secqrv3/views/viewmodel/states/url_scan_state.dart';
import 'package:secqrv3/views/widgets/components/SizeConfig.dart';

class QRDetails extends StatefulWidget {
  const QRDetails({required this.qrCodeText});
  
  final String qrCodeText;

  @override
  State<QRDetails> createState() => _QRDetailsState();
}

class _QRDetailsState extends State<QRDetails> {
  UrlScanBloc ? _urlScanBloc;
  // final _controller = TextEditingController();
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('url');

  @override
  void initState(){
    super.initState();
    UrlScanService.urlResource = "";

    // final _controller = TextEditingController.fromValue(qrCodeText);
    // _urlScanBloc = BlocProvider.of<UrlScanBloc>(context);
  }

  Widget fetchQRDetails(BuildContext context) {
    String qrText = widget.qrCodeText;
    
    return StreamBuilder<QuerySnapshot>(
      stream: collectionReference.snapshots().asBroadcastStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData){ 
          // return Center(child: CircularProgressIndicator(),);
          if(snapshot.data!.docs.isEmpty){
            return Center(child: Text('No URL found'),);
          }
          else{
            return Column(children: [
              ...snapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) =>
                      element['url']
                          .toString()
                          .toLowerCase()
                          .contains(qrText.toLowerCase()))
                  .map((QueryDocumentSnapshot<Object?> data) {
                final url = data.get('url');
                final positives = data['positives'];
                final total = data['total'];

                return Center(
                  child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Qr Code Text: ',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryDark),
                          ),
                        ),
                        //edit yg malicious/safe
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: Text(url +
                              '\n\nThe URL is safe.\nPlease proceed with caution'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'VirusTotal detection: $positives/$total'
                          ),
                        ),
                      ],
                  ),
                );
              })
            ]);
          }
        }
        else if(snapshot.hasError){
          return const Center(child: Text('Error fetching data'));
        }
        else {
          return const Center(child: CircularProgressIndicator(),);          
        }
      }

    );
  }
  

  @override
  Widget build(BuildContext context) {
    // String qrText = widget.qrCodeText;
    // _urlScanBloc = BlocProvider.of<UrlScanBloc>(context);
    // UrlScanService.urlResource = qrText;
    // _urlScanBloc?.add(FetchUrlScanReportEvent());

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('QR Details'),
          centerTitle: true,
        ), 
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: fetchQRDetails(context)
          )
          //fetchQRDetails(context, qrText),
          // child: SafeArea(
          //   child: Column(
          //     children: [
          //       Padding(
          //         padding: EdgeInsets.all(20),
          //         child: Text("QR Code Text: " + qrText),
          //       ),  
                
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}