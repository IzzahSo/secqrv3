import 'package:flutter/material.dart';
import 'package:secqrv3/themes/themes.dart';
import 'scan_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('SecQR'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/secqr.png'),
            flatButton('Scan QR CODE', const ScanScreen()),
            const SizedBox(height: 20.0),
            // flatButton('Generate QR CODE', GenerateQR()),
          ],
        ),
      ),
    ));
  }

  Widget flatButton(String text, Widget widget) {
    // ignore: deprecated_member_use
    return FlatButton(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        focusColor: kPrimaryColor,
        highlightColor: kSecondaryColor,
        hoverColor: kSecondaryLight,
        splashColor: Colors.blueGrey,
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => widget));
        },
        // ignore: sort_child_properties_last
        child: Text(
          text,
          style: const TextStyle(
              color: kPrimaryDark, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: kSecondaryDark, width: 3.0),
          borderRadius: BorderRadius.circular(15.0),
        ));
  }
}
