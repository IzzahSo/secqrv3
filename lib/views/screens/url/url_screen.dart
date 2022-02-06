// ignore_for_file: unused_local_variable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:secqrv3/viewmodel/bloc/url_scan_bloc.dart';
import 'package:secqrv3/views/widgets/components/SizeConfig.dart';
import 'package:secqrv3/views/widgets/snake_navigation_bar.dart';
import 'package:secqrv3/views/screens/url/components/body.dart';
import 'package:secqrv3/themes/themes.dart';
import 'package:url_launcher/link.dart';

class UrlScreen extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    SizeConfig().init(context);
    var z = MediaQuery.of(context).size;
    
    return Scaffold(
      // bottomNavigationBar: SnakeNavigationBarWidget(),
      body: BlocProvider(
        create: (context) => UrlScanBloc(),
        child: Body()
        // child: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: <Widget>[
        //       Padding(
        //         padding: EdgeInsets.all(8.0),
        //         child: FlatButton(
        //           color: kPrimaryDark,
        //           onPressed: () => Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => Body())
        //           ),
        //           child: const Text(
        //             'Check URL using VirusTotal API',
        //             style: TextStyle(color: kPrimaryLight),
        //           ),
        //         ),
        //       ),
        //       const Padding(padding: EdgeInsets.all(8.0)),
        //       Link(
        //         uri: Uri.parse('http://192.168.1.101:8501/'),
        //         target: LinkTarget.blank, 
        //         builder: (BuildContext context, FollowLink? openLink){
        //           return FlatButton(
        //             color: kSecondaryDark,
        //             onPressed: openLink, 
        //             child: const Text(
        //               'Check using Deep Learning',
        //               style: TextStyle(
        //                 color: kPrimaryLight
        //               ),
        //               )
        //           );
        //         }
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}