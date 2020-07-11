import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../theme/colors.dart';

class BottomNavbar extends StatefulWidget {
  final Function onTap;
  BottomNavbar({this.onTap});
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  Function onTap;

  @override
  void initState() {
    super.initState();
    onTap = widget.onTap;
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 800),
        color: navbarBackgroundColor,
        backgroundColor: backgroundColor,
        // buttonBackgroundColor: Theme.of(context).primaryColor,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.person_outline, size: 30),
          Icon(Icons.settings, size: 30)
        ],
        onTap: onTap);
  }
}
