// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:secqrv3/views/viewmodel/bloc/url_scan_bloc.dart';
import 'package:secqrv3/views/widgets/components/SizeConfig.dart';
import 'package:secqrv3/views/widgets/snake_navigation_bar.dart';
import 'package:secqrv3/views/screens/url/components/body.dart';
import 'package:secqrv3/themes/themes.dart';

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
      ),
    );
  }
}