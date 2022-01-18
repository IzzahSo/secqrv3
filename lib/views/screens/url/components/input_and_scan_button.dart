import 'package:flutter/material.dart';
import 'package:secqrv3/views/viewmodel/bloc/url_scan_bloc.dart';
import 'package:secqrv3/views/viewmodel/events/url_scan_event.dart';
import 'package:secqrv3/views/widgets/components/alert_dialog.dart';
import 'package:secqrv3/views/widgets/components/input_container.dart';
import 'package:secqrv3/services/url_scan_service.dart';

import 'package:secqrv3/themes/themes.dart';
import 'package:secqrv3/views/widgets/components/SizeConfig.dart';

class InputAndScanButton extends StatelessWidget {
  const InputAndScanButton({ 
    Key? key, @required this.urlTextController, this.scanBloc,
   }) : super(key: key);

  final TextEditingController ? urlTextController;
  final UrlScanBloc ? scanBloc;

  @override
  Widget build(BuildContext context) {
    var defaultSize = SizeConfig.defaultSize;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: InputContainer(hinttext: "Input url link", myController: urlTextController,)),
        SizedBox(width:  defaultSize,),
        FlatButton(
          onPressed: () {
            var input = urlTextController!.text;
            if(input==""){
              showAlertDialogWithOneButton(
                context: context,
                title: "Inpur Url",
                icon: Icons.report_problem,
                content: "Please input the url you want to scan!",
                buttonText: "OK",
                size: defaultSize
              );
            } else if(UrlScanService.urlResource!=input){
              UrlScanService.urlResource = input;
              scanBloc?.add(FetchUrlScanReportEvent());
            }
          }, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultSize!*2),
          ),
          color: kPrimaryColor,
          child: Text("Check", style: Theme.of(context).textTheme.headline6?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: SizeConfig.defaultSize!*1.9,
          ),),
        ),
      ],
    );
  }
}
