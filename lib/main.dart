// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:secqrv3/themes/themes.dart';
import 'package:secqrv3/views/screens/checkurl.dart';
import 'package:secqrv3/views/screens/generate_qr.dart';
import 'package:secqrv3/views/screens/homepage.dart';
// import 'package:secqrv3/views/widgets/snake_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SnakeBarBehaviour _snakeBarStyle = SnakeBarBehaviour.floating;

  final SnakeShape _snakeShape = SnakeShape.circle;

  final ShapeBorder _bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );

  final EdgeInsets _padding = const EdgeInsets.all(12);

  final Color _unselectedColor = kSecondaryDark;

  final bool _showSelectedLabels = false;

  final bool _showUnselectedLabels = false;

  int _selectedItemPosition = 1;

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.qr_code_rounded), label: 'QR Generator'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.qr_code_scanner_rounded), label: 'QR Scanner'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.check_circle_outline_rounded), label: 'Check link'),
  ];

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: kPrimaryColor,
        systemNavigationBarColor: kPrimaryLight));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'SecQR',
      debugShowCheckedModeBanner: false,
      theme: Dark().theme,
      home: Scaffold(
        body: _selectedItemPosition ==0 
            ? const GenerateQR()
            : _selectedItemPosition == 1
              ? HomePage()
              : const CheckURL(),

        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: _snakeBarStyle,
          snakeShape: _snakeShape,
          shape: _bottomBarShape,
          padding: _padding,
          unselectedItemColor: _unselectedColor,
          showSelectedLabels: _showSelectedLabels,
          backgroundColor: kSecondaryLight,

          showUnselectedLabels: _showUnselectedLabels,
          currentIndex: _selectedItemPosition,
          onTap: (index) => setState(() => {
                _selectedItemPosition = index,
              }),
          items: _bottomNavigationBarItems,
          snakeViewColor: kSecondaryDark,
        ),
      ),
    );
  }
}
