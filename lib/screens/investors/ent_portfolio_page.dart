import 'package:MobileApp/models/entrepreneurs/entrepreneur_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          actions: [
            personalPortfolio
                ? RawMaterialButton(
                    onPressed: () {},
                    child: Text("EDIT", style: TextStyle(color: Colors.white)),
                  )
                : Container(height: 0, width: 0)
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
                        radius: 50,
                        backgroundImage: NetworkImage(
                            entrepreneurPortfolioModel.displayImage)),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10),
                                Expanded(
                                  child: Text(
                                      "${entrepreneurPortfolioModel.firstName} ${entrepreneurPortfolioModel.lastName}",
                                      overflow: TextOverflow.clip,
                                      style: textTheme.headline4),
                                ),
                                Expanded(
                                  child: Text("CEO @ Apple Computer Inc.",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.normal)),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                          // Expanded(
                          //   flex: 1,
                          //   child: Container(
                          //     child: Row(
                          //       children: <Widget>[
                          //         Expanded(
                          //           child: Row(
                          //             children: <Widget>[
                          //               Icon(Icons.location_on,
                          //                   size: 15, color: Colors.grey[700]),
                          //               SizedBox(width: 2),
                          //               Text(
                          //                 investorPortfolioModel.location,
                          //                 overflow: TextOverflow.ellipsis,
                          //                 style: TextStyle(fontSize: 12),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
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
          SizedBox(height: 10),
          overviewWidget(context)
        ]));
  }

  overviewWidget(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 13.0, right: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          Text("Executive Summary", style: textTheme.headline6),
          SizedBox(height: 3),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 3),
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
