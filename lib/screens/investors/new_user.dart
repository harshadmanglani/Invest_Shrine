import 'package:flutter/material.dart';
import 'inv_login.dart';

class NewUserForm extends StatefulWidget {
  @override
  _NewUserFormState createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  TextEditingController _username, _email, _password, _confirmPassword;

  FocusNode _usernameNode, _emailNode, _passwordNode, _confirmPasswordNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Sign up as an Investor",
              style: TextStyle(color: Colors.white))),
      body: GestureDetector(
        onTap: () {
          _usernameNode.unfocus();
          _passwordNode.unfocus();
          _confirmPasswordNode.unfocus();
          _emailNode.unfocus();
        },
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(left: loginMargin, right: loginMargin),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return "Please enter a value";
                        return "";
                      },
                      onChanged: (value) {
                        _formKey.currentState.validate();
                      },
                      controller: _email,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Email',
                        labelStyle: TextStyle(),
                      ),
                      focusNode: _emailNode,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _username,
                      validator: (value) {
                        if (value.isEmpty) return "Please enter a value";
                        return "";
                      },
                      onChanged: (value) {
                        _formKey.currentState.validate();
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Username',
                        labelStyle: TextStyle(),
                      ),
                      focusNode: _usernameNode,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _password,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Password',
                        labelStyle: TextStyle(),
                      ),
                      focusNode: _passwordNode,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _confirmPassword,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(),
                      ),
                      focusNode: _confirmPasswordNode,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
