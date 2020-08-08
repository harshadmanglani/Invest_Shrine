import 'package:MobileApp/backend/investors/portfolio_list.dart';
import 'package:MobileApp/models/investors/investor_model.dart';
import 'package:flutter/material.dart';
import '../../backend/industry_images.dart';

class EntrepreneurHomePage extends StatefulWidget {
  @override
  _EntrepreneurHomePageState createState() => _EntrepreneurHomePageState();
}

class _EntrepreneurHomePageState extends State<EntrepreneurHomePage> {
  Future investorPortfolioList;

  @override
  void initState() {
    super.initState();
    investorPortfolioList =
        InvestorPortfolioListAPI().getAllInvestorPortfolios();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60, child: TextField()),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 200, child: ActiveInvestors()),
              InterestInvestors(),
              AllInvestors()
            ],
          ),
        )
      ],
    );
  }
}

class ActiveInvestors extends StatefulWidget {
  @override
  _ActiveInvestorsState createState() => _ActiveInvestorsState();
}

class _ActiveInvestorsState extends State<ActiveInvestors> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class InterestInvestors extends StatefulWidget {
  @override
  _InterestInvestorsState createState() => _InterestInvestorsState();
}

class _InterestInvestorsState extends State<InterestInvestors> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 20),
          child: Text("Industry", style: textTheme.headline5),
        ),
        SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 2,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image:
                                    AssetImage(industryImages[index]["image"]),
                                fit: BoxFit.contain)),
                      ),
                    ),
                  ),
                );
              },
              itemCount: industryImages.length,
            ),
          ),
        ),
      ],
    );
  }
}

class AllInvestors extends StatefulWidget {
  @override
  _AllInvestorsState createState() => _AllInvestorsState();
}

class _AllInvestorsState extends State<AllInvestors> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ActiveInvestorCard extends StatelessWidget {
  final InvestorPortfolioModel investorPortfolioModel;
  ActiveInvestorCard({this.investorPortfolioModel});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AllInvestorCard extends StatelessWidget {
  final InvestorPortfolioModel investorPortfolioModel;
  AllInvestorCard({this.investorPortfolioModel});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
