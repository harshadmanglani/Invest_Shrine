import 'package:MobileApp/screens/investors/beeps_page.dart';
import 'package:MobileApp/screens/investors/saved_ven.dart';
import 'package:MobileApp/screens/old/ven_portfolio_list.dart';
import 'package:MobileApp/screens/investors/ven_search.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class InvestorHome extends StatefulWidget {
  @override
  _InvestorHomeState createState() => _InvestorHomeState();
}

class _InvestorHomeState extends State<InvestorHome> {
  int _selectedIndex = 2;

  List<Widget> _widgetOptions = <Widget>[
    Container(),
    VentureSearch(),
    VenturePortfolioList(),
    BeepsPage(),
    SavedVentures()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.white,
        activeColor: navbarBackgroundColor,
        color: navbarBackgroundColor,
        style: TabStyle.custom,
        items: [
          TabItem(icon: Icons.account_balance, title: 'Events'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.notifications, title: 'Beeps'),
          TabItem(icon: Icons.bookmark_border, title: 'Saved'),
        ],
        initialActiveIndex: _selectedIndex, //optional, default as 0
        onTap: (int i) {
          _onItemTapped(i);
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
