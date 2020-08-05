import 'package:MobileApp/screens/investors/inv_home_page.dart';
import 'package:MobileApp/screens/investors/ven_search.dart';
import 'package:MobileApp/screens/old/beeps_page.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';

class InvestorPlatform extends StatefulWidget {
  @override
  _InvestorPlatformState createState() => _InvestorPlatformState();
}

class _InvestorPlatformState extends State<InvestorPlatform> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    InvestorHomePage(),
    VentureSearch(),
    BeepsPage(),
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
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          selectedItemColor: navbarBackgroundColor,
          unselectedItemColor: Colors.grey[500],
          // selectedLabelStyle: TextStyle(color: Colors.black),
          // unselectedLabelStyle: TextStyle(color: Colors.grey),
          // selectedIconTheme: IconThemeData(color: Colors.black),
          // unselectedIconTheme: IconThemeData(color: Colors.grey),
          onTap: (index) {
            _onItemTapped(index);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text("Search")),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), title: Text("Beeps")),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark), title: Text("Saved"))
          ]),
    );
  }
}
