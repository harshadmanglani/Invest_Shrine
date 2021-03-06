import 'package:flutter/material.dart';

class IndustryWidget extends StatefulWidget {
  final List<String> industry;
  final bool limitToTwo;

  IndustryWidget({this.industry, this.limitToTwo});

  @override
  _IndustryWidgetState createState() => _IndustryWidgetState();
}

class _IndustryWidgetState extends State<IndustryWidget> {
  // Map<dynamic, dynamic> colorMap = {};

  var colorMap = {
    "Tech": {"background": Colors.red[200], "text": Colors.black},
    "Healthcare": {"background": Colors.green[200], "text": Colors.black},
    "Fintech": {"background": Colors.blue[200], "text": Colors.white},
    "MSME": {"background": Colors.yellow[200], "text": Colors.black},
    "E-Commerce": {"background": Colors.orange[200], "text": Colors.black},
    "Travel": {"background": Colors.purple[200], "text": Colors.white},
    "Food": {"background": Colors.indigo[200], "text": Colors.white}
  };

  @override
  Widget build(BuildContext context) {
    print(widget.industry.toString());
    int limit = 4;
    int length = widget.limitToTwo
        ? widget.industry.length == 1 ? 1 : 2
        : widget.industry.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (var i = 0; i < length; i = i + limit)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: <Widget>[
                for (var j = i; j < i + limit && j < length; j++)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: colorMap[widget.industry[j]]["background"],
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 6.0, right: 6.0, top: 3.0, bottom: 3.0),
                          child: Text(
                            widget.industry[j],
                            style: TextStyle(
                                // color: colorMap[widget.industry[j]]["text"]
                                ),
                          ),
                        )),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
