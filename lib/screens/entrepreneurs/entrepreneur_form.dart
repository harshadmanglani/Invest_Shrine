import 'package:MobileApp/shared/nav_drawer.dart';
import 'package:MobileApp/theme/app.dart';
import 'package:flutter/material.dart';
import '../login_page.dart';
import 'package:toast/toast.dart';

class EntrepreneurForm extends StatefulWidget {
  @override
  _EntrepreneurFormState createState() => _EntrepreneurFormState();
}

class _EntrepreneurFormState extends State<EntrepreneurForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        shape: appBarShape,
        centerTitle: true,
        title: Text(
          "Personal Portfolio",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: EntrepreneurFormBody(),
    );
  }
}

class EntrepreneurFormBody extends StatefulWidget {
  @override
  _EntrepreneurFormBodyState createState() => _EntrepreneurFormBodyState();
}

class _EntrepreneurFormBodyState extends State<EntrepreneurFormBody> {
  TextEditingController _firstName,
      _lastName,
      _ventureName,
      _linkedinProfile,
      _execSummary;

  FocusNode _firstNameNode,
      _lastNameNode,
      _ventureNameNode,
      _linkedinProfileNode,
      _execSummaryNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstName = new TextEditingController(text: "Aditya");
    _lastName = new TextEditingController(text: "Khandelwal");
    _ventureName = new TextEditingController(text: "Invest Shrine");
    _linkedinProfile =
        new TextEditingController(text: "https://linkedin.com/in");
    _execSummary = new TextEditingController(text: "4th year student at VIT");

    _firstNameNode = new FocusNode();
    _lastNameNode = new FocusNode();
    _ventureNameNode = new FocusNode();
    _linkedinProfileNode = new FocusNode();
    _execSummaryNode = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _firstNameNode.unfocus();
        _lastNameNode.unfocus();
        _ventureNameNode.unfocus();
        _execSummaryNode.unfocus();
        _linkedinProfileNode.unfocus();
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: loginMargin, right: loginMargin),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30.0),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Please enter a value";
                },
                onChanged: (value) {
                  _formKey.currentState.validate();
                },
                controller: _firstName,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'First Name',
                  labelStyle: TextStyle(),
                ),
                focusNode: _firstNameNode,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _lastName,
                validator: (value) {
                  if (value.isEmpty) return "Please enter a value";
                },
                onChanged: (value) {
                  _formKey.currentState.validate();
                },
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Last Name',
                  labelStyle: TextStyle(),
                ),
                focusNode: _lastNameNode,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _ventureName,
                maxLines: 1,
                readOnly: true,
                // onTap: () {
                //   Toast.show("Venture name cannot be changed", context,
                //       duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                // },
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Venture',
                  labelStyle: TextStyle(),
                ),
                focusNode: _ventureNameNode,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _execSummary,
                maxLines: 4,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Executive Summary',
                  labelStyle: TextStyle(),
                ),
                focusNode: _execSummaryNode,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _linkedinProfile,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'LinkedIn Profile',
                  labelStyle: TextStyle(),
                ),
                focusNode: _linkedinProfileNode,
              ),
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
                          child: Text('Update',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.file_upload,
                              color: Theme.of(context).iconTheme.color,
                            ))
                      ],
                    ),
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/investor_home');
                    if (_formKey.currentState.validate()) {
                      print("update to db");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
