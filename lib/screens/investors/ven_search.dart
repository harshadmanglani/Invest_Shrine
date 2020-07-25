// import 'package:MobileApp/screens/investors/investor_login.dart';
// import 'package:MobileApp/theme/colors.dart';
// import 'package:flutter/material.dart';

// class VentureSearch extends StatefulWidget {
//   @override
//   _VentureSearchState createState() => _VentureSearchState();
// }

// class _VentureSearchState extends State<VentureSearch> {
//   List<dynamic> industryImages = [
//     {
//       "industry": "Healthcare",
//       "image": "assets/images/healthcare.png",
//       "id": "SW5kdXN0cnlNb2RlbDo0"
//     },
//     {
//       "industry": "Tech",
//       "image": "assets/images/tech.png",
//       "id": "SW5kdXN0cnlNb2RlbDox"
//     },
//     {
//       "industry": "Travel",
//       "image": "assets/images/travel.png",
//       "id": "SW5kdXN0cnlNb2RlbDo1"
//     },
//     {
//       "industry": "Fintech",
//       "image": "assets/images/fintech.png",
//       "id": "SW5kdXN0cnlNb2RlbDoy"
//     },
//     {
//       "industry": "E-Commerce",
//       "image": "assets/images/ecommerce.png",
//       "id": "SW5kdXN0cnlNb2RlbDo2"
//     },
//     {
//       "industry": "Food",
//       "image": "assets/images/food.jpg",
//       "id": "SW5kdXN0cnlNb2RlbDo5"
//     }
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding:
//               EdgeInsets.only(left: loginMargin - 13, right: loginMargin - 13),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(height: 40),
//               RichText(
//                 text: TextSpan(
//                   style: Theme.of(context)
//                       .textTheme
//                       .headline6
//                       .copyWith(fontSize: 25),
//                   children: <TextSpan>[
//                     TextSpan(
//                         text: 'Search',
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     TextSpan(
//                       text: ' for startups, businesses & entrepreneurs',
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 40),
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     flex: 8,
//                     child: TextField(
//                         decoration: InputDecoration(
//                             isDense: true,
//                             labelText: "Fuel innovation",
//                             prefixIcon: Icon(
//                               Icons.search,
//                               size: 23,
//                               color: navbarBackgroundColor,
//                             )),
//                         textInputAction: TextInputAction.go),
//                   ),
//                   Expanded(
//                       flex: 1,
//                       child: IconButton(
//                           icon: Icon(Icons.filter_list,
//                               color: navbarBackgroundColor),
//                           onPressed: () {}))
//                 ],
//               ),
//               SizedBox(height: 30),
//               Text("By Industry",
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1
//                       .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 20),
//               SizedBox(
//                 height: 200,
//                 child: ListView.builder(
//                     physics: BouncingScrollPhysics(),
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) => Padding(
//                           padding: const EdgeInsets.only(right: 5.0),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.pushNamed(
//                                   context, '/venture_portfolio_list',
//                                   arguments: {
//                                     'query': industryImages[index]["id"],
//                                     'industry': industryImages[index]
//                                         ["industry"]
//                                   });
//                             },
//                             child: Card(
//                               elevation: 4,
//                               shape: OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black12),
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Container(
//                                 width: 145,
//                                 decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                         image: AssetImage(
//                                             industryImages[index]["image"]),
//                                         fit: BoxFit.contain)),
//                                 child: Align(
//                                     alignment: FractionalOffset.bottomCenter,
//                                     child: Row(
//                                       children: <Widget>[
//                                         Expanded(
//                                           flex: 1,
//                                           child: Container(
//                                               height: 30,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                           bottomLeft:
//                                                               Radius.circular(
//                                                                   20),
//                                                           bottomRight:
//                                                               Radius.circular(
//                                                                   20)),
//                                                   color: Colors.black54),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     top: 2.0, left: 12.0),
//                                                 child: Text(
//                                                     industryImages[index]
//                                                         ["industry"],
//                                                     style: TextStyle(
//                                                         fontSize: 18,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color: Colors.white)),
//                                               )),
//                                         ),
//                                       ],
//                                     )),
//                               ),
//                             ),
//                           ),
//                         ),
//                     itemCount: industryImages.length),
//               ),
//               SizedBox(height: 40),
//               /* Text("By Funding Goal",
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1
//                       .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(
//                 height: 200,
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) => Card(
//                           child: Container(
//                             width: 100,
//                             child: Text("Healthcare"),
//                           ),
//                         ),
//                     itemCount: 8),
//               ),*/
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:MobileApp/screens/investors/inv_login.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';

class VentureSearch extends StatefulWidget {
  @override
  _VentureSearchState createState() => _VentureSearchState();
}

class _VentureSearchState extends State<VentureSearch> {
  List<dynamic> industryImages = [
    {
      "industry": "Healthcare",
      "image": "assets/images/healthcare.png",
      "id": "SW5kdXN0cnlNb2RlbDo0"
    },
    {
      "industry": "Tech",
      "image": "assets/images/tech.png",
      "id": "SW5kdXN0cnlNb2RlbDox"
    },
    {
      "industry": "Travel",
      "image": "assets/images/travel.png",
      "id": "SW5kdXN0cnlNb2RlbDo1"
    },
    {
      "industry": "Fintech",
      "image": "assets/images/fintech.png",
      "id": "SW5kdXN0cnlNb2RlbDoy"
    },
    {
      "industry": "E-Commerce",
      "image": "assets/images/ecommerce.png",
      "id": "SW5kdXN0cnlNb2RlbDo2"
    },
    {
      "industry": "Food",
      "image": "assets/images/food.jpg",
      "id": "SW5kdXN0cnlNb2RlbDo5"
    }
  ];
  TextEditingController _textEditingController;
  FocusNode _searchNode;

  @override
  void initState() {
    super.initState();
    _searchNode = new FocusNode();
    _textEditingController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: loginMargin - 13, right: loginMargin - 13),
          child: GestureDetector(
            onTap: () {
              _searchNode.unfocus();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 25),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Search',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: ' for startups, businesses & entrepreneurs',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: TextField(
                          focusNode: _searchNode,
                          controller: _textEditingController,
                          onSubmitted: (value) {
                            print("onSubmitted: $value");
                            _searchNode.unfocus();
                            if (value.split(' ').length == 1) {
                              Navigator.pushNamed(
                                  context, '/venture_portfolio_list',
                                  arguments: {
                                    'query': '(firstName: "$value")',
                                    'parameter': "$value"
                                  });
                            } else if (value.split(' ').length == 2) {
                              List<String> name = value.split(' ');
                              Navigator.pushNamed(
                                  context, '/venture_portfolio_list',
                                  arguments: {
                                    'query':
                                        '(firstName: "${name[0]}", lastName: "${name[1]}")',
                                    'parameter': "$value"
                                  });
                            }
                          },
                          onChanged: (value) {
                            // print("onChanged: $value");
                          },
                          onEditingComplete: () {
                            // print(
                            // "onEditingComplete: ${_textEditingController.value}");
                          },
                          decoration: InputDecoration(
                              isDense: true,
                              labelText: "Fuel innovation",
                              prefixIcon: Icon(
                                Icons.search,
                                size: 23,
                                color: navbarBackgroundColor,
                              )),
                          textInputAction: TextInputAction.go),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            icon: Icon(Icons.filter_list,
                                color: navbarBackgroundColor),
                            onPressed: () {
                              _searchNode.unfocus();
                              showDialog(
                                  context: context,
                                  builder: (context) => FilterWidget(
                                        name: _textEditingController.value.text,
                                        industryImages: industryImages,
                                      ));
                            }))
                  ],
                ),
                SizedBox(height: 30),
                Text("By Industry",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/venture_portfolio_list',
                                    arguments: {
                                      'query':
                                          '(interests: "${industryImages[index]["id"]}")',
                                      'parameter': industryImages[index]
                                          ["industry"]
                                    });
                              },
                              child: Card(
                                elevation: 4,
                                shape: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  width: 145,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              industryImages[index]["image"]),
                                          fit: BoxFit.contain)),
                                  child: Align(
                                      alignment: FractionalOffset.bottomCenter,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20)),
                                                    color: Colors.black54),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0, left: 12.0),
                                                  child: Text(
                                                      industryImages[index]
                                                          ["industry"],
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white)),
                                                )),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ),
                          ),
                      itemCount: industryImages.length),
                ),
                SizedBox(height: 40),
                /* Text("By Funding Goal",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Card(
                            child: Container(
                              width: 100,
                              child: Text("Healthcare"),
                            ),
                          ),
                      itemCount: 8),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterWidget extends StatefulWidget {
  final String name;
  final dynamic industryImages;
  FilterWidget({this.name, this.industryImages});
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<String> _locations = ['Pune', 'Bangalore', 'Chennai', 'Delhi'];
  String _selectedLocation, _selectedIndustry, _selectedIndustryId, name;
  @override
  Widget build(BuildContext context) {
    name = widget.name;
    return AlertDialog(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        title: Text("Filters"),
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 215,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: DropdownButton(
                        hint: Text('Location'), // Not necessary for Option 1
                        value: _selectedLocation,

                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                            print(_selectedLocation);
                          });
                        },
                        items: _locations.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: DropdownButton<dynamic>(
                        hint: Text('Industry'), // Not necessary for Option 1
                        value: _selectedIndustry,
                        isExpanded: true,
                        onChanged: (industry) {
                          setState(() {
                            // _selectedIndustryId = industry["id"];
                            // _selectedIndustry = industry["industry"];
                            // print(_selectedIndustry);
                            _selectedIndustry = industry;
                          });
                          for (var i = 0; i < widget.industryImages.length; i++)
                            if (widget.industryImages[i]["industry"] ==
                                industry)
                              _selectedIndustryId =
                                  widget.industryImages[i]["id"];
                        },
                        items: widget.industryImages
                            .map<DropdownMenuItem<dynamic>>((industry) {
                          return DropdownMenuItem<dynamic>(
                            child: Text(industry["industry"]),
                            value: industry["industry"],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.transparent)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Clear",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.transparent)),
                        onPressed: () {
                          String industryQuery = '';
                          String locationQuery = ')';
                          if (_selectedIndustryId != null)
                            industryQuery =
                                ',interests: "$_selectedIndustryId"';
                          if (_selectedLocation != null)
                            locationQuery = ',location: "$_selectedLocation")';
                          if (name.split(' ').length == 1)
                            Navigator.pushNamed(
                                context, '/venture_portfolio_list',
                                arguments: {
                                  'query': '(firstName: "$name"' +
                                      industryQuery +
                                      locationQuery,
                                  'parameter': "a filtered search"
                                });
                          else if (name.split(' ').length == 2)
                            Navigator.pushNamed(
                                context, '/venture_portfolio_list',
                                arguments: {
                                  'query':
                                      '(firstName: "${name.split(' ')[0]}", lastName: "${name.split(' ')[1]}"' +
                                          industryQuery +
                                          locationQuery,
                                  'parameter': "a filtered search"
                                });
                        },
                        child: Text("Apply",
                            style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }));
  }
}
