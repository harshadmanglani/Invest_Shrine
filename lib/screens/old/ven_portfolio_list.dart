import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
import 'package:MobileApp/shared/nav_drawer.dart';
import 'package:flutter/material.dart';
import '../investors/../old/ven_portfolio_card.dart';
import '../../backend/entrepreneurs/portfolio_list.dart';
import '../../theme/app.dart';

class VenturePortfolioList extends StatefulWidget {
  @override
  _VenturePortfolioListState createState() => _VenturePortfolioListState();
}

class _VenturePortfolioListState extends State<VenturePortfolioList> {
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
      parameter = arguments['parameter'];
    }
    return Scaffold(
        drawer: arguments == null ? NavDrawer() : null,
        appBar: arguments == null
            ? AppBar(
                shape: appBarShape,
                centerTitle: true,
                title: Text(
                  "Startups",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : AppBar(shape: appBarShape),
        body: FutureBuilder(
            future: VenturePortfolioListAPI()
                .getAllVenturePortfolios(searchQuery: query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            "Oops, no results found.",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  List<VenturePortfolioModel> portfolioList = snapshot.data;
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        arguments != null
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 12, top: 12),
                                child: Text("Showing results by $parameter:",
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
                                return VenturePortfolioCard(
                                    portfolioList[index], assetLinks[index]);
                              },
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
                              return LoadingVenturePortfolioCard();
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
