import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:secqrv3/views/widgets/grant_permission_button.dart';
import 'package:secqrv3/views/widgets/custom_dialog.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen();

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrViewKey = GlobalKey();
  final ImagePicker imagePicker = ImagePicker();
  QRViewController? qrViewController;
  PermissionStatus cameraPermissionStatus = PermissionStatus.denied;
  bool isFlashlightOff = false;

  void showCustomDialog(String barcodeText) async {
    final bool canLaunchUrl = await canLaunch(barcodeText);
    showDialog(
        context: context,
        builder: (_) => CustomDialog(
            barcodeText, canLaunchUrl, qrViewController!.resumeCamera),
        barrierDismissible: false,
        useSafeArea: true);
  }

  Widget _buildQrView(BuildContext context){
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrViewKey,
      // You can choose between CameraFacing.front or CameraFacing.back. Defaults to CameraFacing.back
      // cameraFacing: CameraFacing.front,
      onQRViewCreated: _onQRViewCreated,
      // Choose formats you want to scan. Defaults to all formats.
      // formatsAllowed: [BarcodeFormat.qrcode],
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController qrViewController) {
    setState(() {
      this.qrViewController = qrViewController;
    });
    qrViewController.scannedDataStream.listen((Barcode barcode) async {
      await qrViewController.pauseCamera();
      showCustomDialog(barcode.code.toString());
    });
  }

  void toggleCameraFlash() async {
    await qrViewController?.toggleFlash();
    setState(() {
      this.isFlashlightOff = !this.isFlashlightOff;
    });
  }

  void flipCamera() async {
    await qrViewController?.flipCamera();
  }

  void scanImageFromGallery() async {
    await qrViewController?.pauseCamera();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      String barcodeText = await QrCodeToolsPlugin.decodeFrom(image.path);
      showCustomDialog(barcodeText);
    } else
      qrViewController?.resumeCamera();
  }

  void requestCameraPermission() async {
    await Permission.camera
        .request()
        .then((PermissionStatus permissionStatus) => {
              // ignore: unnecessary_this
              this.setState(() {
                cameraPermissionStatus = permissionStatus;
              })
            });
  }

  @override
  void initState() {
    super.initState();

    final bool notHaveCameraPermission =
        cameraPermissionStatus != PermissionStatus.granted;
    if (notHaveCameraPermission) requestCameraPermission();
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());

    if (cameraPermissionStatus.isGranted)
      return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),
            Expanded(
                flex: 1,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Positioned(
                      bottom: 20,
                      width: 200,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(isFlashlightOff
                                    ? Icons.flash_off
                                    : Icons.flash_on),
                                color: Colors.white,
                                onPressed: toggleCameraFlash),
                            IconButton(
                                icon: const Icon(Icons.cameraswitch),
                                color: Colors.white,
                                onPressed: flipCamera),
                            IconButton(
                                icon: const Icon(Icons.photo_library),
                                color: Colors.white,
                                disabledColor:
                                    const Color.fromRGBO(255, 255, 255, 0.3),
                                onPressed: scanImageFromGallery)
                        ])),
                  ]),
            ),
          ],
        ),
          // child: Stack(
          //   fit: StackFit.expand,
          //   alignment: AlignmentDirectional.bottomCenter,
          //   children: <Widget>[
          //     QRView(
          //         key: qrViewKey,
          //         onQRViewCreated: onQRViewCreated,
          //         overlay: QrScannerOverlayShape(borderColor: Colors.white)),
          //     Positioned(
          //         bottom: 20,
          //         width: 200,
          //         child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: <Widget>[
          //               IconButton(
          //                   icon: Icon(isFlashlightOff
          //                       ? Icons.flash_off
          //                       : Icons.flash_on),
          //                   color: Colors.white,
          //                   onPressed: toggleCameraFlash),
          //               IconButton(
          //                   icon: const Icon(Icons.cameraswitch),
          //                   color: Colors.white,
          //                   onPressed: flipCamera),
          //               IconButton(
          //                   icon: const Icon(Icons.photo_library),
          //                   color: Colors.white,
          //                   disabledColor:
          //                       const Color.fromRGBO(255, 255, 255, 0.3),
          //                   onPressed: scanImageFromGallery)
          //             ]))
          //   ]),
      );
    else if (cameraPermissionStatus.isDenied)
      return Center(child: GrantPermissionButton(requestCameraPermission));
    else
      return const Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                  'Please grant camera permission to scan QR codes.',
                  style: TextStyle(color: Colors.white, fontSize: 20))));
  }
}
