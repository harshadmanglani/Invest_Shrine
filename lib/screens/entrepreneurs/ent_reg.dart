import 'package:MobileApp/models/entrepreneurs/ent_user.dart';
import 'package:flutter/material.dart';
import 'ent_login.dart';
import 'package:validators/validators.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:MobileApp/theme/colors.dart';

class EntrepreneurRegistrationForm extends StatefulWidget {
  @override
  _EntrepreneurRegistrationFormState createState() =>
      _EntrepreneurRegistrationFormState();
}

class _EntrepreneurRegistrationFormState
    extends State<EntrepreneurRegistrationForm> {
  EntrepreneurUserModel entrepreneurUserModel;

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print(pickedFile.path);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  String _selectedLocation;

  List<String> _locations = ['Pune', 'Bangalore', 'Chennai', 'Delhi'];
  FocusNode _usernameNode,
      _emailNode,
      _passwordNode,
      _firstNameNode,
      _lastNameNode,
      _execSummaryNode,
      _linkedinNode,
      _twitterNode,
      _facebookNode;
  int form = 1;
  final _firstFormKey = GlobalKey<FormState>();
  final _secondFormKey = GlobalKey<FormState>();

  incrementForm() {
    switch (form) {
      case 1:
        if (_firstFormKey.currentState.validate())
          setState(() {
            form = 2;
          });
        break;

      case 2:
        if (_secondFormKey.currentState.validate())
          setState(() {
            print("submit form");
          });
        break;
    }
  }

  decrementForm() {
    if (form != 1)
      setState(() {
        form--;
      });
  }

  unfocusAllNodes() {
    _usernameNode.unfocus();
    _emailNode.unfocus();
    _passwordNode.unfocus();
    _firstNameNode.unfocus();
    _lastNameNode.unfocus();
    _execSummaryNode.unfocus();
    _linkedinNode.unfocus();
    _twitterNode.unfocus();
    _facebookNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
    entrepreneurUserModel = EntrepreneurUserModel();
    _usernameNode = FocusNode();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    _firstNameNode = FocusNode();
    _lastNameNode = FocusNode();
    _execSummaryNode = FocusNode();
    _linkedinNode = FocusNode();
    _twitterNode = FocusNode();
    _facebookNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Sign up as an Entrepreneur",
              style: TextStyle(color: Colors.white))),
      body: GestureDetector(
        onTap: unfocusAllNodes,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Center(
                  child: Image.asset('assets/images/ent.jpg',
                      height: 100, width: 100)),
              formWidget(),
              Padding(
                padding: EdgeInsets.only(left: loginMargin, right: loginMargin),
                child: RaisedButton(
                  onPressed: incrementForm,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18.0))),
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(form != 2 ? "Continue" : "Sign up!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600)),
                            flex: 12),
                        Expanded(
                            child:
                                Icon(Icons.arrow_forward, color: Colors.white),
                            flex: 1)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  formWidget() {
    switch (form) {
      case 1:
        return firstForm();

      case 2:
        return secondForm();
    }
  }

  firstForm() {
    return Form(
      key: _firstFormKey,
      child: Padding(
        padding: EdgeInsets.only(left: loginMargin, right: loginMargin),
        child: Column(
          children: <Widget>[
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value.isEmpty) return "Please enter your first name";
                return null;
              },
              onChanged: (value) {
                entrepreneurUserModel.entrepreneurPortfolioModel.firstName =
                    value;
              },
              onFieldSubmitted: (value) {
                _lastNameNode.requestFocus();
              },
              initialValue:
                  entrepreneurUserModel.entrepreneurPortfolioModel.firstName,
              // controller: _firstName,
              decoration: InputDecoration(
                  isDense: true,
                  labelText: 'First Name',
                  labelStyle: TextStyle()),
              focusNode: _firstNameNode,
            ),
            SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value.isEmpty) return "Please enter your last name";
                return null;
              },
              onChanged: (value) {
                entrepreneurUserModel.entrepreneurPortfolioModel.lastName =
                    value;
              },
              onFieldSubmitted: (value) {
                _emailNode.requestFocus();
              },
              // controller: _lastName,
              initialValue:
                  entrepreneurUserModel.entrepreneurPortfolioModel.lastName,
              decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Last Name',
                  labelStyle: TextStyle()),
              focusNode: _lastNameNode,
            ),
            SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) return "Please enter your email";
                if (!isEmail(value)) return "Please enter a valid email";
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (value) {
                _passwordNode.requestFocus();
              },
              // controller: _email,
              onChanged: (value) {
                entrepreneurUserModel.email = value;
              },
              initialValue: entrepreneurUserModel.email,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Email',
                labelStyle: TextStyle(),
              ),
              focusNode: _emailNode,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              // controller: _password,
              validator: (value) {
                if (value.isEmpty) return "Please enter a password";
                return null;
              },
              onChanged: (value) {
                entrepreneurUserModel.password = value;
              },
              onFieldSubmitted: (value) {
                _passwordNode.unfocus();
                incrementForm();
              },
              initialValue: entrepreneurUserModel.password,
              obscureText: true,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Password',
                labelStyle: TextStyle(),
              ),
              focusNode: _passwordNode,
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  secondForm() {
    return Form(
      key: _secondFormKey,
      child: Padding(
        padding:
            EdgeInsets.only(left: loginMargin, right: loginMargin, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            decrementFormButton(),
            Center(
              child: Text("Up for a photo shoot?",
                  style: Theme.of(context).textTheme.headline6),
            ),
            SizedBox(height: 20),
            _image == null
                ? Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(250)),
                      child: RawMaterialButton(
                        constraints: BoxConstraints(),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(250),
                            borderSide: BorderSide(color: Colors.transparent)),
                        onPressed: getImage,
                        child: Padding(
                          padding: const EdgeInsets.all(60.0),
                          child: Icon(Icons.add_a_photo,
                              size: 30, color: Colors.grey[700]),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: InkWell(
                      onTap: getImage,
                      child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(250)),
                          child:
                              CircleAvatar(backgroundImage: FileImage(_image))),
                    ),
                  ),
            SizedBox(height: 30),
            DropdownButton(
              style: TextStyle(fontSize: 14),
              hint: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('Which city is that smile brightening up?'),
              ), // Not necessary for Option 1
              value: _selectedLocation,
              onChanged: (newValue) {
                setState(() {
                  _selectedLocation = newValue;
                  // print(_selectedLocation);
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  child:
                      new Text(location, style: TextStyle(color: Colors.black)),
                  value: location,
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              focusNode: _execSummaryNode,
              initialValue:
                  entrepreneurUserModel.entrepreneurPortfolioModel.execSummary,
              onChanged: (value) {
                entrepreneurUserModel.entrepreneurPortfolioModel.execSummary =
                    value;
              },
              onFieldSubmitted: (value) {
                _linkedinNode.requestFocus();
              },
              decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Mind telling us a bit about yourself?',
                  labelStyle: TextStyle()),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.go,
              onFieldSubmitted: (value) {
                _twitterNode.requestFocus();
              },
              keyboardType: TextInputType.url,
              onChanged: (value) {
                entrepreneurUserModel.entrepreneurPortfolioModel
                    .linkedinProfile = "https://linkedin.com/in" + value;
              },
              focusNode: _linkedinNode,
              initialValue: entrepreneurUserModel
                      .entrepreneurPortfolioModel.linkedinProfile ??
                  '/',
              decoration: InputDecoration(
                  isDense: true,
                  labelText: "LinkedIn",
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.asset('assets/images/linkedin.png',
                        height: 20, width: 20),
                  )),
            ),
            SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.go,
              onFieldSubmitted: (value) {
                _facebookNode.requestFocus();
              },
              keyboardType: TextInputType.url,
              onChanged: (value) {
                print(
                    value); //add it to investorUserModel.investorPortfolioModel.twitter
              },
              initialValue:
                  // investorUserModel.investorPortfolioModel.linkedinProfile ??
                  '/',
              decoration: InputDecoration(
                  isDense: true,
                  labelText: "Twitter",
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.asset('assets/images/twitter.png',
                        height: 20, width: 20),
                  )),
              focusNode: _twitterNode,
            ),
            SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) {
                incrementForm();
              },
              keyboardType: TextInputType.url,
              onChanged: (value) {
                print(
                    value); //add it to investorUserModel.investorPortfolioModel.facebook
              },
              initialValue:
                  // investorUserModel.investorPortfolioModel.linkedinProfile ??
                  '/',
              decoration: InputDecoration(
                  isDense: true,
                  labelText: "Facebook",
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.asset('assets/images/facebook.png',
                        height: 20, width: 20),
                  )),
              focusNode: _facebookNode,
            )
          ],
        ),
      ),
    );
  }

  decrementFormButton() {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: RawMaterialButton(
            constraints: BoxConstraints(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            elevation: 3.0,
            onPressed: decrementForm,
            child: Container(
              decoration: BoxDecoration(
                  color: navbarBackgroundColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 18),
              ),
            )));
  }
}
