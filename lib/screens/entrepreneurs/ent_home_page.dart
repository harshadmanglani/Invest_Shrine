import 'package:MobileApp/backend/investors/portfolio_list.dart';
import 'package:MobileApp/models/investors/investor_model.dart';
import 'package:MobileApp/screens/entrepreneurs/inv_search.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../backend/industry_images.dart';
import '../investors/ven_portfolio_page.dart';

class EntrepreneurHomePage extends StatefulWidget {
  @override
  _EntrepreneurHomePageState createState() => _EntrepreneurHomePageState();
}

class _EntrepreneurHomePageState extends State<EntrepreneurHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 3),
            child: TextField(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InvestorSearch()));
              },
              readOnly: true,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: "Search",
                  prefixIcon: Icon(
                    Icons.search,
                    color: navbarBackgroundColor,
                  )),
            ),
          ),
        ),
        Expanded(
          flex: 23,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 10),
                ActiveInvestors(),
                SizedBox(height: 25),
                InterestInvestors(),
                SizedBox(height: 25),
                AllInvestors(),
              ],
            ),
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
  Future investorPortfolioList;

  @override
  void initState() {
    super.initState();
    investorPortfolioList =
        InvestorPortfolioListAPI().getAllInvestorPortfolios();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 15),
          child: FlatButton(
            onPressed: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Text("Active Investors🔥", style: textTheme.headline5),
                ),
                Expanded(flex: 1, child: Icon(Icons.arrow_forward))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: FutureBuilder(
            future: investorPortfolioList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ActiveInvestorCard(
                          investorPortfolioModel: snapshot.data[index]);
                    });
              } else {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ActiveInvestorCard(investorPortfolioModel: null);
                    });
              }
            },
          ),
        ),
      ],
    );
  }
}

class ActiveInvestorCard extends StatelessWidget {
  final InvestorPortfolioModel investorPortfolioModel;
  ActiveInvestorCard({this.investorPortfolioModel});
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    String interests = '';

    if (investorPortfolioModel != null) {
      for (var i = 0; i < investorPortfolioModel.interests.length; i++) {
        if (i != investorPortfolioModel.interests.length - 1)
          interests += investorPortfolioModel.interests[i] + ', ';
        else
          interests += investorPortfolioModel.interests[i];
      }
    }

    // investorPortfolioModel = null;
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Container(
        width: 300,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(width: 10),
            Expanded(
                child: investorPortfolioModel != null
                    ? CircleAvatar(
                        radius: (70),
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                              investorPortfolioModel.displayImage),
                        ))
                    : CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 70,
                      ),
                flex: 1),
            SizedBox(width: 10),
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    investorPortfolioModel != null
                        ? Text(
                            "${investorPortfolioModel.firstName} ${investorPortfolioModel.lastName}",
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.headline6.copyWith(fontSize: 17))
                        : Container(height: 20, width: 0),
                    SizedBox(height: 4),
                    investorPortfolioModel != null
                        ? Text(investorPortfolioModel.currentOccupation,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyText1
                                .copyWith(color: Colors.grey[800]))
                        : Text('                                   ',
                            style:
                                TextStyle(backgroundColor: Colors.grey[200])),
                    SizedBox(height: 6),
                    investorPortfolioModel != null
                        ? RichText(
                            text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Avg ticket: ',
                                    style: TextStyle(color: Colors.grey[600])),
                                TextSpan(
                                    text:
                                        '₹ ${priceFormatter(investorPortfolioModel.investment)}',
                                    style: TextStyle(color: Colors.grey[800])),
                              ],
                            ),
                          )
                        : Text('                         ',
                            style:
                                TextStyle(backgroundColor: Colors.grey[200])),
                    SizedBox(height: 4),
                    investorPortfolioModel != null
                        ? RichText(
                            text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Investments: ',
                                    style: TextStyle(color: Colors.grey[600])),
                                TextSpan(
                                    text:
                                        '${investorPortfolioModel.numInvestments}',
                                    style: TextStyle(color: Colors.grey[800])),
                              ],
                            ),
                          )
                        : Text('                         ',
                            style:
                                TextStyle(backgroundColor: Colors.grey[200])),
                    SizedBox(height: 4),
                    investorPortfolioModel != null
                        ? RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Interests: ',
                                    style: TextStyle(color: Colors.grey[600])),
                                TextSpan(
                                    text: interests,
                                    style: TextStyle(color: Colors.grey[800])),
                              ],
                            ),
                          )
                        : Text("                                ",
                            style: TextStyle(backgroundColor: Colors.grey[200]))
                  ],
                ))
          ],
        ),
      ),
    );
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
          child: Text("Interests", style: textTheme.headline5),
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
                      elevation: 1,
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
  Future investorPortfolioList;

  @override
  void initState() {
    super.initState();
    investorPortfolioList =
        InvestorPortfolioListAPI().getAllInvestorPortfolios();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 10),
          child: FlatButton(
            onPressed: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Text("All Investors", style: textTheme.headline5),
                ),
                Expanded(flex: 1, child: Icon(Icons.arrow_forward))
              ],
            ),
          ),
        ),
        FutureBuilder(
          future: investorPortfolioList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: AllInvestorCard(
                          investorPortfolioModel: snapshot.data[index]),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3 / 4,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 0.0,
                    crossAxisCount: 2,
                  ));
            } else {
              return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: AllInvestorCard(investorPortfolioModel: null),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3 / 4,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 0.0,
                    crossAxisCount: 2,
                  ));
            }
          },
        ),
      ],
    );
  }
}

class AllInvestorCard extends StatelessWidget {
  final InvestorPortfolioModel investorPortfolioModel;
  AllInvestorCard({this.investorPortfolioModel});
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Column(
        children: [
          Expanded(
              child: investorPortfolioModel != null
                  ? CircleAvatar(
                      radius: (60),
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(160),
                        child:
                            Image.network(investorPortfolioModel.displayImage),
                      ))
                  : CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 60,
                    ),
              flex: 1),
          SizedBox(height: 5),
          Expanded(
              flex: 1,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  investorPortfolioModel != null
                      ? Text(
                          "${investorPortfolioModel.firstName} ${investorPortfolioModel.lastName}",
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.headline6.copyWith(fontSize: 17))
                      : Container(height: 20, width: 0),
                  SizedBox(height: 4),
                  investorPortfolioModel != null
                      ? Text(investorPortfolioModel.currentOccupation,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyText1
                              .copyWith(color: Colors.grey[800]))
                      : Text('                                   ',
                          style: TextStyle(backgroundColor: Colors.grey[200])),
                  SizedBox(height: 6),
                  investorPortfolioModel != null
                      ? RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Avg ticket: ',
                                  style: TextStyle(color: Colors.grey[600])),
                              TextSpan(
                                  text:
                                      '₹ ${priceFormatter(investorPortfolioModel.investment)}',
                                  style: TextStyle(color: Colors.grey[800])),
                            ],
                          ),
                        )
                      : Text('                         ',
                          style: TextStyle(backgroundColor: Colors.grey[200])),
                  SizedBox(height: 4),
                  investorPortfolioModel != null
                      ? RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Investments: ',
                                  style: TextStyle(color: Colors.grey[600])),
                              TextSpan(
                                  text:
                                      '${investorPortfolioModel.numInvestments}',
                                  style: TextStyle(color: Colors.grey[800])),
                            ],
                          ),
                        )
                      : Text('                         ',
                          style: TextStyle(backgroundColor: Colors.grey[200])),
                ],
              ))
        ],
      ),
    );
  }
}
