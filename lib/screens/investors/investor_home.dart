import 'package:MobileApp/screens/investors/ven_portfolio_list.dart';
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
    Container(),
    Container()
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
        style: TabStyle.reactCircle,
        items: [
          TabItem(icon: Icons.bookmark_border, title: 'Saved'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person_outline, title: 'Portfolio'),
          TabItem(icon: Icons.settings, title: 'Settings'),
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
