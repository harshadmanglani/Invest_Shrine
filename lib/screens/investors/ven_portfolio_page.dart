import 'package:MobileApp/backend/entrepreneurs/portfolio_list.dart';
import 'package:MobileApp/models/entrepreneurs/entrepreneur_model.dart';
import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
import 'package:MobileApp/screens/investors/ent_portfolio_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String priceFormatter(int price) {
  String formattedPrice;
  int length = price.toString().length;
  if (price.toString().endsWith('00000'))
    formattedPrice = price.toString().substring(0, length - 5) + 'L';
  else if (price.toString().endsWith('0000') && length >= 6)
    formattedPrice = price.toString().substring(0, length - 5) +
        '.' +
        price.toString().substring(length - 5, length - 4);
  return formattedPrice;
}

class VenturePortfolioPage extends StatefulWidget {
  final VenturePortfolioModel venturePortfolioModel;
  VenturePortfolioPage({this.venturePortfolioModel});
  @override
  _VenturePortfolioPageState createState() => _VenturePortfolioPageState();
}

class _VenturePortfolioPageState extends State<VenturePortfolioPage> {
  VenturePortfolioModel venturePortfolioModel;
  Future entrepreneurPortfolioList;

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    entrepreneurPortfolioList = EntrepreneurPortfolioListAPI()
        .getAllEntrepreneurPortfolios(
            searchQuery: '(venture: "${widget.venturePortfolioModel.id}")');
  }

  @override
  Widget build(BuildContext context) {
    venturePortfolioModel = widget.venturePortfolioModel;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.bookmark_border, size: 30), onPressed: () {})
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 220,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        image: DecorationImage(
                            image:
                                NetworkImage(venturePortfolioModel.mainImage),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      top: 140,
                      left: MediaQuery.of(context).size.width / 2 - 40,
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white, width: 3),
                          image: DecorationImage(
                              image:
                                  NetworkImage(venturePortfolioModel.logoImage),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              introWidget(),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey[300],
                thickness: 10,
              ),
              SizedBox(height: 5),
              overviewWidget(),
              teamWidget(),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }

  introWidget() {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(venturePortfolioModel.ventureName,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: textTheme.headline5),
        SizedBox(height: 10),
        Text(venturePortfolioModel.tagLine,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: textTheme.bodyText2.copyWith(color: Colors.grey[800])),
        SizedBox(height: 10),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: RawMaterialButton(
                    constraints: BoxConstraints(),
                    onPressed: () {
                      launchURL(venturePortfolioModel.website);
                    },
                    child:
                        Icon(Icons.launch, color: Colors.grey[700], size: 26),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: RawMaterialButton(
                    constraints: BoxConstraints(),
                    onPressed: () {
                      launchURL(venturePortfolioModel.website);
                    },
                    child: Image.asset('assets/images/linkedin.png',
                        height: 24, width: 24),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: RawMaterialButton(
                    constraints: BoxConstraints(),
                    onPressed: () {
                      launchURL(venturePortfolioModel.website);
                    },
                    child: Image.asset('assets/images/twitter.png',
                        height: 26, width: 26),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: RawMaterialButton(
                    constraints: BoxConstraints(),
                    onPressed: () {
                      launchURL(venturePortfolioModel.website);
                    },
                    child: Image.asset('assets/images/facebook.png',
                        height: 26, width: 26),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  overviewWidget() {
    var textTheme = Theme.of(context).textTheme;
    String industry = '';
    for (var i = 0; i < venturePortfolioModel.industry.length; i++) {
      if (i != venturePortfolioModel.industry.length - 1)
        industry += venturePortfolioModel.industry[i] + ', ';
      else
        industry += venturePortfolioModel.industry[i];
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 13.0, right: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Funding Goal", style: textTheme.headline6),
          SizedBox(height: 3),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 3),
          Text(
            "₹" + priceFormatter(venturePortfolioModel.investment),
            style: textTheme.bodyText2
                .copyWith(color: Colors.grey[800], fontSize: 17),
          ),
          SizedBox(height: 30),
          Text("Industries", style: textTheme.headline6),
          SizedBox(height: 3),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 3),
          Text(
            industry,
            style: textTheme.bodyText2.copyWith(color: Colors.grey[800]),
          ),
          SizedBox(height: 30),
          Text("Description", style: textTheme.headline6),
          SizedBox(height: 3),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 3),
          Text(
            venturePortfolioModel.startupSummary,
            style: textTheme.bodyText2.copyWith(color: Colors.grey[800]),
          ),
          SizedBox(height: 30),
          Text("Headquarters", style: textTheme.headline6),
          SizedBox(height: 3),
          Divider(
            color: Colors.grey[400],
          ),
          SizedBox(height: 3),
          Text(
            venturePortfolioModel.location,
            style: textTheme.bodyText2.copyWith(color: Colors.grey[800]),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  teamWidget() {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: Text("Meet the Team", style: textTheme.headline6),
        ),
        SizedBox(height: 3),
        Divider(
          color: Colors.grey[400],
        ),
        SizedBox(height: 3),
        SizedBox(
          height: 210,
          child: FutureBuilder(
              future: entrepreneurPortfolioList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return EntrepreneurTeamCard(
                          entrepreneurPortfolioModel: snapshot.data[index]);
                    },
                    itemCount: snapshot.data.length,
                  );
                else
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return EntrepreneurTeamCard(
                          entrepreneurPortfolioModel: null);
                    },
                    itemCount: 10,
                  );
              }),
        ),
      ],
    );
  }
}

class EntrepreneurTeamCard extends StatelessWidget {
  final EntrepreneurPortfolioModel entrepreneurPortfolioModel;
  EntrepreneurTeamCard({this.entrepreneurPortfolioModel});
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: InkWell(
        onTap: entrepreneurPortfolioModel != null
            ? () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => EntrepreneurPortfolioPage(
                              entrepreneurPortfolioModel:
                                  entrepreneurPortfolioModel,
                              personalPortfolio: false,
                            )));
              }
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            entrepreneurPortfolioModel != null
                ? Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(entrepreneurPortfolioModel.displayImage),
                    ),
                  )
                : Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
            SizedBox(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    entrepreneurPortfolioModel != null
                        ? Text(
                            entrepreneurPortfolioModel.firstName +
                                " " +
                                entrepreneurPortfolioModel.lastName,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.headline6.copyWith(
                                fontSize: 16, color: Colors.grey[800]))
                        : Text("                           ",
                            textAlign: TextAlign.left,
                            style: textTheme.headline6.copyWith(
                                fontSize: 16,
                                backgroundColor: Colors.grey[200])),
                    SizedBox(height: 3),
                    entrepreneurPortfolioModel != null
                        ? Text("Ex-CEO, Apple Computer in Cupertino",
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyText1.copyWith(
                                fontSize: 14, color: Colors.grey[700]))
                        : Text("                         ",
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            style: textTheme.bodyText1.copyWith(
                                fontSize: 14,
                                backgroundColor: Colors.grey[200])),
                    SizedBox(height: 3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
