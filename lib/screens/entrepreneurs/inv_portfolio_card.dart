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
          borderRadius: BorderRadius.all(Radius.circular(17.0))),
      elevation: 3.0,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.0),
                  image: DecorationImage(
                      image: AssetImage('assets/images/cofounder.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                          investorPortfolio.firstName +
                              ' ' +
                              investorPortfolio.lastName,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6),
                    ),
                    SizedBox(height: 2),
                    Expanded(
                      flex: 1,
                      child: Text(investorPortfolio.currentOccupation,
                          overflow: TextOverflow.clip,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontStyle: FontStyle.italic)),
                    ),
                    SizedBox(height: 4),
                    Expanded(
                      flex: 1,
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText1,
                          children: <TextSpan>[
                            TextSpan(text: 'Plan to invest: \n'),
                            TextSpan(
                                text:
                                    'Rs. ${priceFormatter(investorPortfolio.investment)}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
