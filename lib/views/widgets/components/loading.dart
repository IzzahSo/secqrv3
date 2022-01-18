import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key ? key,
    this.imageloading,
  }) : super(key: key);

  final String ? imageloading;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(imageloading!),
    );
  }
}
