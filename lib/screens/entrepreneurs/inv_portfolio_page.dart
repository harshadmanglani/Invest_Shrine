import 'package:MobileApp/models/investors/investor_model.dart';
import 'package:MobileApp/screens/entrepreneurs/ent_login.dart';
import 'package:MobileApp/shared/custom_expanded_tile.dart';
import 'package:MobileApp/shared/industry_widget.dart';
import 'package:MobileApp/theme/app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../investors/ven_portfolio_card.dart';
import '../../theme/colors.dart';
import 'package:expandable/expandable.dart';

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
    var standardTextStyle = Theme.of(context).textTheme.caption;
    return Scaffold(
      appBar: AppBar(
        shape: appBarShape,
        title:
            Text("Investor Portfolio", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding:
              EdgeInsets.only(left: loginMargin - 10, right: loginMargin - 10),
          child: ListView(
            physics: BouncingScrollPhysics(),
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
                                    text: investorPortfolio.firstName +
                                        ' ' +
                                        investorPortfolio.lastName +
                                        ', \n',
                                  ),
                                  TextSpan(
                                      text: investorPortfolio.currentOccupation,
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
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        icon: Image.asset('assets/images/linkedin.png',
                            height: 26, width: 26),
                        onPressed: () {
                          launchURL(investorPortfolio.linkedinProfile);
                        }),
                  ),
                  Expanded(child: SizedBox(), flex: 5),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                        width: 25,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.grey[700],
                          size: 21,
                        )),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(investorPortfolio.location,
                        style: TextStyle(color: Colors.grey[700])),
                  )
                ],
              ),
              SizedBox(height: 10),
              investmentPortfolioWidget(investorPortfolio, standardTextStyle),
              SizedBox(height: 10),
              CustomExpandedTile(
                  title: "Background",
                  content: investorPortfolio.background,
                  initallyExpanded: true,
                  hasIcon: true),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  investmentPortfolioWidget(
      InvestorModel investorPortfolio, TextStyle standardTextStyle) {
    return ExpandablePanel(
        theme: ExpandableThemeData(iconColor: navbarBackgroundColor),
        controller: ExpandableController(initialExpanded: true),
        header: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "Investment Portfolio",
            style: standardTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        collapsed: Container(height: 0, width: 0),
        expanded: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset('assets/images/bars.png', height: 27, width: 27),
                  SizedBox(width: 10),
                  Text(
                    '${investorPortfolio.numInvestments} investments',
                    style: standardTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: standardTextStyle,
                  children: <TextSpan>[
                    TextSpan(text: 'Average investment: '),
                    TextSpan(
                        text:
                            'Rs. ${priceFormatter(investorPortfolio.investment)}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 15),
              // Text("Favourite domains: ", style: standardTextStyle),
              // SizedBox(height: 8),
              IndustryWidget(
                  industry: investorPortfolio.interests, limitToTwo: false)
            ],
          ),
        ));
  }
}
