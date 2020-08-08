import 'package:MobileApp/backend/industry_images.dart';
import 'package:MobileApp/models/investors/inv_user.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'inv_login.dart';
import 'package:validators/validators.dart';
import 'dart:io';

class InvestorRegistrationForm extends StatefulWidget {
  @override
  _InvestorRegistrationFormState createState() =>
      _InvestorRegistrationFormState();
}

class _InvestorRegistrationFormState extends State<InvestorRegistrationForm> {
  InvestorUserModel investorUserModel;

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print(pickedFile.path);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  List<String> _locations = ['Pune', 'Bangalore', 'Chennai', 'Delhi'];
  int radioButton;

  FocusNode _usernameNode,
      _emailNode,
      _passwordNode,
      _confirmPasswordNode,
      _investmentNode,
      _numInvestmentsNode,
      _currentOccupationNode,
      _firstNameNode,
      _lastNameNode,
      _backgroundNode;
  final _firstFormKey = GlobalKey<FormState>();
  final _secondFormKey = GlobalKey<FormState>();
  final _thirdFormKey = GlobalKey<FormState>();

  int form = 1;
  Map<String, bool> selectedIndustries;

  @override
  void initState() {
    super.initState();
    investorUserModel = InvestorUserModel();
    _usernameNode = FocusNode();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    _confirmPasswordNode = FocusNode();
    _currentOccupationNode = FocusNode();
    _firstNameNode = FocusNode();
    _lastNameNode = FocusNode();
    _investmentNode = FocusNode();
    _numInvestmentsNode = FocusNode();
    _backgroundNode = FocusNode();

    selectedIndustries = Map();
    for (var i = 0; i < industryImages.length; i++) {
      selectedIndustries[industryImages[i]["id"]] = false;
    }
  }

