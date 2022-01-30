// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:secqrv3/services/url_scan_service.dart';
import 'package:secqrv3/themes/themes.dart';
import 'package:secqrv3/views/screens/url/components/input_and_scan_button.dart';
import 'package:secqrv3/views/viewmodel/bloc/url_scan_bloc.dart';
import 'package:secqrv3/views/viewmodel/events/url_scan_event.dart';
import 'package:secqrv3/views/viewmodel/states/url_scan_state.dart';
import 'package:secqrv3/views/widgets/components/SizeConfig.dart';
import 'package:secqrv3/views/widgets/components/output_text.dart';
import 'package:url_launcher/url_launcher.dart';

class QRDetails extends StatefulWidget {
  const QRDetails({required this.qrCodeText});
  
  final String qrCodeText;

  @override
  State<QRDetails> createState() => _QRDetailsState();
}

class _QRDetailsState extends State<QRDetails> {
  //calling firestore database
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('url');

  @override
  void initState(){
    super.initState();
    UrlScanService.urlResource = "";

    // final _controller = TextEditingController.fromValue(qrCodeText);
    // _urlScanBloc = BlocProvider.of<UrlScanBloc>(context);
  }

  void copyQrCodeTextToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.qrCodeText));
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('QR code text copied to clipboard!'),
        duration: Duration(milliseconds: 2500)));
  }

  void launchUrlFromQrCodeText() async {
    await launch(widget.qrCodeText);
  }

  Widget fetchQRDetails(BuildContext context) {
    String qrText = widget.qrCodeText;
    
    return StreamBuilder<QuerySnapshot>(
      stream: collectionReference.snapshots().asBroadcastStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData){ 
          // return Center(child: CircularProgressIndicator(),);
          if(snapshot.data!.docs.isEmpty){
            return Center(child: SafeArea(child: Text("The URL is not updated in our database\nGo to 'Check URL links' page to check in VirusTotal's server")),);
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

                  if(positives == 0){
                    return Center(
                      child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[    
                                Text(
                                  'Qr Code Text: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: kPrimaryDark),
                                ),
                                Text(
                                  url,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ],
                              ),   
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(color: Colors.green[300], borderRadius: BorderRadius.circular(20),),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const <Widget> [
                                      Text(
                                        "Safe URL",
                                        style: TextStyle(
                                          color: kPrimaryDark,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ],  
                                  ),
                                )
                              ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'VirusTotal detection: ',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    '$positives / $total',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green[900],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () => copyQrCodeTextToClipboard(context), 
                                    child: const Text('Copy', style: TextStyle(color: kPrimaryLight),),
                                    color: kPrimaryDark,
                                  ),
                                  SizedBox(width: 15,),
                                  FlatButton(
                                    onPressed: () =>
                                        launchUrlFromQrCodeText(),
                                    child: const Text(
                                      'Open',
                                      style: TextStyle(color: kPrimaryLight),
                                    ),
                                    color: kPrimaryDark,
                                ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    );
                  }
                  else if (positives != 0) {
                    return Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Qr Code Text: ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: kPrimaryDark),
                                  ),
                                  Text(
                                    url,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryDark
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //edit yg malicious/safe
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Colors.red[300],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const <Widget>[
                                        Text(
                                          "Malicious URL",
                                          style: TextStyle(
                                            color: kPrimaryDark,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SafeArea(
                                          child: Text(
                                            "\nPlease do not proceed to this site!",
                                            style: TextStyle(
                                              color: kPrimaryDark,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.security_outlined,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'VirusTotal detection: ',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    '$positives / $total',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              
                          ),
                        ],
                      ),
                    );
                  }
                  return OutputText(text: "Fetching data...",);
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
    String qrText = widget.qrCodeText;

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
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                QrImage(
                  data: qrText,
                  size: 250,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 20.0),
                fetchQRDetails(context)
              ],
            )
            
          )
        ),
      ),
    );
  }
}