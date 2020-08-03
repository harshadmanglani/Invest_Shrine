import 'package:MobileApp/models/entrepreneurs/entrepreneur_model.dart';
import 'package:MobileApp/screens/investors/inv_login.dart';
import 'package:MobileApp/theme/app.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../shared/custom_expanded_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class EntrepreneurPortfolioPage extends StatefulWidget {
  @override
  _EntrepreneurPortfolioPageState createState() =>
      _EntrepreneurPortfolioPageState();
}

class _EntrepreneurPortfolioPageState extends State<EntrepreneurPortfolioPage> {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context).settings.arguments;
    EntrepreneurPortfolioModel entrepreneurPortfolio =
        arguments['entrepreneurPortfolio'];
    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
        title:
            Text('Co-Founder Portfolio', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding:
              EdgeInsets.only(left: loginMargin - 12, right: loginMargin - 12),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25)),
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 65,
                              backgroundImage:
                                  AssetImage('assets/images/cofounder.png'),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: RichText(
                                  overflow: TextOverflow.clip,
                                  text: TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(fontSize: 25),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: entrepreneurPortfolio.firstName +
                                            ' ' +
                                            entrepreneurPortfolio.lastName +
                                            ', \n',
                                      ),
                                      TextSpan(
                                          text: arguments['ventureName'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey[700])),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.grey[700],
                                size: 19,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text("Pune, India",
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 15)),
                            ),
                            Expanded(child: SizedBox(), flex: 1),
                            Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.work,
                                color: Colors.grey[700],
                                size: 19,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text("Co-Founder",
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 15)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Text(
                    "Contact Details: ",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  IconButton(
                      icon: Image.asset('assets/images/linkedin.png',
                          height: 22, width: 22),
                      onPressed: () {
                        launchURL(entrepreneurPortfolio.linkedinProfile);
                      }),
                  IconButton(
                    icon: Icon(Icons.email),
                    iconSize: 28,
                    color: navbarBackgroundColor,
                    onPressed: () {},
                  )
                ],
              ),
              CustomExpandedTile(
                  title: "Executive Summary",
                  content: entrepreneurPortfolio.execSummary,
                  initallyExpanded: true,
                  hasIcon: true),
            ],
          ),
        ),
      ),
    );
  }
}
