import 'package:flutter/material.dart';
import 'package:secqrv3/themes/themes.dart';

class Input extends StatelessWidget {
  final TextEditingController _textEditingController;
  final VoidCallback _saveQrCode;
  const Input(this._textEditingController, this._saveQrCode);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _textEditingController,
        onSubmitted: (_) => _saveQrCode(),
        maxLength: 1050,
        cursorColor: kPrimaryDark,
        keyboardType: TextInputType.url,
        style: const TextStyle(color: kPrimaryDark, fontSize: 20),
        decoration: InputDecoration(
            labelText: 'Write a text, key or link to generate a QR Code',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryDark)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryDark))));
  }
}
