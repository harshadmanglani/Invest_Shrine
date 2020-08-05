import 'package:MobileApp/models/investors/investor_model.dart';
import 'package:flutter/material.dart';
import '../old/ven_portfolio_card.dart';

class InvestorPortfolioCard extends StatefulWidget {
  final InvestorPortfolioModel investorPortfolioModel;
  InvestorPortfolioCard(this.investorPortfolioModel);

  @override
  _InvestorPortfolioCardState createState() => _InvestorPortfolioCardState();
}

class _InvestorPortfolioCardState extends State<InvestorPortfolioCard> {
  InvestorPortfolioModel investorPortfolioModel;

  @override
  Widget build(BuildContext context) {
    investorPortfolioModel = widget.investorPortfolioModel;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/investor_portfolio_page',
            arguments: {'investorPortfolioModel': investorPortfolioModel});
      },
      child: Card(
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
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          investorPortfolioModel.firstName +
                              ' ' +
                              investorPortfolioModel.lastName,
                          style: Theme.of(context).textTheme.headline6),
                      SizedBox(height: 5),
                      Text(investorPortfolioModel.currentOccupation),
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
                                  '${investorPortfolioModel.numInvestments} investments',
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
                                          'Rs. ${priceFormatter(investorPortfolioModel.investment)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
          )),
    );
  }
}

class LoadingInvestorPortfolioCard extends StatefulWidget {
  @override
  _LoadingInvestorPortfolioCardState createState() =>
      _LoadingInvestorPortfolioCardState();
}

class _LoadingInvestorPortfolioCardState
    extends State<LoadingInvestorPortfolioCard> {
  var greyTextStyle = TextStyle(backgroundColor: Colors.grey[200]);
  @override
  Widget build(BuildContext context) {
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
                    color: Colors.grey[300]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('                     ', style: greyTextStyle),
                    SizedBox(height: 5),
                    Text(
                      '                       ',
                      style: greyTextStyle,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 130,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '                        ',
                                style: greyTextStyle,
                              ),
                              // SizedBox(width: 4),
                              // Text('          ', style: greyTextStyle),
                            ],
                          ),
                        ),
                        SizedBox(width: 4),
                        SizedBox(
                          width: 100,
                          child: RichText(
                            text: TextSpan(
                              style: greyTextStyle,
                              children: <TextSpan>[
                                TextSpan(text: '   '),
                                TextSpan(
                                    text: '    ',
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
