import 'package:flutter/material.dart';
import 'package:secqrv3/themes/themes.dart';

showAlertDialogWithOneButton({
  BuildContext ? context,
  String ? title,
  IconData ? icon,
  String ? content,
  String ? buttonText,
  double ? size, }) {
  
  // set up the button
  Widget okButton = FlatButton(
    child: Text(
      buttonText!,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: size !* 2),
    ),
    onPressed: () {
      Navigator.of(context!).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(size * 2.3)),
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.red,
        ),
        SizedBox(
          width: size,
        ),
        Text(
          title!,
          style: TextStyle(fontSize: size * 2, fontWeight: FontWeight.bold),
        )
      ],
    ),
    content: Padding(
      padding: EdgeInsets.symmetric(horizontal: size * 2),
      child: Text(content!),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context!,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
