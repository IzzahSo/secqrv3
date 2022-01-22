

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secqrv3/models/url_scan_report.dart';
import 'package:secqrv3/services/url_scan_service.dart';
import 'package:secqrv3/views/viewmodel/bloc/url_scan_bloc.dart';
import 'package:secqrv3/views/viewmodel/states/url_scan_state.dart';
import 'package:secqrv3/views/widgets/components/output_text.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDialog extends StatelessWidget {
  final String qrcodeText;
  final bool canLaunchQrCodeText;
  final Future<void> Function() resumeCamera;


  const CustomDialog(
      this.qrcodeText, this.canLaunchQrCodeText, this.resumeCamera,);

  void copyQrCodeTextToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: qrcodeText));
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('QR code text copied to clipboard!'),
        duration: Duration(milliseconds: 2500)));
  }

  void launchUrlFromQrCodeText() async {
    await launch(qrcodeText);
  }

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
          title: const Text("QR code text:"),
          content: Text(qrcodeText) ,
          actions: <TextButton>[
            TextButton(
              onPressed: () => copyQrCodeTextToClipboard(context),
              child: const Text('Copy')),
          if (canLaunchQrCodeText)
            TextButton(
                onPressed: launchUrlFromQrCodeText,
                child: const Text('Open')),
          TextButton(
              onPressed: () => dismissCustomDialog(context),
              child: const Text('Close'))
        ]),
        Positioned(
          top: 170,
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: 40,
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 60,
            ),
          )
        ),
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
