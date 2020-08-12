import 'package:MobileApp/models/entrepreneurs/entrepreneur_model.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EntrepreneurPortfolioPage extends StatelessWidget {
  final EntrepreneurPortfolioModel entrepreneurPortfolioModel;
  final bool personalPortfolio;
  EntrepreneurPortfolioPage(
      {this.entrepreneurPortfolioModel, this.personalPortfolio = true});

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
                        radius: 50,
                        backgroundImage: NetworkImage(
                            entrepreneurPortfolioModel.displayImage)),
                    SizedBox(width: 13),
                    Expanded(
                        child: SizedBox(
                      height: 110,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 5),
                                Expanded(
                                  child: Text(
                                      "${entrepreneurPortfolioModel.firstName} ${entrepreneurPortfolioModel.lastName}",
                                      overflow: TextOverflow.clip,
                                      style: textTheme.headline4),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text("CEO @ Apple Computer Inc.",
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
                                    children: <Widget>[
                                      Flexible(
                                          flex: 2,
                                          child: Text(
                                              entrepreneurPortfolioModel
                                                  .location,
                                              overflow: TextOverflow.ellipsis,
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
                          ),
                        ],
                      ),
                    )),
                    personalPortfolio
                        ? Padding(
                            padding: const EdgeInsets.only(right: 0.0),
                            child: RawMaterialButton(
                              constraints: BoxConstraints(),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditPersonalInfo(
                                          entrepreneurPortfolioModel:
                                              entrepreneurPortfolioModel),
                                    ));
                              },
                              child: Icon(Icons.edit,
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
                    launchURL(entrepreneurPortfolioModel.linkedinProfile);
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
                    launchURL(entrepreneurPortfolioModel.linkedinProfile);
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
                    launchURL(entrepreneurPortfolioModel.linkedinProfile);
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
          // SizedBox(height: 10),
          overviewWidget(context)
        ]));
  }

  overviewWidget(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 13.0, right: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Text("Executive Summary", style: textTheme.headline6)),
              personalPortfolio
                  ? Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0.0),
                        child: RawMaterialButton(
                          constraints: BoxConstraints(),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditExecSummary(
                                      entrepreneurPortfolioModel:
                                          entrepreneurPortfolioModel),
                                ));
                          },
                          child: Icon(Icons.edit,
                              color: navbarBackgroundColor, size: 20),
                        ),
                      ),
                    )
                  : Container(height: 0, width: 0)
            ],
          ),
          SizedBox(height: 3),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 8),
          Text(
            entrepreneurPortfolioModel.execSummary,
            style: textTheme.bodyText2.copyWith(color: Colors.grey[800]),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class EditPersonalInfo extends StatefulWidget {
  final EntrepreneurPortfolioModel entrepreneurPortfolioModel;
  EditPersonalInfo({this.entrepreneurPortfolioModel});
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
    _selectedLocation = (widget.entrepreneurPortfolioModel.location);
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
                  print("save entrepreneurPortfolioModel");
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
            physics: BouncingScrollPhysics(),
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
                                                .entrepreneurPortfolioModel
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
                                widget.entrepreneurPortfolioModel.firstName =
                                    value;
                              },
                              onFieldSubmitted: (value) {
                                _lastNameNode.requestFocus();
                              },
                              initialValue:
                                  widget.entrepreneurPortfolioModel.firstName,
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
                                widget.entrepreneurPortfolioModel.lastName =
                                    value;
                              },
                              initialValue:
                                  widget.entrepreneurPortfolioModel.lastName,
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
                            // TextFormField(
                            //   textInputAction: TextInputAction.go,
                            //   keyboardType: TextInputType.name,
                            //   validator: (value) {
                            //     if (value.isEmpty)
                            //       return "Please enter your current title";
                            //     return null;
                            //   },
                            //   textCapitalization: TextCapitalization.sentences,
                            //   // controller: _currentOccupation,
                            //   initialValue: widget
                            //       .investorPortfolioModel.currentOccupation,
                            //   onChanged: (value) {
                            //     widget.investorPortfolioModel
                            //         .currentOccupation = value;
                            //   },
                            //   onFieldSubmitted: (value) {
                            //     _websiteNode.requestFocus();
                            //   },
                            //   decoration: InputDecoration(
                            //       isDense: true,
                            //       labelText: 'Current Title',
                            //       labelStyle: TextStyle()),
                            //   focusNode: _currentOccupationNode,
                            // ),
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
                                widget.entrepreneurPortfolioModel
                                        .linkedinProfile =
                                    "https://linkedin.com/in" + value;
                              },
                              initialValue: widget.entrepreneurPortfolioModel
                                      .linkedinProfile
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
                              initialValue: widget.entrepreneurPortfolioModel
                                      .linkedinProfile
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

class EditExecSummary extends StatefulWidget {
  final EntrepreneurPortfolioModel entrepreneurPortfolioModel;
  EditExecSummary({this.entrepreneurPortfolioModel});
  @override
  _EditExecSummaryState createState() => _EditExecSummaryState();
}

class _EditExecSummaryState extends State<EditExecSummary> {
  FocusNode _execSummaryNode;

  @override
  void initState() {
    super.initState();
    _execSummaryNode = FocusNode();
  }

  void unfocusAllNodes() {
    _execSummaryNode.unfocus();
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
                  print("save entrepreneurPortfolioModel");
                },
                child: Text("SAVE", style: TextStyle(color: Colors.white)),
              )
            ],
            title: Text("Edit executive summary",
                style: TextStyle(color: Colors.white)),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                              focusNode: _execSummaryNode,
                              initialValue:
                                  widget.entrepreneurPortfolioModel.execSummary,
                              onChanged: (value) {
                                widget.entrepreneurPortfolioModel.execSummary =
                                    value;
                              },
                              decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Executive Summary',
                                  labelStyle: TextStyle()),
                              maxLines: 10,
                            ),
                          ]))),
            ),
          )),
    );
  }
}
