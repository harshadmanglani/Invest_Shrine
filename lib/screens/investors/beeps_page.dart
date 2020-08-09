import 'package:MobileApp/models/entrepreneurs/entrepreneur_model.dart';
import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
import 'package:MobileApp/screens/investors/ven_portfolio_page.dart';

import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';

class BeepsPage extends StatefulWidget {
  @override
  _BeepsPageState createState() => _BeepsPageState();
}

class _BeepsPageState extends State<BeepsPage> {
  List<dynamic> beepsList = [
    {'cf': 'Steve Cook', 'vn': 'Travel Haven'},
    {'cf': 'Leela Parmar', 'vn': 'Decoration Jewelry Online'}
  ];

  VenturePortfolioModel venturePortfolioModel = VenturePortfolioModel(
      mainImage:
          "https://cdn.pixabay.com/photo/2020/07/03/16/42/amsterdam-5367020_1280.jpg",
      logoImage:
          "https://cdn.pixabay.com/photo/2016/04/25/18/07/halcyon-1352522_1280.jpg");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(height: 10),
      Expanded(
        flex: 20,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => beepCard(index),
              itemCount: beepsList.length,
            ),
          ),
        ),
      ),
    ]);
  }

  beepCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 13),
          Container(
            height: 100,
            width: 135,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 95,
                  width: 125,
                  decoration: venturePortfolioModel != null
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  venturePortfolioModel.mainImage)))
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[300]),
                ),
                Positioned(
                  top: 55,
                  left: 90,
                  child: Container(
                    height: 47.5,
                    width: 47.5,
                    decoration: venturePortfolioModel != null
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(55),
                            border: Border.all(color: Colors.white, width: 3),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    venturePortfolioModel.logoImage)))
                        : null,
                  ),
                ),
                Positioned(
                  top: -1,
                  left: -3,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.notifications_active,
                          size: 20, color: navbarBackgroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
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
                            "${beepsList[index]['cf']}, Co-Founder @ ${beepsList[index]['vn']} beeped you.",
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
    );
  }
}

class BeepCard extends StatelessWidget {
  final VenturePortfolioModel venturePortfolioModel;
  final EntrepreneurPortfolioModel entrepreneurPortfolioModel;
  BeepCard({this.venturePortfolioModel, this.entrepreneurPortfolioModel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VenturePortfolioPage(
                      venturePortfolioModel: venturePortfolioModel)));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 13),
            Container(
              height: 100,
              width: 135,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 95,
                    width: 125,
                    decoration: venturePortfolioModel != null
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    venturePortfolioModel.mainImage)))
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[300]),
                  ),
                  Positioned(
                    top: 55,
                    left: 90,
                    child: Container(
                      height: 47.5,
                      width: 47.5,
                      decoration: entrepreneurPortfolioModel != null
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(55),
                              border: Border.all(color: Colors.white, width: 3),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      entrepreneurPortfolioModel.displayImage)))
                          : null,
                    ),
                  ),
                  Positioned(
                    top: -1,
                    left: -3,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.notifications_active,
                            size: 20, color: navbarBackgroundColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
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
                              "${entrepreneurPortfolioModel.firstName} ${entrepreneurPortfolioModel.lastName}, Co-Founder @ ${venturePortfolioModel.ventureName} beeped you.",
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
