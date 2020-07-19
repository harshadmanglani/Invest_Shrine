// import 'package:MobileApp/screens/entrepreneurs/entrepreneur_form.dart';
// import 'package:MobileApp/screens/entrepreneurs/venture_form.dart';
// import 'package:MobileApp/screens/investors/ven_portfolio_page.dart';
import 'package:MobileApp/shared/bottom_navbar.dart';
import 'package:flutter/material.dart';
// import 'ven_portfolio_list.dart';

class InvestorHome extends StatefulWidget {
  @override
  _InvestorHomeState createState() => _InvestorHomeState();
}

class _InvestorHomeState extends State<InvestorHome> {
  int buttonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavbar(onTap: (index) {
          setState(() {
            buttonIndex = index;
          });
        }),
        body: Container());
  }
}
