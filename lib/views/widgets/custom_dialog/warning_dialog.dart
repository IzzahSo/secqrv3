import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secqrv3/models/url_scan_report.dart';
import 'package:secqrv3/services/url_scan_service.dart';
import 'package:secqrv3/themes/themes.dart';
import 'package:secqrv3/viewmodel/bloc/url_scan_bloc.dart';
import 'package:secqrv3/viewmodel/states/url_scan_state.dart';
import 'package:secqrv3/views/widgets/components/output_text.dart';
import 'package:url_launcher/url_launcher.dart';

class WarningDialog extends StatelessWidget {
  final String qrcodeText;
  final Future<void> Function() resumeCamera;

  const WarningDialog(
    this.qrcodeText,
    this.resumeCamera,
  );

  void copyQrCodeTextToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: qrcodeText));
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('QR code text copied to clipboard!'),
        duration: Duration(milliseconds: 2500)));
  }

  // void launchUrlFromQrCodeText() async {
  //   await launch(qrcodeText);
  // }

  void dismissCustomDialog(BuildContext context) async {
    Navigator.pop(context, null);
    await resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.center,
      children: [
        AlertDialog(
            scrollable: true,
            backgroundColor: Colors.white,
            title: const Text("WARNING!\nThis is a Malicious Url", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),),
            content: Text("QR Code Text:\n" + qrcodeText + 
                      "\n\nPlease do not proceed to this site", 
                      style: TextStyle(color: kPrimaryDark),
                      ),
            
            actions: <TextButton>[
              TextButton(
                  onPressed: () => "",
                  child: const Text('Details')),
              TextButton(
                  onPressed: () => dismissCustomDialog(context),
                  child: const Text('Close'))
            ]),
        Positioned(
            top: 150,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 50,
              child: Icon(
                Icons.error,
                color: Colors.white,
                size: 60,
              ),
            )),
      ],
    );

    // return AlertDialog(
    //   scrollable: true,
    //   title: const Text('QR code text:'),
    //   content: Text(qrcodeText),
    //   actions: <TextButton>[
    //     TextButton(
    //         onPressed: () => copyQrCodeTextToClipboard(context),
    //         child: const Text('Copy')),
    //     if (canLaunchQrCodeText)
    //       TextButton(
    //           onPressed: launchUrlFromQrCodeText,
    //           child: const Text('Open')),
    //     TextButton(
    //         onPressed: () => dismissCustomDialog(context),
    //         child: const Text('Close'))
    //   ]);
  }
}
