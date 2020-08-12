import 'package:MobileApp/models/investors/investor_model.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../investors/ven_portfolio_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:validators/validators.dart';
import 'package:MobileApp/backend/industry_images.dart';

class InvestorPortfolioPage extends StatelessWidget {
  final InvestorPortfolioModel investorPortfolioModel;
  final bool personalPortfolio;
  InvestorPortfolioPage(
      {this.investorPortfolioModel, this.personalPortfolio = true});

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          // shape: appBarShape,
          title: personalPortfolio
              ? Text("Portfolio", style: TextStyle(color: Colors.white))
              : null,
          centerTitle: true,
          actions: [
            personalPortfolio
                ? Container(height: 0, width: 0)
                : IconButton(
                    icon: Icon(Icons.notifications_active), onPressed: () {})
          ],
        ),
        body: ListView(physics: BouncingScrollPhysics(), children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(investorPortfolioModel.displayImage)),
                    SizedBox(width: 20),
                    Expanded(
                        child: SizedBox(
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5),
                          Expanded(
                            child: Text(
                                "${investorPortfolioModel.firstName} ${investorPortfolioModel.lastName}",
                                overflow: TextOverflow.clip,
                                style: textTheme.headline4),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                                investorPortfolioModel.currentOccupation,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.normal)),
                          ),
                          // SizedBox(height: 10),
                          SizedBox(
                            height: 18,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    flex: 2,
                                    child: Text(investorPortfolioModel.location,
                                        overflow: TextOverflow.ellipsis,
                                        // textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 14))),
                                SizedBox(width: 3),
                                Flexible(
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.grey[600],
                                    size: 14,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                    personalPortfolio
                        ? Padding(
                            padding: const EdgeInsets.only(right: 0.0),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditPersonalInfo(
                                          investorPortfolioModel:
                                              investorPortfolioModel),
                                    ));
                              },
                              icon: Icon(Icons.edit,
                                  color: navbarBackgroundColor, size: 20),
                            ),
                          )
                        : Container(height: 0, width: 0)
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: RawMaterialButton(
                  constraints: BoxConstraints(),
                  onPressed: () {
                    launchURL(investorPortfolioModel.linkedinProfile);
                  },
                  child: Icon(Icons.launch, color: Colors.grey[700], size: 26),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                flex: 1,
                child: RawMaterialButton(
                  constraints: BoxConstraints(),
                  onPressed: () {
                    launchURL(investorPortfolioModel.linkedinProfile);
                  },
                  child: Image.asset('assets/images/linkedin.png',
                      height: 24, width: 24),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                flex: 1,
                child: RawMaterialButton(
                  constraints: BoxConstraints(),
                  onPressed: () {
                    launchURL(investorPortfolioModel.linkedinProfile);
                  },
                  child: Image.asset('assets/images/twitter.png',
                      height: 26, width: 26),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                flex: 1,
                child: RawMaterialButton(
                  constraints: BoxConstraints(),
                  onPressed: () {
                    launchURL(investorPortfolioModel.linkedinProfile);
                  },
                  child: Image.asset('assets/images/facebook.png',
                      height: 26, width: 26),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.grey[300],
            thickness: 10,
          ),
          SizedBox(height: 5),
          overviewWidget(context)
        ]));
  }

  overviewWidget(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    String industry = '';
    for (var i = 0; i < investorPortfolioModel.interests.length; i++) {
      if (i != investorPortfolioModel.interests.length - 1)
        industry += investorPortfolioModel.interests[i] + ', ';
      else
        industry += investorPortfolioModel.interests[i];
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 13.0, right: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                  flex: 6,
                  child:
                      Text("Investment Portfolio", style: textTheme.headline6)),
              Expanded(
                  flex: 1,
                  child: personalPortfolio
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditInvestmentPortfolio(
                                            investorPortfolioModel:
                                                investorPortfolioModel),
                                  ));
                            },
                            icon: Icon(Icons.edit,
                                color: navbarBackgroundColor, size: 20),
                          ),
                        )
                      : Container(height: 0, width: 0))
            ],
          ),
          // SizedBox(height: 3),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 8),
          Text(
              "Total number of investments: ${investorPortfolioModel.numInvestments}"),
          SizedBox(height: 4),
          Text(
            "Preferred amount per ticket: ₹ ${priceFormatter(investorPortfolioModel.investment)}",
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Text("Interests", style: textTheme.headline6)),
              Expanded(
                  flex: 1,
                  child: personalPortfolio
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditInterests(
                                        investorPortfolioModel:
                                            investorPortfolioModel),
                                  ));
                            },
                            icon: Icon(Icons.edit,
                                color: navbarBackgroundColor, size: 20),
                          ),
                        )
                      : Container(height: 0, width: 0))
            ],
          ),
          // SizedBox(height: 3),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 8),
          Text(
            industry,
            style: textTheme.bodyText2.copyWith(color: Colors.grey[800]),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Text("Background", style: textTheme.headline6)),
              Expanded(
                  flex: 1,
                  child: personalPortfolio
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditBackground(
                                        investorPortfolioModel:
                                            investorPortfolioModel),
                                  ));
                            },
                            icon: Icon(Icons.edit,
                                color: navbarBackgroundColor, size: 20),
                          ),
                        )
                      : Container(height: 0, width: 0))
            ],
          ),
          // SizedBox(height: 3),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 8),
          Text(
            investorPortfolioModel.background,
            style: textTheme.bodyText2.copyWith(color: Colors.grey[800]),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  investmentPortfolioElement(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        RichText(
            overflow: TextOverflow.clip,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText2,
              children: <TextSpan>[
                TextSpan(
                    text: '1. Snug \n',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                TextSpan(
                    text:
                        "Snug is a talent based app, that connects you to bots. Invested in series A.",
                    style: TextStyle(
                        color: Colors.grey[700], fontWeight: FontWeight.w300)),
              ],
            )),
        Row(
          children: <Widget>[
            Text("View website: ",
                style: textTheme.bodyText2.copyWith(color: Colors.grey[800])),
            SizedBox(width: 10),
            Icon(Icons.launch, color: Colors.grey[900], size: 20)
          ],
        )
      ],
    );
  }
}

