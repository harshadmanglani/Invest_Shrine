import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
// import '../theme/colors.dart';

class CustomExpandedTile extends StatefulWidget {
  final String title;
  final String content;
  final bool hasIcon;
  final bool initallyExpanded;

  CustomExpandedTile(
      {this.content, this.title, this.hasIcon, this.initallyExpanded});

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
    dynamic standardTextStyle = Theme.of(context)
        .textTheme
        .bodyText1
        .copyWith(fontSize: 14, color: Colors.grey[800]);
    return ExpandablePanel(
      controller:
          ExpandableController(initialExpanded: widget.initallyExpanded),
      theme: ExpandableThemeData(
          tapHeaderToExpand: widget.hasIcon,
          hasIcon: widget.hasIcon,
          iconColor: Colors.black),
      header: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 16.5, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      collapsed: Container(height: 0, width: 0),
      expanded: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text(
          content,
          style: standardTextStyle,
          overflow: TextOverflow.clip,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
