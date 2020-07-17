import 'package:MobileApp/backend/entrepreneurs/portfolio_list.dart';
import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
import 'package:MobileApp/shared/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'portfolio_card.dart';
import '../../theme/app.dart';

class PortfolioList extends StatefulWidget {
  @override
  _PortfolioListState createState() => _PortfolioListState();
}

class _PortfolioListState extends State<PortfolioList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            future: VenturePortfolioList().getAllVenturePortfolios(),
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
                              return EntrepreneurPortfolio(
                                  portfolioList[index]);
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
                              return LoadingEntrepreneurPortfolio();
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
