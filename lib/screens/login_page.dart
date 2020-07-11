import 'package:flutter/material.dart';
import '../theme/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _unfocusedColor = Colors.black54;
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          // padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            Image.asset('assets/logo.png'),
            // SizedBox(
            // height: 100.0,
            // ),
            // Text("Invest Shrine",
            // textAlign: TextAlign.center, style: TextStyle(fontSize: 40.0)),
            // SizedBox(height: 220.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                      color: _usernameFocusNode.hasFocus
                          ? Theme.of(context).accentColor
                          : _unfocusedColor),
                ),
                focusNode: _usernameFocusNode,
              ),
            ),
            // SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                      color: _passwordFocusNode.hasFocus
                          ? Theme.of(context).accentColor
                          : _unfocusedColor),
                ),
                focusNode: _passwordFocusNode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 20.0),
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                    child: Text(
                      'CANCEL',
                    ),
                    onPressed: () {
                      _usernameController.clear();
                      _passwordController.clear();
                    },
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(17.0))),
                    elevation: 3.0,
                    child: Text('NEXT', style: TextStyle(color: iconColor)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
