// ignore_for_file: unnecessary_new

import 'dart:typed_data';
// import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:secqrv3/AESEncrypt/aes.dart';
import 'package:secqrv3/repository/database_serv.dart';
import 'package:secqrv3/themes/themes.dart';
import 'package:secqrv3/views/screens/encrypt_qr/encrypt_qr_screen.dart';
// import 'package:secqrv3/views/widgets/encrypt_button.dart';
import 'package:secqrv3/views/widgets/input.dart';
import 'package:screenshot/screenshot.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:secqrv3/views/widgets/save_button.dart';


class GenerateQR extends StatefulWidget {
  const GenerateQR();

  @override
  _GenerateQRState createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  final TextEditingController textEditingController = TextEditingController();
  final ScreenshotController screenshotController = ScreenshotController();
  PermissionStatus storagePermissionStatus = PermissionStatus.denied;

  void notifyUserWithSnackBar(String message, int milliseconds) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: milliseconds)));
  }

  // void encryptCode(String text) {
  //   if (textEditingController.text.isNotEmpty){
  //     encryption.encryptMsg(textEditingController.text).base16;
  //     FirestoreProvider().updateText(
  //         title: "Generated QR", qrCodeText: textEditingController.text,);
  //   }
  // }

  void saveQrCode() {
    if (storagePermissionStatus.isGranted &&
        textEditingController.text.isNotEmpty)
      screenshotController.capture().then((Uint8List? qrcodeImage) async {
        if (qrcodeImage != null) {
          final String captureTimestamp = new DateTime.now().toString();
          await ImageGallerySaver.saveImage(Uint8List.fromList(qrcodeImage),
              quality: 100, name: captureTimestamp);
          notifyUserWithSnackBar('QR code saved in your gallery!', 1500);
        }
      });
    else
      requestStoragePermission();
    if (storagePermissionStatus.isPermanentlyDenied)
      notifyUserWithSnackBar(
          'Please grant storage permission to save QR codes.', 4000);
  }

  void requestStoragePermission() async {
    await Permission.storage
        .request()
        .then((PermissionStatus permissionStatus) => {
              this.setState(() {
                storagePermissionStatus = permissionStatus;
              })
            });
  }

  void refreshOnTextFieldTextChange() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    textEditingController.addListener(() {
      refreshOnTextFieldTextChange();
    });

    final bool notHaveStoragePermission =
        storagePermissionStatus != PermissionStatus.granted;
    if (notHaveStoragePermission) requestStoragePermission();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Generate QR'),),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(20),
                child: Input(textEditingController, saveQrCode)),
            const SizedBox(height: 20),
            Screenshot(
                controller: screenshotController,
                child: QrImage(
                    data: textEditingController.text,
                    size: 250,
                    backgroundColor: Colors.white)),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: FlatButton(
                color: kSecondaryDark,
                onPressed: () => Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => EncryptQRScreen())
                ), 
                child: const Text('AES Encrypt QR', style: TextStyle(color: Colors.white),)),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: EncryptButton(saveQrCode),
            // ),
            // Padding(
            //     padding: const EdgeInsets.all(20), child: SaveButton(saveQrCode)),
          ]),
    );
  }
}
