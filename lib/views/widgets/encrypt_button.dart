// ignore_for_file: unused_field, deprecated_member_use, sized_box_for_whitespace

import 'package:flutter/material.dart';
// import 'package:secqr/AESEncrypt/AES.dart';

class EncryptButton extends StatelessWidget {
  // final String text;
  // EncryptButton(this.text);
  final VoidCallback _saveQrCode;
  const EncryptButton(this._saveQrCode);

  // AESEncryption encryption = new AESEncryption();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        // onPressed: encryption.encryptMsg(text).base16,
        onPressed: _saveQrCode,
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Theme.of(context).accentColor),
            padding:
                MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0))),
        child: Row(children: <Widget>[
          Expanded(
              child: Container(
                  height: 50,
                  child: const Center(
                      child: Text('Encrypt QR with AES',
                          style: TextStyle(
                              color: Colors.white, fontSize: 22))))),
          Container(
              height: 50,
              width: 50,
              color: const Color.fromRGBO(0, 0, 0, 0.5),
              child: const Center(child: Icon(Icons.enhanced_encryption_rounded)))
        ]));
  }
}
