// ignore_for_file: unnecessary_new

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:secqrv3/AESEncrypt/aes.dart';
import 'package:secqrv3/themes/themes.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:secqrv3/views/screens/encrypt_qr/scan_encrypt_qr.dart';
import 'package:secqrv3/views/widgets/save_button.dart';

class EncryptQRScreen extends StatefulWidget {
  const EncryptQRScreen();

  @override
  _EncryptQRScreenState createState() => _EncryptQRScreenState();
}


class _EncryptQRScreenState extends State<EncryptQRScreen> {
  
  final TextEditingController myController = TextEditingController();
  final ScreenshotController screenshotController = ScreenshotController();
  PermissionStatus storagePermissionStatus = PermissionStatus.denied;

  String qrData = " ";
  AESEncryption encryption = new AESEncryption();

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
    if (storagePermissionStatus.isGranted)
      screenshotController.capture().then((Uint8List? qrcodeImage) async {
        if (qrcodeImage != null) {
          // final String captureTimestamp = new DateTime.now().toString();
          await ImageGallerySaver.saveImage(Uint8List.fromList(qrcodeImage),
              quality: 100, name: "Encrypted QR");
          notifyUserWithSnackBar('AES QR code saved in your gallery!', 1500);
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

    myController.addListener(() {
      refreshOnTextFieldTextChange();
    });

    final bool notHaveStoragePermission =
        storagePermissionStatus != PermissionStatus.granted;
    if (notHaveStoragePermission) requestStoragePermission();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final VoidCallback _saveQrCode;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Encrypt QR with AES'),
      ),
      body: SafeArea(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: myController,
                maxLength: 1050,
                cursorColor: kPrimaryDark,
                keyboardType: TextInputType.url,
                style: const TextStyle(color: kPrimaryDark, fontSize: 20),
                // onSubmitted: (_) => saveQrCode(),
                decoration: InputDecoration(
                    labelText: 'Write a text, key to generate an encrypted AES QR Code',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                    filled: true,
                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryDark)),
                    focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryDark)
                  )
               ),
              //  onEditingComplete: ,
              ),
            ),
            const SizedBox(height: 15,),
            Screenshot(
              controller: screenshotController,
              child: QrImage(
                data: encryption.encryptMsg(qrData).base64,
                size: 250,
                backgroundColor: Colors.white, 
              ),
            ),
            // const SizedBox(height: 20,),
            // Text(encryption.encryptMsg(myController.text).base16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: FlatButton(
                    child: Text('Generate AES QR', style: TextStyle(color: Colors.white),),
                    color: kSecondaryDark,
                    onPressed: () => setState(() {
                      qrData = myController.text.trim();
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  //Somehow it didn't save ? Need to tweak some coding in saveQrCode fx
                  child: SaveButton(saveQrCode),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            FlatButton(
              child: Text(
                'Scan Encrypted QR',
                style: TextStyle(color: Colors.white),
              ),
              color: kSecondaryDark,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScanEncryptQR())),
            ),
            const SizedBox(height: 20,), 
            if(qrData != "") 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('AES Encrypted QR Text: ', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              encryption.encryptMsg(qrData).base64,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                            
                        //     encryption.decryptMsg(encryption.getCode(qrData)).toString(),
                        //     style: TextStyle(fontSize: 15.0),
                        //   ),
                        // ),
                        ],
                      ),
                    )),
                ],
              ),
            
            // const SizedBox(height: 20,),
            // FlatButton(
            //   onPressed: saveQrCode, 
            //   child: const Text(
            //     'Save', 
            //     style: TextStyle(color: kPrimaryLight) ,
            //   ), 
            //   color: kPrimaryDark,)
          ],
          
        ),
      ),
    );
  }
}