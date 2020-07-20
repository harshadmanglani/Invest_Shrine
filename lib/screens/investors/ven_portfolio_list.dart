import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
import 'package:MobileApp/shared/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'ven_portfolio_card.dart';
import '../../backend/entrepreneurs/portfolio_list.dart';
import '../../theme/app.dart';

class VenturePortfolioList extends StatefulWidget {
  final String query;
  VenturePortfolioList({this.query = ''});
  @override
  _VenturePortfolioListState createState() => _VenturePortfolioListState();
}

class _VenturePortfolioListState extends State<VenturePortfolioList> {
  String query;

  List<String> assetLinks = [
    'assets/images/livehealth.png',
    'assets/images/1_s.jpg',
    'assets/images/3_s.jpg',
    'assets/images/3_s.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    query = widget.query;
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          shape: appBarShape,
          centerTitle: true,
          title: Text(
            "Startups",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            // IconButton(icon: Icon(Icons.account_balance), onPressed: () {})
          ],
        ),
        body: FutureBuilder(
            future: VenturePortfolioListAPI()
                .getAllVenturePortfolios(searchQuery: query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data);
                List<VentureModel> portfolioList = snapshot.data;
                return Container(
                  child: Column(
                    children: <Widget>[
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
