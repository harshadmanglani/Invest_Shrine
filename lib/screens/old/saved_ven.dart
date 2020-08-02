import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
import 'package:MobileApp/shared/nav_drawer.dart';
import 'package:MobileApp/theme/app.dart';
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
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          centerTitle: true,
          title: Text("Saved", style: TextStyle(color: Colors.white)),
          shape: appBarShape),
      body: Container(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => savedVentureCard(index),
          itemCount: ventures.length,
        ),
      ),
    );
  }

  savedVentureCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
      child: Card(
          shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          elevation: 7.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 100,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(index == 0
                                ? 'assets/images/1_s.jpg'
                                : 'assets/images/3_s.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: SizedBox(
                      height: 110,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Container(
                              child: Text(
                                ventures[index].ventureName,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Flexible(
                              flex: 1,
                              child: Text(
                                ventures[index].tagLine,
                                maxLines: 3,
                                style: TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent)),
                    onPressed: () {
                      print("onPressed");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Icon(Icons.restore_from_trash,
                          size: 30, color: Colors.black87),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
