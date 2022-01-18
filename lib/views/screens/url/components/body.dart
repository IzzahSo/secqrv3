import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secqrv3/views/viewmodel/bloc_export.dart';
import 'package:secqrv3/themes/themes.dart';
import 'package:secqrv3/views/viewmodel/bloc/url_scan_bloc.dart';
import 'package:secqrv3/views/widgets/components/loading.dart';
import 'package:secqrv3/views/widgets/components/output_text.dart';
import 'package:secqrv3/views/widgets/components/title_text.dart';
import 'package:secqrv3/views/screens/url/components/url_scan_card.dart';
import 'package:secqrv3/services/url_scan_service.dart';

import 'package:secqrv3/views/widgets/components/SizeConfig.dart';
import 'package:secqrv3/views/viewmodel/states/url_scan_state.dart';
import 'input_and_scan_button.dart';

class Body extends StatefulWidget {
  // const Body({ Key key }) : super(key: key);
  
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final _urlTextController = TextEditingController();
  UrlScanBloc ? _urlScanBloc;

  @override 
  void initState(){
    super.initState();
    UrlScanService.urlResource = "";
    _urlScanBloc = BlocProvider.of<UrlScanBloc>(context);
  }

  @override
  void dispose(){
    super.dispose();
    _urlTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize!),
                        child: TitleText(title: "Check URL Links",),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize!),
                        child: InputAndScanButton(
                          urlTextController: _urlTextController,
                          scanBloc: _urlScanBloc,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize!*2),
                        child: Divider(thickness: 2, color: kPrimaryColor.withOpacity(.2),),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize! * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleText(title: "Scan URL Report",),
                            BlocBuilder<UrlScanBloc, UrlScanState>(
                              builder: (context, currentState){
                                if(currentState is SucceedScanUrlState){
                                  return TitleText(title: "${currentState.urlScanReport.total}");
                                } else {
                                  return TitleText(title: "0"); //Return there is no link inside the report yet
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 2, right: SizeConfig.defaultSize! * 2, bottom: SizeConfig.defaultSize! * 2),
                        child: BlocBuilder<UrlScanBloc, UrlScanState>(
                          builder:(context, currentstate) {
                            if(currentstate is InitialScanUrlState){
                              return OutputText(text: "Please input your URL!",);
                            }
                            if(currentstate is LoadingScanUrlState){
                              return LoadingWidget(imageloading: "assets/gif/spinner.gif",);
                            }
                            if(currentstate is SucceedScanUrlState){
                              if(currentstate.urlScan.isEmpty){
                                return OutputText(text:"Scan information is empty !");
                              }
                              return GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: currentstate.urlScan.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: SizeConfig.orientation ==
                                          Orientation.landscape ? 2 : 1,
                                      childAspectRatio: 2.1,
                                      mainAxisSpacing: SizeConfig.defaultSize! * 2,
                                      crossAxisSpacing: SizeConfig.defaultSize! * 2
                                  ),
                                  itemBuilder: (context, index) => UrlScanCard(urlScan:currentstate.urlScan[index])
                              );
                            }
                            if(currentstate is FailedScanUrlState){
                              return OutputText(text: "Some errors:\nPlease check your internet connection"
                                  "\nYour input url is not correct"
                                  "\nServer is busy now !",);
                            }
                            return OutputText(text: "Please input your URL!",);
                          }
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ],
          )
        ),
      ],
    );
  }
}
