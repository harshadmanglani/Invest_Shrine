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
    return InkWell(
      onTap: () {},
      child: Card(
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(17.0))),
        elevation: 3.0,
        child: Container(
          child: Column(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
