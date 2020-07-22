import 'package:MobileApp/screens/investors/investor_login.dart';
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
        body: Container(
            child: Padding(
          padding:
              EdgeInsets.only(left: loginMargin - 9, right: loginMargin - 9),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              Image.asset(
                'assets/images/logo_loading.png',
                height: 180,
                width: 180,
              ),
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
              Row(
                children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                          elevation: 4,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/investor_login');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text("I'm an Investor",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                          )),
                      flex: 1),
                  SizedBox(width: 13),
                  Expanded(
                      child: RaisedButton(
                          elevation: 4,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/entrepreneur_login');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 2.0, right: 2.0, top: 5, bottom: 5.0),
                            child: Text("I'm an Entrepreneur",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.5)),
                          )),
                      flex: 1)
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
