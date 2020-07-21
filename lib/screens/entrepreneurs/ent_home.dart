import 'package:MobileApp/screens/entrepreneurs/inv_portfolio_list.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../../theme/colors.dart';

class EntrepreneurHome extends StatefulWidget {
  @override
  _EntrepreneurHomeState createState() => _EntrepreneurHomeState();
}

class _EntrepreneurHomeState extends State<EntrepreneurHome> {
  int _selectedIndex = 2;

  List<Widget> _widgetOptions = <Widget>[
    Container(),
    Container(),
    InvestorPortfolioList(),
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
        initialActiveIndex: 2, //optional, default as 0
        onTap: (int i) {
          _onItemTapped(i);
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
