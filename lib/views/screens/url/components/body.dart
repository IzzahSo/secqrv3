import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final CollectionReference urlCollection =
      FirebaseFirestore.instance.collection('url');

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Check URL Links'),),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15.0,),
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
                          child: BlocBuilder<UrlScanBloc, UrlScanState>(
                            builder: (context, currentState){
                              if(currentState is SucceedScanUrlState){
                                urlCollection.add({
                                  'title' : 'Check URL List in VirusTotal',
                                  'url': _urlTextController.text,
                                  'positives'  : '${currentState.urlScanReport.positives}',
                                  'total' : '${currentState.urlScanReport.total}',
                                  }
                                ).then((value) => print("Data added"));
                                if (currentState.urlScanReport.positives == -1) {
                                  //The site has not included in TotalVirus
                                  //background: Gray
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize! * 2),
                                    decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(20),),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const <Widget>[
                                        Text(
                                          "This URL has never been registered!"
                                              "\nPlease proceed with caution.",
                                          style: TextStyle(
                                            color: kPrimaryDark,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                          Icon(Icons.security_rounded, color: Colors.yellow,),
                                      ],
                                    ),
                                  );
                                }
                                else if (currentState.urlScanReport.positives != 0){
                                  //if site is found malicious
                                  //background: red
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize! * 2),
                                    decoration: BoxDecoration(color: Colors.red[300], borderRadius: BorderRadius.circular(20),),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const <Widget>[
                                        Text(
                                          "Malicious URL"
                                              "\nDo not proceed to this site!!",
                                          style: TextStyle(
                                            color: kPrimaryDark,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          Icons.security_outlined,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                else{
                                  //if its a safe url
                                  //background: green
                                  return Container(
                                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize! * 2),
                                      decoration: BoxDecoration(color: Colors.green[300], borderRadius: BorderRadius.circular(20),),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const <Widget>[
                                          Text(
                                            "Safe URL"
                                            "\nDon't worry site is safe~",
                                            style: TextStyle(
                                              color: kPrimaryDark,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                          ),
                                        ],
                                      ),
                                  );
                                }
                              }
                              else if( currentState is FailedScanUrlState){
                                return Container(
                                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize! * 2),
                                      decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(20),),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const <Widget>[
                                          Expanded(
                                            child: Text(
                                              "The URL is not included in VitusTotal"
                                              "\nPlease proceed with caution!",
                                              style: TextStyle(
                                                color: kPrimaryDark,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.security_outlined,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                  );
                              }
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!*2, vertical: SizeConfig.defaultSize! * 2),
                                decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(20),),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    Text(
                                      "Checking the URL in VirusTotal",
                                      style: TextStyle(
                                        color: kPrimaryDark,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                      Icon(Icons.security_rounded, color: Colors.white,),
                                  ],
                                ),
                              );
                            },
                          ),
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
                                    return TitleText(title: "${currentState.urlScanReport.positives} / ${currentState.urlScanReport.total}");
                                  } else {
                                    return TitleText(title: "0"); //Return there is no link inside the report yet
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        //need to simplify this, create another class, use flatbutton and direct it to the details stuff
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
      ),
    );
  }
}
