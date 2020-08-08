import 'package:MobileApp/screens/entrepreneurs/ent_login.dart';
import 'package:MobileApp/screens/entrepreneurs/ent_platform.dart';
import 'package:MobileApp/screens/investors/inv_platform.dart';
import 'package:MobileApp/screens/split_route.dart';
import 'package:flutter/material.dart';
import 'theme/app.dart';
import 'screens/investors/inv_login.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
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
      debugShowCheckedModeBanner: false,
      theme: kAppTheme,
      routes: {
        '/investor_login': (BuildContext context) => InvestorLogin(),
        '/entrepreneur_login': (BuildContext context) => EntrepreneurLogin(),
        '/investor_platform': (BuildContext context) => InvestorPlatform(),
        '/entrepreneur_platform': (BuildContext context) =>
            EntrepreneurPlatform(),
        '/split_route': (BuildContext context) => SplitRoute(),
      },
      initialRoute: '/split_route',
    );
  }
}
