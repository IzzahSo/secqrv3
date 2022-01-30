// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:secqrv3/themes/themes.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback _saveQrCode;
  const SaveButton(this._saveQrCode);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: _saveQrCode,
      child: Text(
        'Save AES QR',
        style: TextStyle(color: Colors.white),
      ),
      color: kSecondaryDark,
    );
        // style: ButtonStyle(
        //     backgroundColor:
        //         MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
        //     padding:
        //         MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0))),
        // child: Row(children: <Widget>[
        //   Expanded(
        //       child: Container(
        //           height: 50,
        //           child: const Center(
        //               child: Text('Save',
        //                   style: TextStyle(
        //                       color: Colors.white, fontSize: 22))))),
        //   Container(
        //       height: 50,
        //       width: 50,
        //       color: const Color.fromRGBO(0, 0, 0, 0.5),
        //       child: const Center(child: Icon(Icons.save)))
        // ]));
  }
}
