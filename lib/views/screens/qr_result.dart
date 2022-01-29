import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secqrv3/services/url_scan_service.dart';
import 'package:secqrv3/themes/themes.dart';
import 'package:secqrv3/views/screens/qr_details.dart';
import 'package:secqrv3/views/viewmodel/bloc/url_scan_bloc.dart';
import 'package:secqrv3/views/viewmodel/events/url_scan_event.dart';
import 'package:secqrv3/views/viewmodel/states/url_scan_state.dart';
import 'package:secqrv3/views/widgets/components/SizeConfig.dart';

class QRResult extends StatelessWidget {
  const QRResult({required this.qrCodeText});
  
  final String qrCodeText;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // var z = MediaQuery.of(context).size;

    return Scaffold(
      // bottomNavigationBar: SnakeNavigationBarWidget(),
      body: BlocProvider(
        create: (context) => UrlScanBloc(), 
        child: QRDetails(qrCodeText: qrCodeText,)),
    );

    //// Padding(
    //   padding: EdgeInsets.all(20),
    //   child:InputAndScanButton(
    //     urlTextController: TextEditingController.fromValue(TextEditingValue(text: qrText)) ,
    //     scanBloc: _urlScanBloc,
    //   )
    // ),
    // Padding(
    //   padding: EdgeInsets.all(10),
    //   child: BlocBuilder<UrlScanBloc, UrlScanState>(
    //     builder: (context, currentState){
    //       if(currentState is SucceedScanUrlState){
    //         if (currentState.urlScanReport.positives == -1) {
    //           //The site has not included in TotalVirus
    //           //background: Gray
    //           return Container(
    //             padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize! * 2),
    //             decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(20),),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: const <Widget>[
    //                 Text(
    //                   "This URL has never been registered!"
    //                       "\nPlease proceed with caution.",
    //                   style: TextStyle(
    //                     color: kPrimaryDark,
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                   Icon(Icons.security_rounded, color: Colors.yellow,),
    //               ],
    //             ),
    //           );
    //         }
    //         else if (currentState.urlScanReport.positives != 0){
    //           //if site is found malicious
    //           //background: red
    //           return Container(
    //             padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize! * 2),
    //             decoration: BoxDecoration(color: Colors.red[300], borderRadius: BorderRadius.circular(20),),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: const <Widget>[
    //                 Text(
    //                   "Malicious URL"
    //                       "\nDo not proceed to this site!!",
    //                   style: TextStyle(
    //                     color: kPrimaryDark,
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 Icon(
    //                   Icons.security_outlined,
    //                   color: Colors.black,
    //                 ),
    //               ],
    //             ),
    //           );
    //         }
    //         else{
    //           //if its a safe url
    //           //background: green
    //           return Container(
    //               padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize! * 2),
    //               decoration: BoxDecoration(color: Colors.green[300], borderRadius: BorderRadius.circular(20),),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: const <Widget>[
    //                   Text(
    //                     "Safe URL"
    //                     "\nDon't worry site is safe~",
    //                     style: TextStyle(
    //                       color: kPrimaryDark,
    //                       fontSize: 20,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                   Icon(
    //                     Icons.check_circle_outline,
    //                     color: Colors.green,
    //                   ),
    //                 ],
    //               ),
    //           );
    //         }
    //       }
    //       else if( currentState is FailedScanUrlState){
    //         return Container(
    //               padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize! * 2),
    //               decoration: BoxDecoration(color: Colors.green[300], borderRadius: BorderRadius.circular(20),),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: const <Widget>[
    //                   Expanded(
    //                     child: Text(
    //                       "Safe URL"
    //                       "\nThe URL is not included in VitusTotal"
    //                       "\nPlease proceed with caution!",
    //                       style: TextStyle(
    //                         color: kPrimaryDark,
    //                         fontSize: 15,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                   ),
    //                   Icon(
    //                     Icons.security_outlined,
    //                     color: Colors.white,
    //                   ),
    //                 ],
    //               ),
    //           );
    //       }
    //       return Container(
    //         padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize! * 2),
    //         decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(20),),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: const <Widget>[
    //             Text(
    //               "Checking the URL in VirusTotal",
    //               style: TextStyle(
    //                 color: kPrimaryDark,
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //               Icon(Icons.security_rounded, color: Colors.white,),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // ),
  }
}