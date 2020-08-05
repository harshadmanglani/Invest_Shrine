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
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => beepCard(index),
            itemCount: beepsList.length,
          ),
        ),
      ),
    );
  }

  beepCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 13),
          Container(
            height: 85,
            width: 110,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://i.ibb.co/0nyD0y0/maldives-1993704-1920.jpg'),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  left: 65,
                  top: 40,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 4),
                        borderRadius: BorderRadius.circular(45)),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.ibb.co/Jk6HnN5/hm.png'),
                      radius: 20,
                    ),
                  ),
                )
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
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
    );
  }
}
