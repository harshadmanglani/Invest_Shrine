import 'package:MobileApp/backend/investors/portfolio_list.dart';
import 'package:MobileApp/models/investors/investor_model.dart';
import 'package:MobileApp/screens/entrepreneurs/inv_portfolio_card.dart';
import 'package:MobileApp/shared/nav_drawer.dart';
import 'package:flutter/material.dart';
import '../../theme/app.dart';

class InvestorPortfolioList extends StatefulWidget {
  @override
  _InvestorPortfolioListState createState() => _InvestorPortfolioListState();
}

class _InvestorPortfolioListState extends State<InvestorPortfolioList> {
  String query = '';
  String parameter = '';

  List<String> assetLinks = [
    'assets/images/livehealth.png',
    'assets/images/1_s.jpg',
    'assets/images/3_s.jpg',
    'assets/images/3_s.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context).settings.arguments;
    if (arguments != null) {
      query = arguments['query'];
      print(query);
      parameter = arguments['parameter'];
      print(parameter);
    }
    return Scaffold(
        drawer: arguments == null ? NavDrawer() : null,
        appBar: arguments == null
            ? AppBar(
                shape: appBarShape,
                centerTitle: true,
                title: Text(
                  "Investors",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : AppBar(
                shape: appBarShape,
              ),
        body: FutureBuilder(
            future: InvestorPortfolioListAPI()
                .getAllInvestorPortfolios(searchQuery: query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data);
                if (snapshot.data == null)
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            "Oops, no results found.",
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  );
                else {
                  List<InvestorModel> portfolioList = snapshot.data;
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        arguments != null
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 12, top: 12),
                                child: Text("Showing results for $parameter:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(fontSize: 18)))
                            : Container(height: 0, width: 0),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: portfolioList.length,
                              itemBuilder: (context, index) {
                                return InvestorPortfolioCard(
                                    portfolioList[index]);
                              },
                              // gridDelegate:
                              //     SliverGridDelegateWithFixedCrossAxisCount(
                              //   childAspectRatio: 4 / 6,
                              //   mainAxisSpacing: 8.0,
                              //   crossAxisSpacing: 8.0,
                              //   crossAxisCount: 2,
                              // )
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return Container(
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return LoadingInvestorPortfolioCard();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
