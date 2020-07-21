import 'package:MobileApp/models/investors/investor_model.dart';
import 'package:flutter/material.dart';
import '../investors/ven_portfolio_card.dart';

class InvestorPortfolioCard extends StatefulWidget {
  final InvestorModel investorPortfolio;
  InvestorPortfolioCard(this.investorPortfolio);

  @override
  _InvestorPortfolioCardState createState() => _InvestorPortfolioCardState();
}

class _InvestorPortfolioCardState extends State<InvestorPortfolioCard> {
  InvestorModel investorPortfolio;

  @override
  Widget build(BuildContext context) {
    investorPortfolio = widget.investorPortfolio;
    return Card(
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
                height: 85,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    image: DecorationImage(
                        image: AssetImage('assets/images/cofounder.png'),
                        fit: BoxFit.contain)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        investorPortfolio.firstName +
                            ' ' +
                            investorPortfolio.lastName,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 5),
                    Text(investorPortfolio.currentOccupation),
                    SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 130,
                          child: Row(
                            children: <Widget>[
                              Image.asset('assets/images/bars.png',
                                  height: 15, width: 15),
                              SizedBox(width: 4),
                              Text(
                                '${investorPortfolio.numInvestments} investments',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 4),
                        SizedBox(
                          width: 100,
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyText1,
                              children: <TextSpan>[
                                TextSpan(text: '| Avg: '),
                                TextSpan(
                                    text:
                                        'Rs. ${priceFormatter(investorPortfolio.investment)}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class LoadingInvestorPortfolioCard extends StatefulWidget {
  @override
  _LoadingInvestorPortfolioCardState createState() =>
      _LoadingInvestorPortfolioCardState();
}

class _LoadingInvestorPortfolioCardState
    extends State<LoadingInvestorPortfolioCard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
