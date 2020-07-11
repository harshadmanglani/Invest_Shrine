import 'package:flutter/material.dart';

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
        elevation: 10.0,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: Container(
                  height: 200,
                  width: 150,
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
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 3.0, 15.0),
                      child: Container(
                        child: Text("LiveHealth Inc.",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.headline6),
                      ),
                    ),
                  ],
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
    child: Padding(
      padding: const EdgeInsets.only(bottom: 12.5, right: 0.3),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0)),
          child: Image.asset(
            'assets/logo.png',
            height: 80,
            width: 80,
          )),
    ),
  ),
);
