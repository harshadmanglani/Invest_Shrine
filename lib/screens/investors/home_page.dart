import 'package:MobileApp/screens/investors/portfolio_page.dart';
import 'package:MobileApp/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'portfolio_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int buttonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavbar(onTap: (index) {
          setState(() {
            buttonIndex = index;
          });
        }),
        body: buttonIndex == 0
            ? PortfolioList()
            : buttonIndex == 2 ? PortfolioPage() : Container());
  }
}
