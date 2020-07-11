import 'package:MobileApp/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'portfolio_list.dart';
import '../../theme/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int buttonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
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
          onTap: (index) {
            setState(() {
              buttonIndex = index;
            });
          },
        ),
        body: buttonIndex == 0 ? PortfolioList() : Container());
  }
}