class EditPersonalInfo extends StatefulWidget {
  final InvestorPortfolioModel investorPortfolioModel;
  EditPersonalInfo({this.investorPortfolioModel});
  @override
  _EditPersonalInfoState createState() => _EditPersonalInfoState();
}

class _EditPersonalInfoState extends State<EditPersonalInfo> {
  String _selectedLocation;
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

  FocusNode _currentOccupationNode,
      _firstNameNode,
      _lastNameNode,
      _linkedinNode,
      _twitterNode,
      _facebookNode,
      _websiteNode;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _selectedLocation = (widget.investorPortfolioModel.location);
    _currentOccupationNode = FocusNode();
    _firstNameNode = FocusNode();
    _lastNameNode = FocusNode();
    _linkedinNode = FocusNode();
    _twitterNode = FocusNode();
    _facebookNode = FocusNode();
    _websiteNode = FocusNode();
  }

  unfocusAllNodes() {
    _currentOccupationNode.unfocus();
    _firstNameNode.unfocus();
    _lastNameNode.unfocus();
    _linkedinNode.unfocus();
    _twitterNode.unfocus();
    _websiteNode.unfocus();
    _facebookNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              RawMaterialButton(
                onPressed: () {
                  print("save investorPortfolioModel");
                },
                child: Text("SAVE", style: TextStyle(color: Colors.white)),
              )
            ],
            title: Text("Edit personal info",
                style: TextStyle(color: Colors.white)),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: SingleChildScrollView(
            child: GestureDetector(
              onTap: unfocusAllNodes,
              child: Form(
                  key: _formKey,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Center(
                              child: Text("Profile Photo",
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: InkWell(
                                onTap: getImage,
                                child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(250)),
                                    child: CircleAvatar(
                                        backgroundImage: _image == null
                                            ? NetworkImage(widget
                                                .investorPortfolioModel
                                                .displayImage)
                                            : FileImage(_image))),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Please enter your first name";
                                return null;
                              },
                              onChanged: (value) {
                                widget.investorPortfolioModel.firstName = value;
                              },
                              onFieldSubmitted: (value) {
                                _lastNameNode.requestFocus();
                              },
                              initialValue:
                                  widget.investorPortfolioModel.firstName,
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
                                if (value.isEmpty)
                                  return "Please enter your last name";
                                return null;
                              },
                              onChanged: (value) {
                                widget.investorPortfolioModel.lastName = value;
                              },
                              initialValue:
                                  widget.investorPortfolioModel.lastName,
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Last Name',
                                  labelStyle: TextStyle()),
                              focusNode: _lastNameNode,
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: DropdownButton(
                                style: TextStyle(fontSize: 14),
                                hint: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          90,
                                      child: Text('City of residence')),
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
                                    child: new Text(location,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              textInputAction: TextInputAction.go,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Please enter your current title";
                                return null;
                              },
                              textCapitalization: TextCapitalization.sentences,
                              // controller: _currentOccupation,
                              initialValue: widget
                                  .investorPortfolioModel.currentOccupation,
                              onChanged: (value) {
                                widget.investorPortfolioModel
                                    .currentOccupation = value;
                              },
                              onFieldSubmitted: (value) {
                                _websiteNode.requestFocus();
                              },
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Current Title',
                                  labelStyle: TextStyle()),
                              focusNode: _currentOccupationNode,
                            ),
                            SizedBox(height: 25),
                            TextFormField(
                              onFieldSubmitted: (value) {
                                _linkedinNode.requestFocus();
                              },
                              textInputAction: TextInputAction.go,
                              keyboardType: TextInputType.url,
                              focusNode: _websiteNode,
                              onChanged: (value) {
                                print(
                                    value); //add it to investorUserModel.investorPortfolioModel.website when done
                              },
                              initialValue: 'www.',
                              //     investorUserModel.investorPortfolioModel.linkedinProfile,
                              decoration: InputDecoration(
                                  labelText: "Website",
                                  isDense: true,
                                  prefix: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.launch,
                                        size: 20, color: Colors.grey[700]),
                                  )),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              textInputAction: TextInputAction.go,
                              focusNode: _linkedinNode,
                              onFieldSubmitted: (value) {
                                _twitterNode.requestFocus();
                              },
                              keyboardType: TextInputType.url,
                              onChanged: (value) {
                                widget.investorPortfolioModel.linkedinProfile =
                                    "https://linkedin.com/in" + value;
                              },
                              initialValue: widget
                                      .investorPortfolioModel.linkedinProfile
                                      .substring(23) ??
                                  '/',
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: "LinkedIn",
                                  prefix: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Image.asset(
                                        'assets/images/linkedin.png',
                                        height: 20,
                                        width: 20),
                                  )),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              textInputAction: TextInputAction.go,
                              focusNode: _twitterNode,
                              onFieldSubmitted: (value) {
                                _facebookNode.requestFocus();
                              },
                              keyboardType: TextInputType.url,
                              onChanged: (value) {
                                print(
                                    value); //add it to investorUserModel.investorPortfolioModel.twitter
                              },
                              initialValue: widget
                                      .investorPortfolioModel.linkedinProfile
                                      .substring(23) ??
                                  '/',
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: "Twitter",
                                  prefix: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Image.asset(
                                        'assets/images/twitter.png',
                                        height: 20,
                                        width: 20),
                                  )),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (value) {},
                              focusNode: _facebookNode,
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
                                    child: Image.asset(
                                        'assets/images/facebook.png',
                                        height: 20,
                                        width: 20),
                                  )),
                            )
                          ]))),
            ),
          )),
    );
  }
}

