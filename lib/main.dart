import 'package:MobileApp/screens/investors/portfolio_page.dart';
import 'package:flutter/material.dart';
import 'theme/app.dart';
import 'screens/login_page.dart';
import 'screens/investors/home_page.dart';
import 'screens/investors/portfolio_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kAppTheme,
      routes: {
        '/login': (BuildContext context) => LoginPage(),
        '/investor_home': (BuildContext context) => HomePage(),
        '/venture_portfolio_list': (BuildContext context) => PortfolioList(),
        '/venture_portfolio': (BuildContext context) => PortfolioPage()
      },
      initialRoute: '/login',
    );
  }
}
