import 'package:MobileApp/screens/entrepreneurs/beeps_page.dart';
import 'package:MobileApp/screens/entrepreneurs/ent_home_page.dart';
import 'package:MobileApp/shared/nav_drawer.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class EntrepreneurPlatform extends StatefulWidget {
  @override
  _EntrepreneurPlatformState createState() => _EntrepreneurPlatformState();
}

class _EntrepreneurPlatformState extends State<EntrepreneurPlatform> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    EntrepreneurHomePage(),
    BeepsPage(),
    Container()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> labels = ["Home", "Beeps", "Saved"];
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
                      child: Image.asset(
                        'assets/images/ent.jpg',
                        height: 50,
                        width: 50,
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
            showUnselectedLabels: false,
            unselectedItemColor: Colors.grey[500],
            onTap: (index) {
              _onItemTapped(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text("Home")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), title: Text("Beeps")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), title: Text("Saved"))
            ]),
      ),
    );
  }
}
