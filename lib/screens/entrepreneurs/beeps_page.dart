import 'package:MobileApp/models/investors/investor_model.dart';
import 'package:MobileApp/screens/entrepreneurs/inv_portfolio_page.dart';
import 'package:flutter/material.dart';

class BeepsPage extends StatefulWidget {
  @override
  _BeepsPageState createState() => _BeepsPageState();
}

class _BeepsPageState extends State<BeepsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Expanded(
          flex: 20,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => InvestorBeepCard(),
                itemCount: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InvestorBeepCard extends StatelessWidget {
  final InvestorPortfolioModel investorPortfolioModel = InvestorPortfolioModel(
      firstName: "James",
      lastName: "Potter",
      currentOccupation: "CEO",
      background: "Player",
      investment: 12000000,
      numInvestments: 15,
      displayImage: "https://i.ibb.co/8BZqxX4/Screenshot-282.png");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InvestorPortfolioPage(
                      investorPortfolioModel: investorPortfolioModel)));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 13),
            Container(
              height: 80,
              width: 90,
              child: Stack(
                children: <Widget>[
                  investorPortfolioModel != null
                      ? CircleAvatar(
                          radius: (40),
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(160),
                            child: Image.network(
                                investorPortfolioModel.displayImage),
                          ))
                      : CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 40,
                        ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: SizedBox(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Text(
                              "You beeped ${investorPortfolioModel.firstName} ${investorPortfolioModel.lastName}, CEO @ Ordway Labs on 23/12/2000.",
                              maxLines: 4,
                              overflow: TextOverflow.clip,
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 8)
          ],
        ),
      ),
    );
  }
}
