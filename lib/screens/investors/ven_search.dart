import 'package:MobileApp/screens/investors/search_results.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';

class VentureSearch extends StatefulWidget {
  @override
  _VentureSearchState createState() => _VentureSearchState();
}

class _VentureSearchState extends State<VentureSearch> {
  TextEditingController _textEditingController;
  FocusNode _searchNode;
  bool showSearchResults = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();

    _searchNode = new FocusNode();
    _textEditingController = new TextEditingController();
  }

  List<String> _locations = ['Pune', 'Bangalore', 'Chennai', 'Delhi'];
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
  String _selectedLocation, _selectedIndustry, _selectedIndustryId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 60,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                  child: TextField(
                      enableSuggestions: true,

                      // toolbarOptions: ToolbarOptions(),
                      focusNode: _searchNode,
                      onTap: () {
                        setState(() {
                          showSearchResults = true;
                        });
                      },
                      controller: _textEditingController,
                      onSubmitted: (value) {
                        _searchNode.unfocus();
                        // setState(() {
                        //   showSearchResults = true;
                        // });
                      },
                      onChanged: (value) {
                        setState(() {
                          showSearchResults = true;
                        });
                      },
                      decoration: InputDecoration(
                          suffixIcon: showSearchResults
                              ? IconButton(
                                  onPressed: () =>
                                      _textEditingController.clear(),
                                  icon: Icon(Icons.clear, color: Colors.grey),
                                )
                              : null,
                          isDense: true,
                          labelText: "Fuel innovation",
                          prefixIcon: Icon(
                            Icons.search,
                            size: 23,
                          )),
                      textInputAction: TextInputAction.go),
                ),
              ),
              showSearchResults
                  ? Expanded(
                      child: IconButton(
                          icon: Icon(Icons.filter_list,
                              color: navbarBackgroundColor),
                          onPressed: () {
                            showDialog(context: context, child: filterWidget());
                          }),
                      flex: 1)
                  : Container(height: 0, width: 0)
            ],
          ),
        ),
        Expanded(
          child: showSearchResults
              ? new SearchResults(
                  searchQuery: _textEditingController.value.text,
                  locationQuery: _selectedLocation ?? '',
                  industryQuery: _selectedIndustryId ?? '',
                )
              : Container(height: 0, width: 0),
        ),
      ],
    );
  }

  filterWidget() {
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
                            _selectedIndustry = industry;
                            // print(_selectedIndustry);
                          });
                          for (var i = 0; i < industryImages.length; i++)
                            if (industryImages[i]["industry"] == industry)
                              _selectedIndustryId = industryImages[i]["id"];
                        },
                        items: industryImages
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
                          _selectedIndustryId = null;
                          _selectedLocation = null;
                          _selectedIndustry = null;
                          setState(() {
                            showSearchResults = true;
                          });
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
                          setState(() {
                            showSearchResults = true;
                            _selectedLocation = _selectedLocation;
                            _selectedIndustryId = _selectedIndustryId;
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
