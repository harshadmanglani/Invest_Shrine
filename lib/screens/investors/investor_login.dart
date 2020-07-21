import 'package:flutter/material.dart';
import '../../theme/colors.dart';

double loginMargin = 30.0;

class InvestorLogin extends StatefulWidget {
  @override
  _InvestorLoginState createState() => _InvestorLoginState();
}

class _InvestorLoginState extends State<InvestorLogin> {
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
        child: GestureDetector(
          onTap: () {
            _usernameFocusNode.unfocus();
            _passwordFocusNode.unfocus();
          },
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              // Image.asset(
              //   'assets/images/logo_loading.png',
              //   height: 180,
              //   width: 180,
              // ),
              SizedBox(height: 180),
              SizedBox(height: 10.0),
              Center(
                  child: Text("Invest Shrine",
                      style: TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 40.0))),
              SizedBox(height: 10.0),
              Center(
                  child: Text("We fuel innovation.",
                      style: TextStyle(fontSize: 18))),
              SizedBox(height: 20.0),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(loginMargin, 0.0, loginMargin, 10.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    isDense: true,
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: _usernameFocusNode.hasFocus
                            ? Theme.of(context).primaryColor
                            : _unfocusedColor),
                  ),
                  focusNode: _usernameFocusNode,
                ),
              ),
              SizedBox(height: 5.0),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(loginMargin, 0.0, loginMargin, 0.0),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    isDense: true,
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: _passwordFocusNode.hasFocus
                            ? Theme.of(context).accentColor
                            : _unfocusedColor),
                  ),
                  focusNode: _passwordFocusNode,
                ),
              ),
              // SizedBox(height: 10.0),
              ButtonBar(children: <Widget>[
                FlatButton(
                    padding: EdgeInsets.only(right: loginMargin),
                    child: Text("Forgot password?",
                        style: TextStyle(color: navbarBackgroundColor)),
                    onPressed: () {})
              ]),
              SizedBox(height: 40.0),
              Padding(
                padding: EdgeInsets.only(
                    right: loginMargin, top: 0.0, left: loginMargin),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(27.0))),
                  elevation: 3.0,
                  child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 12,
                          child: Text('Continue',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  color: iconColor,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).iconTheme.color,
                            ))
                      ],
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/investor_home', (Route<dynamic> route) => false);
                  },
                ),
              ),
              SizedBox(height: 10.0),
              // Divider(
              //   color: Colors.grey,
              //   thickness: 2.0,
              //   indent: loginMargin,
              //   endIndent: loginMargin,
              // ),
              // SizedBox(height: 10.0),
              // Padding(
              //   padding: EdgeInsets.only(
              //       right: loginMargin, top: 0.0, left: loginMargin),
              //   child: RaisedButton(
              //     color: Colors.white,
              //     shape: RoundedRectangleBorder(
              //         side: BorderSide(color: Colors.grey, width: 1.5),
              //         borderRadius: BorderRadius.all(Radius.circular(27.0))),
              //     elevation: 3.0,
              //     child: Padding(
              //       padding: EdgeInsets.all(14.0),
              //       child: Row(
              //         children: <Widget>[
              //           Expanded(
              //             flex: 12,
              //             child: Text('Sign in with Google',
              //                 style: TextStyle(
              //                     fontSize: 17.0,
              //                     color: Colors.grey[600],
              //                     fontWeight: FontWeight.w600)),
              //           ),
              //           Expanded(
              //             flex: 1,
              //             child: Image.asset(
              //               'assets/images/google_icon.png',
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //     onPressed: () {
              //       Navigator.pushNamed(context, '/investor_home');
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
