import 'package:MobileApp/shared/nav_drawer.dart';
import 'package:MobileApp/theme/app.dart';
import 'package:flutter/material.dart';
// import 'package:toast/toast.dart';
import '../investors/investor_login.dart';

class VentureForm extends StatefulWidget {
  @override
  _VentureFormState createState() => _VentureFormState();
}

class _VentureFormState extends State<VentureForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        shape: appBarShape,
        centerTitle: true,
        title: Text(
          "Venture Portfolio",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: VentureFormBody(),
    );
  }
}

class VentureFormBody extends StatefulWidget {
  @override
  _VentureFormBodyState createState() => _VentureFormBodyState();
}

class _VentureFormBodyState extends State<VentureFormBody> {
  TextEditingController _website,
      _location,
      _ventureName,
      _vlinkedinProfile,
      _investment,
      _tagLine,
      _startupSummary;

  FocusNode _websiteNode,
      _locationNode,
      _tagLineNode,
      _investmentNode,
      _ventureNameNode,
      _vlinkedinProfileNode,
      _startupSummaryNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tagLine = new TextEditingController(text: "Witty tagline");
    _website = new TextEditingController(text: "https://website.com");
    _location = new TextEditingController(text: "Pune, India");
    _ventureName = new TextEditingController(text: "Invest Shrine");
    _investment = new TextEditingController(text: "15000000");
    _vlinkedinProfile =
        new TextEditingController(text: "https://vlinkedin.com/in");
    _startupSummary = new TextEditingController(
        text:
            "Investment platform, so that you can invest in your local community");

    _websiteNode = new FocusNode();
    _investmentNode = new FocusNode();
    _tagLineNode = new FocusNode();
    _locationNode = new FocusNode();
    _ventureNameNode = new FocusNode();
    _vlinkedinProfileNode = new FocusNode();
    _startupSummaryNode = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _websiteNode.unfocus();
        _locationNode.unfocus();
        _ventureNameNode.unfocus();
        _startupSummaryNode.unfocus();
        _vlinkedinProfileNode.unfocus();
        _investmentNode.unfocus();
        _tagLineNode.unfocus();
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
                  return "";
                },
                onChanged: (value) {
                  _formKey.currentState.validate();
                },
                controller: _website,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Website',
                  labelStyle: TextStyle(),
                ),
                focusNode: _websiteNode,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _location,
                validator: (value) {
                  if (value.isEmpty) return "Please enter a value";
                  return "";
                },
                onChanged: (value) {
                  _formKey.currentState.validate();
                },
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Location',
                  labelStyle: TextStyle(),
                ),
                focusNode: _locationNode,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _ventureName,
                maxLines: 1,
                readOnly: true,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Venture',
                  labelStyle: TextStyle(),
                ),
                focusNode: _ventureNameNode,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _investment,
                maxLines: 1,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Seed investment',
                  labelStyle: TextStyle(),
                ),
                focusNode: _investmentNode,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _startupSummary,
                maxLines: 4,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Startup Summary',
                  labelStyle: TextStyle(),
                ),
                focusNode: _startupSummaryNode,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _tagLine,
                maxLines: 3,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Tag line',
                  labelStyle: TextStyle(),
                ),
                focusNode: _tagLineNode,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _vlinkedinProfile,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'LinkedIn Profile',
                  labelStyle: TextStyle(),
                ),
                focusNode: _vlinkedinProfileNode,
              ),
              SizedBox(height: 40.0),
              Padding(
                padding: EdgeInsets.only(
                    right: loginMargin, bottom: 50.0, left: loginMargin),
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