class EditInvestmentPortfolio extends StatefulWidget {
  final InvestorPortfolioModel investorPortfolioModel;
  EditInvestmentPortfolio({this.investorPortfolioModel});

  @override
  _EditInvestmentPortfolioState createState() =>
      _EditInvestmentPortfolioState();
}

class _EditInvestmentPortfolioState extends State<EditInvestmentPortfolio> {
  FocusNode _investmentNode, _numInvestmentsNode;

  @override
  void initState() {
    super.initState();
    _investmentNode = FocusNode();
    _numInvestmentsNode = FocusNode();
  }

  void unfocusAllNodes() {
    _investmentNode.unfocus();
    _numInvestmentsNode.unfocus();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              RawMaterialButton(
                onPressed: () {
                  print("save investorPortfolioModel");
                },
                child: Text("SAVE", style: TextStyle(color: Colors.white)),
              )
            ],
            title: Text("Edit investment portfolio",
                style: TextStyle(color: Colors.white)),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: SingleChildScrollView(
            child: GestureDetector(
              onTap: unfocusAllNodes,
              child: Form(
                  key: _formKey,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Please enter an amount";
                                if (!isNumeric(value)) {
                                  print("is not numeric");
                                  return "Please enter a numeric value.";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                _investmentNode.unfocus();
                                _numInvestmentsNode.requestFocus();
                              },
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              initialValue:
                                  widget.investorPortfolioModel.investment ==
                                          null
                                      ? null
                                      : widget.investorPortfolioModel.investment
                                          .toString(),
                              onChanged: (value) {
                                if (isNumeric(value))
                                  widget.investorPortfolioModel.investment =
                                      int.parse(value);
                                else
                                  widget.investorPortfolioModel.investment = 0;
                              },
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText:
                                      'How much money are you looking to invest?',
                                  labelStyle: TextStyle()),
                              focusNode: _investmentNode,
                            ),
                            SizedBox(height: 25),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Please enter a number";
                                if (!isNumeric(value)) {
                                  print("is not numeric");
                                  return "Please enter a numeric value.";
                                }
                                return null;
                              },
                              // controller: _numInvestments,
                              initialValue: widget.investorPortfolioModel
                                          .numInvestments ==
                                      null
                                  ? null
                                  : widget.investorPortfolioModel.numInvestments
                                      .toString(),
                              onChanged: (value) {
                                if (isNumeric(value))
                                  widget.investorPortfolioModel.numInvestments =
                                      int.parse(value);
                                else
                                  widget.investorPortfolioModel.numInvestments =
                                      0;
                              },

                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText:
                                      'How many ventures have you invested in?',
                                  labelStyle: TextStyle()),
                              focusNode: _numInvestmentsNode,
                            ),
                          ]))),
            ),
          )),
    );
  }
}

