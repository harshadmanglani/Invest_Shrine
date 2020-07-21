import 'package:MobileApp/models/entrepreneurs/entrepreneur_model.dart';
import 'package:MobileApp/screens/investors/investor_login.dart';
import 'package:MobileApp/theme/app.dart';
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
    EntrepreneurModel entrepreneurPortfolio =
        arguments['entrepreneurPortfolio'];
    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
      ),
      body: Container(
        child: Padding(
          padding:
              EdgeInsets.only(left: loginMargin - 13, right: loginMargin - 13),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 65,
                    backgroundImage: AssetImage('assets/images/cofounder.png'),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: RichText(
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
                                  fontSize: 20, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Text("LinkedIn Profile: ",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.bold)),
                  IconButton(
                      icon: Image.asset('assets/images/linkedin.png',
                          height: 25, width: 25),
                      onPressed: () {
                        launchURL(entrepreneurPortfolio.linkedinProfile);
                      })
                ],
              ),
              CustomExpandedTile(
                  title: "Executive Summary",
                  content: entrepreneurPortfolio.execSummary,
                  initallyExpanded: true,
                  hasIcon: false),
            ],
          ),
        ),
      ),
    );
  }
}
