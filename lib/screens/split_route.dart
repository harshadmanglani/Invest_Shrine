import 'package:MobileApp/screens/investors/inv_login.dart';
import 'package:flutter/material.dart';

class SplitRoute extends StatefulWidget {
  @override
  _SplitRouteState createState() => _SplitRouteState();
}

class _SplitRouteState extends State<SplitRoute> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.only(left: loginMargin - 9, right: loginMargin - 9),
          child: Column(
            children: <Widget>[
              SizedBox(height: 140),
              // Image.asset(
              //   'assets/images/logo_loading.png',
              //   height: 180,
              //   width: 180,
              // ),
              SizedBox(height: 50),
              Center(
                  child: Text("Invest Shrine",
                      style: TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 40.0))),
              SizedBox(height: 10.0),
              Center(
                  child: Text("We fuel innovation.",
                      style: TextStyle(fontSize: 18))),
              SizedBox(height: 90.0),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: RaisedButton(
                      elevation: 4,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/investor_login');
                      },
                      child: Text("I'm an Investor",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: RaisedButton(
                      elevation: 4,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.transparent)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/entrepreneur_login');
                      },
                      child: Text("I'm an Entrepreneur",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.5,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
