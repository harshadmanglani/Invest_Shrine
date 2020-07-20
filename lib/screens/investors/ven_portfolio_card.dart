import 'package:MobileApp/shared/industry_widget.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import '../../models/entrepreneurs/venture_model.dart';

class VenturePortfolioCard extends StatefulWidget {
  final VentureModel portfolio;
  final String assetLink;
  VenturePortfolioCard(this.portfolio, this.assetLink);

  @override
  _VenturePortfolioCardState createState() => _VenturePortfolioCardState();
}

class _VenturePortfolioCardState extends State<VenturePortfolioCard> {
  var cardShape = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(17.0)));

  VentureModel portfolio;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    portfolio = widget.portfolio;
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shadowColor: navbarBackgroundColor,
        elevation: 7,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(17.0))),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
              child: Container(
                height: 150,
                // child: secondLogoImage,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(17.0),
                      topRight: Radius.circular(17)),
                  image: DecorationImage(
                      image: AssetImage(widget.assetLink), fit: BoxFit.cover),
                ),
              ),
            ),
            ExpandablePanel(
              theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                  iconColor: navbarBackgroundColor),
              header: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    portfolio.ventureName,
                    style: Theme.of(context).textTheme.headline6,
                  )),
              collapsed: Row(
                children: <Widget>[
                  IndustryWidget(industry: portfolio.industry, limitToTwo: true)
                ],
              ),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    portfolio.tagLine,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyText1,
                  ),
                  SizedBox(height: 12.0),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText1,
                      children: <TextSpan>[
                        TextSpan(text: 'Funding Goal: '),
                        TextSpan(
                            text: 'Rs. ${priceFormatter(portfolio.investment)}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(portfolio.location,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w300)),
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/venture_portfolio_page', arguments: {
                              'portfolio': portfolio,
                              'assetLink': widget.assetLink
                            });
                          },
                          child: Text(
                            "View Portfolio",
                            style: TextStyle(
                                color: navbarBackgroundColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline),
                          ))
                    ],
                  ),
                ],
              ),
              builder: (_, collapsed, expanded) {
                return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 0),
                  child: Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}

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

var secondLogoImage = Center(
  child: Align(
    alignment: Alignment.bottomRight,
    child: Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(17.0),
              topLeft: Radius.circular(17.0),
              topRight: Radius.circular(17.0),
              bottomLeft: Radius.circular(17.0)),
          image: DecorationImage(
              image: AssetImage('assets/images/logo_loading.png'),
              fit: BoxFit.cover)),
    ),
  ),
);

class LoadingVenturePortfolioCard extends StatefulWidget {
  @override
  _LoadingVenturePortfolioCardState createState() =>
      _LoadingVenturePortfolioCardState();
}

class _LoadingVenturePortfolioCardState
    extends State<LoadingVenturePortfolioCard> {
  var cardShape = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(17.0)));

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shadowColor: navbarBackgroundColor,
        elevation: 7,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(17.0))),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
              child: Container(
                height: 150,
                // child: secondLogoImage,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17.0),
                        topRight: Radius.circular(17)),
                    color: Colors.grey[300]),
              ),
            ),
            ExpandablePanel(
              theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: false,
                  tapHeaderToExpand: false,
                  hasIcon: false),
              header: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "                                       ",
                    style: TextStyle(backgroundColor: Colors.grey[200]),
                  )),
              collapsed: Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15))),
                      child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(4.0, 1.0, 4.0, 1.0),
                          child: Text("                ",
                              style: TextStyle(
                                  fontSize: 14.5, color: Colors.white))),
                    ),
                    SizedBox(width: 5.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        // borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(4.0, 1.0, 4.0, 1.0),
                          child: Text("         ",
                              style: TextStyle(
                                  fontSize: 14.5, color: Colors.black))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

// old code, don't delete tho

//  var oldCard = InkWell(
//       onTap: () {
//         print(widget.index);
//         Navigator.pushNamed(context, '/entrepreneur_portfolio',
//             arguments: {'index': widget.index});
//       },
//       child: Card(
//         shape: cardShape,
//         elevation: 7.0,
//         child: Row(crossAxisAlignment: CrossAxisAlignment.start,
//             // mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
//                 child: Container(
//                   height: 210,
//                   width: 140,
//                   // child: secondLogoImage,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(17.0),
//                     image: DecorationImage(
//                         image: NetworkImage(
//                             "https://cdn.pixabay.com/photo/2018/06/17/20/35/chain-3481377_1280.jpg"),
//                         fit: BoxFit.cover),
//                   ),
//                 ),
//               ),
//               Flexible(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(5.0, 10.0, 3.0, 5.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         child: Text("LiveHealth Inc.",
//                             overflow: TextOverflow.ellipsis,
//                             style: theme.textTheme.headline6),
//                       ),
//                       SizedBox(height: 13),
//                       Container(
//                         child: Text(
//                           "Tagline/Product description/Summary in one sentence.",
//                           maxLines: 3,
//                           overflow: TextOverflow.ellipsis,
//                           style: theme.textTheme.bodyText1,
//                         ),
//                       ),
//                       SizedBox(height: 22.0),
//                       Container(
//                         decoration: BoxDecoration(
//                             color: Colors.green,
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Padding(
//                             padding:
//                                 const EdgeInsets.fromLTRB(4.0, 1.0, 4.0, 1.0),
//                             child: Text("HealthCare",
//                                 style: TextStyle(
//                                     fontSize: 14.5, color: Colors.white))),
//                       ),
//                       SizedBox(height: 5.0),
//                       Container(
//                         decoration: BoxDecoration(
//                             color: Colors.yellow[300],
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Padding(
//                             padding:
//                                 const EdgeInsets.fromLTRB(4.0, 1.0, 4.0, 1.0),
//                             child: Text("Tech",
//                                 style: TextStyle(
//                                     fontSize: 14.5, color: Colors.black))),
//                       ),
//                       SizedBox(height: 28.0),
//                       Text("Bangalore, India",
//                           textAlign: TextAlign.end,
//                           style: TextStyle(
//                               color: Colors.grey[600],
//                               fontWeight: FontWeight.w300)),
//                     ],
//                   ),
//                 ),
//               )
//             ]),
//       ),
//     );
