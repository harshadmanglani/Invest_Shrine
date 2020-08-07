import 'package:MobileApp/backend/entrepreneurs/portfolio_list.dart';
import 'package:MobileApp/models/entrepreneurs/entrepreneur_model.dart';
import 'package:MobileApp/screens/investors/inv_home_page.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatefulWidget {
  final String searchQuery;
  final String locationQuery;
  final String industryQuery;
  SearchResults({this.searchQuery, this.industryQuery, this.locationQuery})
      : assert(locationQuery != null, industryQuery != null);
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults>
    with SingleTickerProviderStateMixin {
  Future ventureSearchResults;
  Future entrepreneurSearchResults;
  TabController tabController;
  String finalQuery;
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
    print(widget.industryQuery);
    print(widget.locationQuery);
    return widget.searchQuery != ''
        ? Column(
            children: <Widget>[
              SizedBox(height: 60, child: _getTabBar()),
              Expanded(
                  child: _getTabBarView(
                      [ventureSearchWidget(), entrepreneurSearchWidget()]))
            ],
          )
        : Container(height: 0, width: 0);
  }

  ventureSearchWidget() {
    finalQuery = '(ventureName: "${widget.searchQuery}")';
    // widget.industryQuery != ''
    //     ? finalQuery = finalQuery + ', industry: "${widget.industryQuery}"'
    //     : () {};
    // finalQuery = finalQuery + ')';
    // print(finalQuery);
    // print("industry: ${widget.industryQuery}");
    ventureSearchResults = VenturePortfolioListAPI()
        .getAllVenturePortfolios(searchQuery: finalQuery);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
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
    entrepreneurSearchResults = widget.searchQuery.split(' ').length == 1
        ? EntrepreneurPortfolioListAPI().getAllEntrepreneurPortfolios(
            searchQuery: '(firstName: "${widget.searchQuery.split(' ')[0]}")')
        : EntrepreneurPortfolioListAPI().getAllEntrepreneurPortfolios(
            searchQuery:
                '(firstName: "${widget.searchQuery.split(' ')[0]}", lastName: "${widget.searchQuery.split(' ')[1]}")');
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

class EntrepreneurCard extends StatefulWidget {
  final EntrepreneurPortfolioModel entrepreneurPortfolioModel;
  EntrepreneurCard({this.entrepreneurPortfolioModel});
  @override
  _EntrepreneurCardState createState() => _EntrepreneurCardState();
}

class _EntrepreneurCardState extends State<EntrepreneurCard> {
  EntrepreneurPortfolioModel entrepreneurPortfolioModel;
  @override
  Widget build(BuildContext context) {
    entrepreneurPortfolioModel = widget.entrepreneurPortfolioModel;
    var textTheme = Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        Row(
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
                          style: textTheme.headline6)
                      : Text("                              ",
                          style: TextStyle(backgroundColor: Colors.grey[200])),
                  SizedBox(height: 10),
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
        SizedBox(height: 8),
        Divider(color: Colors.grey[300]),
      ],
    );
  }
}
