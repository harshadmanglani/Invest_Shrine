import 'package:MobileApp/models/investors/investor_model.dart';
import 'package:MobileApp/screens/entrepreneurs/ent_login.dart';
import 'package:MobileApp/shared/custom_expanded_tile.dart';
import 'package:MobileApp/theme/app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InvestorPortfolioPage extends StatefulWidget {
  @override
  _InvestorPortfolioPageState createState() => _InvestorPortfolioPageState();
}

class _InvestorPortfolioPageState extends State<InvestorPortfolioPage> {
  InvestorModel investorPortfolio;
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
    investorPortfolio = arguments['investorPortfolio'];
    return Scaffold(
      appBar: AppBar(shape: appBarShape),
      body: Container(
        child: Padding(
          padding:
              EdgeInsets.only(left: loginMargin - 13, right: loginMargin - 13),
          child: Column(
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
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 65,
                          backgroundImage:
                              AssetImage('assets/images/cofounder.png'),
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
                                  text: investorPortfolio.firstName +
                                      ' ' +
                                      investorPortfolio.lastName +
                                      ', \n',
                                ),
                                TextSpan(
                                    text: investorPortfolio.currentOccupation,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.grey[700])),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                        launchURL(investorPortfolio.linkedinProfile);
                      })
                ],
              ),
              CustomExpandedTile(
                  title: "Background",
                  content: investorPortfolio.background,
                  initallyExpanded: true,
                  hasIcon: false),
            ],
          ),
        ),
      ),
    );
  }
}
