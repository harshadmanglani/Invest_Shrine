import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
import 'package:MobileApp/shared/nav_drawer.dart';
import 'package:MobileApp/theme/app.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';

class SavedVentures extends StatefulWidget {
  @override
  _SavedVenturesState createState() => _SavedVenturesState();
}

class _SavedVenturesState extends State<SavedVentures> {
  List<VenturePortfolioModel> ventures = [
    VenturePortfolioModel(
        ventureName: "Travel Haven",
        tagLine:
            "Travel and make your soul feel blissful. Giving you heaven on earth."),
    VenturePortfolioModel(
        ventureName: "Decoration Jewelry Online",
        tagLine:
            "The best decoration jewelry delivered at your doorstep, at the cheapest prices!"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => savedVentureCard(ventures[index]),
        itemCount: ventures.length,
      ),
    );
  }

  savedVentureCard(VenturePortfolioModel venturePortfolioModel) {
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
                        child: Text(" beeped you.",
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
