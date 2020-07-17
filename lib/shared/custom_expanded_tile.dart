import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import '../theme/colors.dart';

class CustomExpandedTile extends StatefulWidget {
  final String title;
  final String content;

  CustomExpandedTile({this.content, this.title});

  @override
  _CustomExpandedTileState createState() => _CustomExpandedTileState();
}

class _CustomExpandedTileState extends State<CustomExpandedTile> {
  String title;
  String content;

  @override
  Widget build(BuildContext context) {
    title = widget.title;
    content = widget.content;
    dynamic standardTextStyle = Theme.of(context).textTheme.caption;
    return ExpandablePanel(
      theme: ExpandableThemeData(iconColor: navbarBackgroundColor),
      header: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(
          title,
          style: standardTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      collapsed: Container(height: 0, width: 0),
      expanded: Text(
        content,
        style: standardTextStyle,
        overflow: TextOverflow.clip,
        textAlign: TextAlign.left,
      ),
    );
  }
}
