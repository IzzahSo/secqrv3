import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:secqrv3/themes/themes.dart';
// import 'base_scaffold_widget.dart';

class SnakeNavigationBarWidget extends StatefulWidget {
  const SnakeNavigationBarWidget({Key? key}) : super(key: key);

  @override
  _SnakeNavigationBarWidgetState createState() =>
      _SnakeNavigationBarWidgetState();
}

class _SnakeNavigationBarWidgetState extends State<SnakeNavigationBarWidget> {
  final SnakeBarBehaviour _snakeBarStyle = SnakeBarBehaviour.floating;
  final SnakeShape _snakeShape = SnakeShape.circle;

  final ShapeBorder? _bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );

  final EdgeInsets _padding = const EdgeInsets.all(12);

  final Color _unselectedColor = Colors.grey;
  final Color selectedColor = kPrimaryDark;

  final Color containerColor = kPrimaryLight;

  final bool _showSelectedLabels = false;
  final bool _showUnselectedLabels = false;

  int _selectedItemPosition = 1;

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.qr_code_scanner_rounded), label: 'QR Scanner'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.qr_code_rounded), label: 'QR Generator'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.history_rounded), label: 'History'),
  ];

  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      behaviour: _snakeBarStyle,
      snakeShape: _snakeShape,
      shape: _bottomBarShape,
      padding: _padding,
      unselectedItemColor: _unselectedColor,
      backgroundColor: kPrimaryColor,
      showSelectedLabels: _showSelectedLabels,
      showUnselectedLabels: _showUnselectedLabels,
      currentIndex: _selectedItemPosition,
      onTap: (index) => setState(() => {
            _selectedItemPosition = index,
          }),
      items: _bottomNavigationBarItems,
    );
  }
}
