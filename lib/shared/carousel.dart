import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MiniCarousel extends StatefulWidget {
  final List<Widget> items;
  MiniCarousel({this.items});

  @override
  _MiniCarouselState createState() => _MiniCarouselState();
}

class _MiniCarouselState extends State<MiniCarousel> {
  static List<Widget> items;

  @override
  void initState() {
    super.initState();
    items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    items = widget.items;
    List<Widget> imageSliders = items
        .map(
          (item) => Container(
            height: 300,
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17.0),
              child: item,
            ),
          ),
        )
        .toList();
    return Container(
        child: Column(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
          items: imageSliders,
        ),
      ],
    ));
  }
}
