import 'package:MobileApp/screens/investors/inv_home_page.dart';
import 'package:MobileApp/screens/investors/saved_ven.dart';
import 'package:MobileApp/screens/investors/ven_search.dart';
import 'package:MobileApp/screens/investors/beeps_page.dart';
import 'package:MobileApp/shared/nav_drawer.dart';
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
    SavedVentures()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> labels = ["Home", "Search", "Beeps", "Saved"];
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: NavDrawer(),
        body: Column(
          children: <Widget>[
            SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: FlatButton.icon(
                          onPressed: () {
                            _scaffoldKey.currentState.openDrawer();
                          },
                          icon: Icon(Icons.menu),
                          label: Container(
                            height: 0,
                            width: 0,
                          )),
                    ),
                  ),
                  Expanded(
                      flex: 10,
                      child: Text(
                        labels.elementAt(_selectedIndex),
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      )),
                  Expanded(
                      flex: 3,
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2016/09/16/09/21/money-1673582_1280.png',
                        height: 35,
                        width: 35,
                      )),
                ],
              ),
            ),
            Expanded(flex: 35, child: _widgetOptions.elementAt(_selectedIndex)),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: navbarBackgroundColor,
            unselectedItemColor: Colors.grey[500],
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
      ),
    );
  }
}
