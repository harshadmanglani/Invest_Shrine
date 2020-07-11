import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EntrepreneurPortfolio extends StatefulWidget {
  final int index;
  EntrepreneurPortfolio(this.index);

  @override
  _EntrepreneurPortfolioState createState() => _EntrepreneurPortfolioState();
}

class _EntrepreneurPortfolioState extends State<EntrepreneurPortfolio> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: () {
        print(widget.index);
      },
      child: Card(
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(17.0))),
        elevation: 5.0,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: Container(
                  height: 210,
                  width: 140,
                  // child: secondLogoImage,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.0),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://github.com/harshadmanglani/flutter_hackathon2020/raw/assets/assets/img4.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 10.0, 3.0, 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text("LiveHealth Inc.",
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.headline6),
                      ),
                      SizedBox(height: 13),
                      Container(
                        child: Text(
                          "Tagline/Product description/Summary in one sentence.",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                      SizedBox(height: 18.0),
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    4.0, 1.0, 4.0, 1.0),
                                child: Text("HealthCare",
                                    style: // GoogleFonts.francoisOne(
                                        // textStyle:
                                        TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white))
                                // ),
                                ),
                          ),
                          /* SizedBox(width: 10.0),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.orange[800],
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    4.0, 1.0, 4.0, 1.0),
                                child: Text("Tech",
                                    style: // GoogleFonts.francoisOne(
                                        // textStyle:
                                        TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white))
                                // ),
                                ),
                          ),*/
                        ],
                      ),
                      /* SizedBox(height: 8.0),
                      Text("Seed Stage",
                          style: GoogleFonts.francoisOne(
                              textStyle: TextStyle(
                            fontSize: 16.0,
                          ))),*/
                      SizedBox(height: 45.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text("Pune, India",
                            style: TextStyle(fontWeight: FontWeight.w300)),
                      ),
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
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
              topLeft: Radius.circular(17.0)),
          image: DecorationImage(
              image: AssetImage('assets/logo.png'), fit: BoxFit.cover)),
    ),
  ),
);
