import 'package:MobileApp/shared/nav_drawer.dart';
import 'package:MobileApp/theme/app.dart';
import 'package:flutter/material.dart';

class BeepsPage extends StatefulWidget {
  @override
  _BeepsPageState createState() => _BeepsPageState();
}

class _BeepsPageState extends State<BeepsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(title: Text("Beeps"), shape: appBarShape),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) => Text("Hi"),
          itemCount: 5,
        ),
      ),
    );
  }
}
