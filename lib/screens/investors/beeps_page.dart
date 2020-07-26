import 'package:MobileApp/shared/nav_drawer.dart';
import 'package:MobileApp/theme/app.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
          centerTitle: true,
          title: Text("Beeps", style: TextStyle(color: Colors.white)),
          shape: appBarShape),
      body: Container(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => beepCard(index),
          itemCount: beepsList.length,
        ),
      ),
    );
  }

  beepCard(int index) {
    return Card(
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
                  child: Icon(Icons.notifications_active,
                      color: navbarBackgroundColor, size: 25)),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: Text(
                              "${beepsList[index]['cf']}, Co-Founder @ ${beepsList[index]['vn']} beeped you.",
                              maxLines: 4,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        )
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
                    child: Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
