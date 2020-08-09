import 'package:MobileApp/screens/investors/ent_portfolio_page.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:MobileApp/backend/entrepreneurs/portfolio_list.dart';
import 'package:MobileApp/models/entrepreneurs/entrepreneur_model.dart';
import 'package:MobileApp/screens/investors/inv_home_page.dart';
import '../../backend/industry_images.dart';

class VentureSearch extends StatefulWidget {
  @override
  _VentureSearchState createState() => _VentureSearchState();
}

class _VentureSearchState extends State<VentureSearch> {
  TextEditingController _textEditingController;
  FocusNode _searchNode;
  bool showSearchResults = false;
  bool isFilterApplied = false;
  bool showIndustryFilter = true;

  @override
  void initState() {
    super.initState();

    _searchNode = new FocusNode();
    _textEditingController = new TextEditingController();
  }

  List<String> _locations = ['Pune', 'Bangalore', 'Chennai', 'Delhi'];

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
                      focusNode: _searchNode,
                      controller: _textEditingController,
                      onChanged: (value) {
                        value != ''
                            ? setState(() {
                                showSearchResults = true;
                              })
                            : setState(() {
                                showSearchResults = false;
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
                      child: InkWell(
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
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Icon(Icons.filter_list,
                                color: isFilterApplied
                                    ? Colors.white
                                    : navbarBackgroundColor),
                          ),
                        ),
                      ),
                      flex: 1)
                  : Container(height: 0, width: 0),
              SizedBox(width: 10)
            ],
          ),
        ),
        Expanded(
          child: showSearchResults
              ? new VentureSearchResults(
                  searchQuery: _textEditingController.value.text,
                  locationQuery: _selectedLocation ?? '',
                  industryQuery: _selectedIndustryId ?? '',
                  tabCallback: (value) {
                    showIndustryFilter = value;
                  },
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
        content: Container(
          height: showIndustryFilter ? 215 : 170,
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
              showIndustryFilter
                  ? Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: StatefulBuilder(
                            builder: (context, setState) =>
                                DropdownButton<dynamic>(
                              hint: Text(
                                  'Industry'), // Not necessary for Option 1
                              value: _selectedIndustry,
                              isExpanded: true,
                              onChanged: (industry) {
                                setState(() {
                                  _selectedIndustry = industry;
                                  // print(_selectedIndustry);
                                });
                                for (var i = 0; i < industryImages.length; i++)
                                  if (industryImages[i]["industry"] == industry)
                                    _selectedIndustryId =
                                        industryImages[i]["id"];
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
                        ),
                      ],
                    )
                  : Container(height: 0, width: 0),
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
                          _selectedIndustryId = null;
                          _selectedLocation = null;
                          _selectedIndustry = null;
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

class VentureSearchResults extends StatefulWidget {
  final String searchQuery;
  final String locationQuery;
  final String industryQuery;
  final Function tabCallback;
  VentureSearchResults(
      {this.searchQuery,
      this.industryQuery,
      this.locationQuery,
      this.tabCallback})
      : assert(locationQuery != null, industryQuery != null);
  @override
  _VentureSearchResultsState createState() => _VentureSearchResultsState();
}

class _VentureSearchResultsState extends State<VentureSearchResults>
    with SingleTickerProviderStateMixin {
  Future ventureSearchResults;
  Future entrepreneurSearchResults;
  TabController tabController;
  String finalQuery;
  String locationQuery;
  String industryQuery;
  var tabHeaderStyle = TextStyle(fontSize: 15);

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (tabController.index == 0)
        widget.tabCallback(true);
      else
        widget.tabCallback(false);
    });
  }

  TabBar _getTabBar() {
    return TabBar(
      indicatorColor: navbarBackgroundColor,
      tabs: <Widget>[
        Tab(child: Text("Startups & SMEs", style: tabHeaderStyle)),
        Tab(child: Text("Entrepreneurs", style: tabHeaderStyle)),
      ],
      controller: tabController,
    );
  }

  TabBarView _getTabBarView(List<Widget> tabs) {
    return TabBarView(
      children: tabs,
      controller: tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 60, child: _getTabBar()),
        Expanded(
            child: _getTabBarView(
                [ventureSearchWidget(), entrepreneurSearchWidget()]))
      ],
    );
  }

  ventureSearchWidget() {
    finalQuery = '(ventureName: "${widget.searchQuery}"';
    industryQuery = widget.industryQuery != ''
        ? ', industry: "${widget.industryQuery}"'
        : '';
    locationQuery = widget.locationQuery != ''
        ? ', location: "${widget.locationQuery}"'
        : '';
    finalQuery = finalQuery + industryQuery + ')';
    ventureSearchResults = VenturePortfolioListAPI()
        .getAllVenturePortfolios(searchQuery: finalQuery);
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: FutureBuilder(
        future: ventureSearchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.length != 0)
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      StartupCard(venturePortfolioModel: snapshot.data[index]));
            else
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("No results found."),
              );
          } else {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) =>
                    StartupCard(venturePortfolioModel: null));
          }
        },
      ),
    );
  }

  entrepreneurSearchWidget() {
    finalQuery = widget.searchQuery.split(' ').length == 1
        ? '(firstName: "${widget.searchQuery.split(' ')[0]}"'
        : '(firstName: "${widget.searchQuery.split(' ')[0]}", lastName: "${widget.searchQuery.split(' ')[1]}"';
    locationQuery = widget.locationQuery != ''
        ? ', location: "${widget.locationQuery}")'
        : ')';
    finalQuery = finalQuery + locationQuery;
    entrepreneurSearchResults = EntrepreneurPortfolioListAPI()
        .getAllEntrepreneurPortfolios(searchQuery: finalQuery);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.length != 0) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => EntrepreneurCard(
                        entrepreneurPortfolioModel: snapshot.data[index]));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("No results found."),
                );
              }
            } else {
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) =>
                      EntrepreneurCard(entrepreneurPortfolioModel: null));
            }
          },
          future: entrepreneurSearchResults),
    );
  }
}

class EntrepreneurCard extends StatelessWidget {
  final EntrepreneurPortfolioModel entrepreneurPortfolioModel;
  EntrepreneurCard({this.entrepreneurPortfolioModel});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: entrepreneurPortfolioModel != null
            ? () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => EntrepreneurPortfolioPage(
                              entrepreneurPortfolioModel:
                                  entrepreneurPortfolioModel,
                              personalPortfolio: false,
                            )));
              }
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: entrepreneurPortfolioModel != null
                    ? CircleAvatar(
                        radius: (45),
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(65),
                          child: Image.network(
                              entrepreneurPortfolioModel.displayImage),
                        ))
                    : CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 45,
                      )),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5),
                  entrepreneurPortfolioModel != null
                      ? Text(
                          "${entrepreneurPortfolioModel.firstName} ${entrepreneurPortfolioModel.lastName}",
                          style: textTheme.headline6.copyWith(fontSize: 17))
                      : Text("                              ",
                          style: TextStyle(backgroundColor: Colors.grey[200])),
                  SizedBox(height: 5),
                  entrepreneurPortfolioModel != null
                      ? Text("Co-Founder @ Apple Computer, USA",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: textTheme.bodyText1)
                      : Text("                         ",
                          style: TextStyle(backgroundColor: Colors.grey[200]))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