  String _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Sign up as an Investor",
              style: TextStyle(color: Colors.white))),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Center(
                child: Image.asset('assets/images/inv.png',
                    height: 100, width: 100)),
            form == 1
                ? Container(height: 0, width: 0)
                : Padding(
                    padding:
                        EdgeInsets.only(left: loginMargin - 10, bottom: 20),
                    child: RawMaterialButton(
                        constraints: BoxConstraints(),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        elevation: 3.0,
                        onPressed: () {
                          setState(() {
                            form--;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: navbarBackgroundColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.arrow_back,
                                color: Colors.white, size: 18),
                          ),
                        ))),
            form == 1 ? firstForm() : form == 2 ? secondForm() : thirdForm(),
            Padding(
              padding: EdgeInsets.only(left: loginMargin, right: loginMargin),
              child: RaisedButton(
                onPressed: () {
                  form == 1
                      ? _firstFormKey.currentState.validate() == true
                          ? setState(() {
                              form = 2;
                            })
                          : () {}
                      : form == 2
                          ? _secondFormKey.currentState.validate() == true
                              ? setState(() {
                                  form = 3;
                                })
                              : () {}
                          : _thirdFormKey.currentState.validate() == true
                              ? setState(() {
                                  print("submit form");
                                })
                              : () {};
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0))),
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text("Continue",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600)),
                          flex: 12),
                      Expanded(
                          child: Icon(Icons.arrow_forward, color: Colors.white),
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
    );
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
              validator: (value) {
                if (value.isEmpty) return "Please enter your first name";
                return null;
              },
              onChanged: (value) {
                investorUserModel.investorPortfolioModel.firstName = value;
              },
              onFieldSubmitted: (value) {
                _firstNameNode.unfocus();
                _lastNameNode.requestFocus();
              },
              initialValue: investorUserModel.investorPortfolioModel.firstName,
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
              validator: (value) {
                if (value.isEmpty) return "Please enter your last name";
                return null;
              },
              onChanged: (value) {
                investorUserModel.investorPortfolioModel.lastName = value;
              },
              onFieldSubmitted: (value) {
                _lastNameNode.unfocus();
                _emailNode.requestFocus();
              },
              // controller: _lastName,
              initialValue: investorUserModel.investorPortfolioModel.lastName,
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
                if (isEmail(value)) return "Please enter a valid email";
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (value) {
                _emailNode.unfocus();
                _passwordNode.requestFocus();
              },
              // controller: _email,
              onChanged: (value) {
                investorUserModel.email = value;
              },
              initialValue: investorUserModel.email,
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
                investorUserModel.password = value;
              },
              onFieldSubmitted: (value) {
                _passwordNode.unfocus();
              },
              initialValue: investorUserModel.password,
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
        padding: EdgeInsets.only(left: loginMargin, right: loginMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Text("Interests",
                  style: Theme.of(context).textTheme.headline6),
            ),
            for (var industry in industryImages)
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Checkbox(
                        value: selectedIndustries[industry["id"]],
                        activeColor: Colors.green,
                        onChanged: (bool newValue) {
                          // print(industry["industry"]);
                          setState(() {
                            selectedIndustries[industry["id"]] = newValue;
                          });
                        }),
                  ),
                  Expanded(child: Text(industry["industry"]), flex: 5)
                ],
              ),
            SizedBox(height: 20.0),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) return "Please enter an amount";
                return null;
              },
              // controller: _investment,
              initialValue:
                  investorUserModel.investorPortfolioModel.investment == null
                      ? null
                      : investorUserModel.investorPortfolioModel.investment
                          .toString(),
              onChanged: (value) {
                if (isNumeric(value))
                  investorUserModel.investorPortfolioModel.investment =
                      int.parse(value);
                else
                  investorUserModel.investorPortfolioModel.investment = 0;
              },
              decoration: InputDecoration(
                  isDense: true,
                  labelText: 'How much money are you looking to invest?',
                  labelStyle: TextStyle()),
              focusNode: _investmentNode,
            ),
            SizedBox(height: 20),
            Text("Have you invested in startups or SMEs before?",
                style: Theme.of(context).textTheme.headline6),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Radio(
                        groupValue: radioButton,
                        onChanged: (value) {
                          setState(() {
                            radioButton = value;
                          });
                        },
                        value: 0)),
                Expanded(child: Text("Yes"), flex: 5)
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Radio(
                        groupValue: radioButton,
                        onChanged: (value) {
                          setState(() {
                            radioButton = value;
                          });
                        },
                        value: 1)),
                Expanded(child: Text("No"), flex: 5)
              ],
            ),
            radioButton == 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return "Please enter a number";
                        return null;
                      },
                      // controller: _numInvestments,
                      initialValue: investorUserModel
                                  .investorPortfolioModel.numInvestments ==
                              null
                          ? null
                          : investorUserModel
                              .investorPortfolioModel.numInvestments
                              .toString(),
                      onChanged: (value) {
                        if (isNumeric(value))
                          investorUserModel.investorPortfolioModel
                              .numInvestments = int.parse(value);
                        else
                          investorUserModel
                              .investorPortfolioModel.numInvestments = 0;
                      },
                      decoration: InputDecoration(
                          isDense: true,
                          labelText: 'How many ventures have you invested in?',
                          labelStyle: TextStyle()),
                      focusNode: _numInvestmentsNode,
                    ),
                  )
                : Container(height: 0, width: 0),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  thirdForm() {
    return Form(
      key: _thirdFormKey,
      child: Padding(
        padding:
            EdgeInsets.only(left: loginMargin, right: loginMargin, bottom: 20),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value.isEmpty) return "Please enter your current title";
                return null;
              },
              // controller: _currentOccupation,
              initialValue:
                  investorUserModel.investorPortfolioModel.currentOccupation,
              onChanged: (value) {
                investorUserModel.investorPortfolioModel.currentOccupation =
                    value;
              },
              decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Current Title',
                  labelStyle: TextStyle()),
              focusNode: _currentOccupationNode,
            ),
            SizedBox(height: 20),
            TextFormField(
              focusNode: _backgroundNode,
              initialValue: investorUserModel.investorPortfolioModel.background,
              onChanged: (value) {
                investorUserModel.investorPortfolioModel.currentOccupation =
                    value;
              },
              decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Mind telling us a bit about yourself?',
                  labelStyle: TextStyle()),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            Text("Up for a photo shoot?",
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 20),
            _image == null
                ? Container(
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
                  )
                : InkWell(
                    onTap: getImage,
                    child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(250)),
                        child:
                            CircleAvatar(backgroundImage: FileImage(_image))),
                  ),
            SizedBox(height: 20),
            DropdownButton(
              hint: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('Which city is that smile brightening up?'),
              ), // Not necessary for Option 1
              value: _selectedLocation,

              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  _selectedLocation = newValue;
                  // print(_selectedLocation);
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
