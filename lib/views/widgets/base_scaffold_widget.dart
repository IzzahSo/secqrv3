import 'package:flutter/material.dart';

class BaseScaffoldWidget extends StatelessWidget {
  final String title;
  final Widget body;

  const BaseScaffoldWidget({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(child: body),
    );
  }
}
