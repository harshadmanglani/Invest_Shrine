import 'package:flutter/material.dart';
import 'entrepreneur_portfolio.dart';

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
        // appBar: AppBar(
        //   shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.all(
        //     // bottomLeft:
        //     Radius.circular(20.0),
        //     // bottomRight: Radius.circular(20)),
        //   )),
        //   automaticallyImplyLeading: false,
        //   title: Text("Startups"),
        //   actions: <Widget>[
        //     IconButton(icon: Icon(Icons.search), onPressed: () {})
        //   ],
        // ),
        body: Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return EntrepreneurPortfolio(index);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3 / 5,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    crossAxisCount: 2,
                  )),
            ),
          ),
        ],
      ),
    ));
  }
}
