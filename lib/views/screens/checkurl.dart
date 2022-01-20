// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secqrv3/services/url_scan_service.dart';
import 'package:secqrv3/themes/themes.dart';
// import 'package:secqr/views/widgets/custom_dialog.dart';
// import 'package:url_launcher/url_launcher.dart';
//paste links package
// import 'package:percent_indicator/circular_percent_indicator.dart';

class CheckURL extends StatefulWidget {
  const CheckURL();

  @override
  _CheckURLState createState() => _CheckURLState();
}

class _CheckURLState extends State<CheckURL> {
  TextEditingController field = TextEditingController();
  String pasteValue = '';
  
  // void refreshOnTextFieldTextChange() {
  //   setState(() {});
  // }

  //  @override
  // void initState() {
  //   super.initState();

  //   textEditingController.addListener(() {
  //     refreshOnTextFieldTextChange();
  //   });
  // }

  // @override
  // void dispose() {
  //   textEditingController.dispose();
  //   super.dispose();
  // }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 250),
              TextFormField(
                controller: field,
                style: const TextStyle(color: kPrimaryDark, fontSize: 20),
                decoration: InputDecoration(
                    labelText:
                        'Enter a link to check whether it is safe or unsafe',
                    labelStyle: const TextStyle(color: kSecondaryDark),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    hintStyle:
                        Theme.of(context).inputDecorationTheme.hintStyle,
                    filled: true,
                    fillColor:
                        Theme.of(context).inputDecorationTheme.fillColor,
                    suffixIcon: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: kSecondaryDark)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: Theme.of(context).accentColor))),
              ),
              const SizedBox(height: 50),
              // Container(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget>[
              //       new CircularPercentIndicator(
              //           radius: 130,
              //       ),
              //     ],
              //   )
              // ),
              // const SizedBox(height: 50),
              // Container(
              //   height: 250,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       color: kSecondaryLight,
              //       borderRadius: BorderRadius.circular(40)),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         children: const [
              //           Padding(
              //             padding: EdgeInsets.only(
              //               left: 50,
              //               right: 50,
              //               top: 20,
              //             ),
              //             child: Icon(Icons.circle,
              //                 color: Colors.green, size: 50),
              //           ),
              //           SizedBox(width: 2),
              //           Text(
              //             'Secure link',
              //             style: TextStyle(
              //               fontSize: 15,
              //               fontWeight: FontWeight.bold,
              //               letterSpacing: 2,
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         children: const [
              //           Padding(
              //             padding: EdgeInsets.only(
              //               left: 50,
              //               right: 50,
              //               top: 20,
              //             ),
              //             child: Icon(Icons.circle,
              //                 color: Colors.yellow, size: 50),
              //           ),
              //           SizedBox(width: 2),
              //           Expanded(
              //             child: Text(
              //               'Unsecure link. \nPlease proceed with caution',
              //               style: TextStyle(
              //                 fontSize: 15,
              //                 fontWeight: FontWeight.bold,
              //                 letterSpacing: 2,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         children: const [
              //           Padding(
              //             padding: EdgeInsets.only(
              //               left: 50,
              //               right: 50,
              //               top: 20,
              //             ),
              //             child:
              //                 Icon(Icons.circle, color: Colors.red, size: 50),
              //           ),
              //           SizedBox(width: 2),
              //           Text(
              //             'Malicious link! \nDo not proceed!!',
              //             style: TextStyle(
              //               fontSize: 15,
              //               fontWeight: FontWeight.bold,
              //               letterSpacing: 2,
              //             ),
              //           ),
              //         ],
                    // ),

                    //   Padding(
                    //     padding: const EdgeInsets.only(
                    //       left: 30,
                    //       top: 50,
                    //     ),
                    //     child: Text(
                    //       'Yellow: Unsecure link: Please proceed with caution',
                    //       style: TextStyle(
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.bold,
                    //         letterSpacing: 2,
                    //         backgroundColor: Colors.yellow
                    //       ),
                    //     ),
                    //   ),
                    //   Padding(
                    //     padding: const EdgeInsets.only(
                    //       left: 30,
                    //       top: 50,
                    //     ),
                    //     child: Text(
                    //       'Red: Malicious link!! Do not proceed!',
                    //       style: TextStyle(
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.bold,
                    //         letterSpacing: 2,
                    //         backgroundColor: Colors.red
                    //       ),
                    //     ),
                    //   ),
                    // ],
          //         ],
          //       ),
          //     ),
          //     // Expanded(
          //     //   child: LayoutBuilder(builder: (context, constraints){
          //     //     return Row(
          //     //       children: [
          //     //         Row(
          //     //           crossAxisAlignment: CrossAxisAlignment.start,
          //     //           children: [
          //     //             Text('')
          //     //           ],
          //     //         )
          //     //       ],
          //     //     );
          //     //   }
          //     //   ),
          //     // ),
            ],
          ),
        ),
      ),
    );
  }
}
