import 'package:MobileApp/backend/investors/portfolio_list.dart';
import 'package:MobileApp/screens/entrepreneurs/ent_home_page.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';

class InvestorSearch extends StatefulWidget {
  @override
  _InvestorSearchState createState() => _InvestorSearchState();
}

class _InvestorSearchState extends State<InvestorSearch> {
  bool showSearchResults = false;
  TextEditingController _textEditingController;
  bool isFilterApplied = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  List<String> _locations = ['Pune', 'Bangalore', 'Chennai', 'Delhi'];

  String _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 2,
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: navbarBackgroundColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })),
              SizedBox(width: 15),
              Expanded(
                flex: 17,
                child: TextField(
                  onChanged: (value) {
                    value != ''
                        ? setState(() {
                            showSearchResults = true;
                          })
                        : setState(() {
                            showSearchResults = false;
                          });
                  },
                  controller: _textEditingController,
                  decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Search"),
                ),
              ),
              // SizedBox(width: 5),
              Expanded(
                  flex: 2,
                  child: showSearchResults
                      ? InkWell(
                          onTap: () {
                            showDialog(context: context, child: filterWidget());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: isFilterApplied
                                    ? navbarBackgroundColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(9)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 6.0, bottom: 6.0, left: 3.0, right: 3.0),
                              child: Icon(Icons.filter_list,
                                  color: isFilterApplied
                                      ? Colors.white
                                      : navbarBackgroundColor),
                            ),
                          ),
                        )
                      : Container(height: 0, width: 0)),
              SizedBox(width: 5)
            ],
          )),
      body: Column(
        children: [
          Expanded(
            flex: 23,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  showSearchResults
                      ? InvestorSearchResults(
                          searchQuery: _textEditingController.value.text,
                          locationQuery: _selectedLocation ?? '',
                        )
                      : Container(height: 0, width: 0)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  filterWidget() {
    return AlertDialog(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        title: Text("Filters"),
        content: Container(
          height: 215,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: StatefulBuilder(
                      builder: (context, setState) => DropdownButton(
                        hint: Text('Location'), // Not necessary for Option 1
                        value: _selectedLocation,

                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                            // print(_selectedLocation);
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
                  ),
                ],
              ),
              SizedBox(height: 10),
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
                        setState(() {
                          showSearchResults = true;
                          _selectedLocation = null;
                          isFilterApplied = false;
                        });
                        Navigator.pop(context);
                      },
                      child:
                          Text("Clear", style: TextStyle(color: Colors.white)),
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
                          isFilterApplied = true;
                        });
                        Navigator.pop(context);
                      },
                      child:
                          Text("Apply", style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class InvestorSearchResults extends StatefulWidget {
  final String searchQuery;
  final String locationQuery;
  InvestorSearchResults({this.locationQuery = '', this.searchQuery})
      : assert(locationQuery != null);
  @override
  _InvestorSearchResultsState createState() => _InvestorSearchResultsState();
}

class _InvestorSearchResultsState extends State<InvestorSearchResults> {
  Future investorPortfolioList;
  String finalQuery = '';
  String locationQuery = '';

  @override
  Widget build(BuildContext context) {
    finalQuery = widget.searchQuery.split(' ').length == 1
        ? '(firstName: "${widget.searchQuery.split(' ')[0]}"'
        : '(firstName: "${widget.searchQuery.split(' ')[0]}", lastName: "${widget.searchQuery.split(' ')[1]}"';
    locationQuery = widget.locationQuery != ''
        ? ', location: "${widget.locationQuery}"'
        : ')';
    finalQuery = finalQuery + locationQuery;

    investorPortfolioList = InvestorPortfolioListAPI()
        .getAllInvestorPortfolios(searchQuery: finalQuery);

    return FutureBuilder(
      future: investorPortfolioList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.length == 0) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("No results found."),
            );
          } else
            return GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: AllInvestorCard(
                        investorPortfolioModel: snapshot.data[index]),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 4,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 0.0,
                  crossAxisCount: 2,
                ));
        } else {
          return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: AllInvestorCard(investorPortfolioModel: null),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 4,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 0.0,
                crossAxisCount: 2,
              ));
        }
      },
    );
  }
}
