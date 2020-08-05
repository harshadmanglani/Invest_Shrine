import 'package:MobileApp/models/investors/investor_model.dart';
import 'package:MobileApp/screens/entrepreneurs/ent_login.dart';
import 'package:MobileApp/shared/custom_expanded_tile.dart';
import 'package:MobileApp/shared/industry_widget.dart';
import 'package:MobileApp/theme/app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../old/ven_portfolio_card.dart';
import '../../theme/colors.dart';
import 'package:expandable/expandable.dart';

class InvestorPortfolioPage extends StatefulWidget {
  @override
  _InvestorPortfolioPageState createState() => _InvestorPortfolioPageState();
}

class _InvestorPortfolioPageState extends State<InvestorPortfolioPage> {
  InvestorPortfolioModel investorPortfolioModel;
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    investorPortfolioModel = InvestorPortfolioModel(
        firstName: "Mahesh",
        lastName: "Malani",
        location: "Pune",
        currentOccupation: "CEO @ NASSCOM",
        interests: ["Tech"],
        numInvestments: 10,
        investment: 1000000,
        displayImage: "https://i.ibb.co/Jk6HnN5/hm.png",
        background:
            "I'm Mahesh, and I'm here to challenge the status quo and change the world. Thinking different is the only way to do that. And remember, you're going to die one day. There's no reason not to follow your heart. You've got to find what you love. And if you haven't found it yet, keep looking. Don't settle.");
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          // shape: appBarShape,
          // title:
          // Text("Investor Portfolio", style: TextStyle(color: Colors.white)),
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
                        backgroundImage:
                            NetworkImage(investorPortfolioModel.displayImage)),
                    SizedBox(width: 20),
                    Expanded(
                        child: SizedBox(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: <Widget>[
                                Text(
                                    "${investorPortfolioModel.firstName} ${investorPortfolioModel.lastName},",
                                    overflow: TextOverflow.clip,
                                    style: textTheme.headline4),
                                Text(investorPortfolioModel.currentOccupation,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.normal)),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.location_on,
                                            size: 13, color: Colors.grey[800]),
                                        SizedBox(width: 2),
                                        Text(
                                          investorPortfolioModel.location,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.school,
                                            color: Colors.grey[800], size: 13),
                                        SizedBox(width: 2),
                                        Text(
                                          "University of Rhode Island    ................     ",
                                          style: TextStyle(fontSize: 10),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
          SizedBox(height: 10),
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
          SizedBox(height: 10),
          overviewWidget()
        ]));
  }

  overviewWidget() {
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
          Text("Background", style: textTheme.headline6),
          SizedBox(height: 3),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 3),
          Text(
            investorPortfolioModel.background,
            style: textTheme.bodyText2.copyWith(color: Colors.grey[800]),
          ),
          SizedBox(height: 30),
          Text("Investment Portfolio", style: textTheme.headline6),
          SizedBox(height: 3),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 3),
          Text(
              "Total number of investments: ${investorPortfolioModel.numInvestments}"),
          SizedBox(height: 4),
          Text(
            "Preferred amount per ticket: ₹ ${priceFormatter(investorPortfolioModel.investment)}",
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Divider(color: Colors.grey[300]),
          ),
          investmentPortfolioElement(),
          SizedBox(height: 8),
          investmentPortfolioElement(),
          SizedBox(height: 30),
          Text("Interests", style: textTheme.headline6),
          SizedBox(height: 3),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 3),
          Text(
            industry,
            style: textTheme.bodyText2.copyWith(color: Colors.grey[800]),
          ),
          SizedBox(height: 30),
          Text("Funding Goal", style: textTheme.headline6),
          SizedBox(height: 3),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 3),
          Text(
            "₹" + priceFormatter(investorPortfolioModel.investment),
            style: textTheme.bodyText2
                .copyWith(color: Colors.grey[800], fontSize: 17),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  investmentPortfolioElement() {
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