class EditInterests extends StatefulWidget {
  final InvestorPortfolioModel investorPortfolioModel;
  EditInterests({this.investorPortfolioModel});
  @override
  _EditInterestsState createState() => _EditInterestsState();
}

class _EditInterestsState extends State<EditInterests> {
  Map<String, bool> selectedIndustries;

  @override
  void initState() {
    super.initState();
    selectedIndustries = Map();
    for (var i = 0; i < industryImages.length; i++) {
      selectedIndustries[industryImages[i]["id"]] = false;
      for (var interest in widget.investorPortfolioModel.interests) {
        if (industryImages[i]["industry"] == interest)
          selectedIndustries[industryImages[i]["id"]] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              RawMaterialButton(
                onPressed: () {
                  print("save investorPortfolioModel");
                },
                child: Text("SAVE", style: TextStyle(color: Colors.white)),
              )
            ],
            title:
                Text("Edit interests", style: TextStyle(color: Colors.white)),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
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
                                setState(() {
                                  selectedIndustries[industry["id"]] = newValue;
                                });
                              }),
                        ),
                        Expanded(child: Text(industry["industry"]), flex: 5)
                      ],
                    ),
                ]),
          )),
    );
  }
}

class EditBackground extends StatefulWidget {
  final InvestorPortfolioModel investorPortfolioModel;
  EditBackground({this.investorPortfolioModel});
  @override
  _EditBackgroundState createState() => _EditBackgroundState();
}

class _EditBackgroundState extends State<EditBackground> {
  FocusNode _backgroundNode;

  @override
  void initState() {
    super.initState();
    _backgroundNode = FocusNode();
  }

  void unfocusAllNodes() {
    _backgroundNode.unfocus();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              RawMaterialButton(
                onPressed: () {
                  print("save investorPortfolioModel");
                },
                child: Text("SAVE", style: TextStyle(color: Colors.white)),
              )
            ],
            title:
                Text("Edit background", style: TextStyle(color: Colors.white)),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: SingleChildScrollView(
            child: GestureDetector(
              onTap: unfocusAllNodes,
              child: Form(
                  key: _formKey,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            TextFormField(
                              textInputAction: TextInputAction.go,
                              keyboardType: TextInputType.multiline,
                              textCapitalization: TextCapitalization.sentences,
                              focusNode: _backgroundNode,
                              initialValue:
                                  widget.investorPortfolioModel.background,
                              onChanged: (value) {
                                widget.investorPortfolioModel.background =
                                    value;
                              },
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Background',
                                  labelStyle: TextStyle()),
                              maxLines: 10,
                            ),
                          ]))),
            ),
          )),
    );
  }
}
