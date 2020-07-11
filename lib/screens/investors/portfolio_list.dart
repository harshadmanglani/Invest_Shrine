import 'package:MobileApp/shared/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'portfolio_card.dart';

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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20)),
          ),
          centerTitle: true,
          title: Text(
            "Startups",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            // IconButton(icon: Icon(Icons.account_balance), onPressed: () {})
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: EntrepreneurPortfolio(index),
                      );
                    },
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   childAspectRatio: 3 / 5,
                    //   mainAxisSpacing: 8.0,
                    //   crossAxisSpacing: 8.0,
                    //   crossAxisCount: 2,
                    // )
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
