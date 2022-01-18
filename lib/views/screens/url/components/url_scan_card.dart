import 'package:flutter/material.dart';
import 'package:secqrv3/models/url_scan.dart';

import 'package:secqrv3/views/widgets/components/SizeConfig.dart';
import 'package:secqrv3/themes/themes.dart';

class UrlScanCard extends StatelessWidget {
  const UrlScanCard({ 
    Key ? key, required this.urlScan 
  }) : super(key: key);

  final UrlScan urlScan;

  @override
  Widget build(BuildContext context) {
    var defaultSize = SizeConfig.defaultSize!;
    return ClipPath(
      clipper: UrlCardClipper(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: defaultSize*2, horizontal: defaultSize),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              urlScan.keyname, 
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: defaultSize * 1.8, fontWeight: FontWeight.bold),
            ),
            Text(urlScan.result, style: TextStyle(fontSize: defaultSize * 1.8)),
            Align(
                alignment: Alignment.center,
                child: urlScan.detected
                    ? Icon(
                        Icons.error,
                        color: Colors.red,
                        size: defaultSize * 3,
                      )
                    : Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: defaultSize * 3,
                      ))
          ],
        ),
      ),
    );
  }
}

class UrlCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double width = size.width;
    double height = size.height;
    double cornerside = 20;
    path.lineTo(0, height - cornerside);
    path.quadraticBezierTo(0, height, cornerside, height);
    path.lineTo(width - cornerside * 3, height);
    path.quadraticBezierTo(width, height, width, height - cornerside * 3);
    path.lineTo(width, cornerside);
    path.quadraticBezierTo(width, 0, width - cornerside, 0);
    path.lineTo(cornerside * 3, 0);
    path.quadraticBezierTo(0, 0, 0, cornerside * 3);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
