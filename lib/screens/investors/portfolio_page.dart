import 'package:MobileApp/backend/entrepreneurs/portfolio_list.dart';
import 'package:MobileApp/models/entrepreneurs/entrepreneur_model.dart';
import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
import 'package:MobileApp/shared/custom_expanded_tile.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app.dart';
import 'package:expandable/expandable.dart';

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  TextStyle standardTextStyle;
  ScrollController _scrollController;
  TabController _tabController;
  VentureModel portfolio;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController()..addListener(() => setState(() {}));
  }

  bool get _showTitle {
    return _scrollController.hasClients &&
        _scrollController.offset > 210 - kToolbarHeight;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context).settings.arguments;
    portfolio = arguments['portfolio'];
    standardTextStyle = Theme.of(context).textTheme.caption;
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  shape: appBarShape,
                  expandedHeight: 210.0,
                  floating: false,
                  pinned: true,
                  centerTitle: true,
                  leading: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: navbarBackgroundColor),
                    child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  title: _showTitle
                      ? Text(
                          portfolio.ventureName,
                          style: standardTextStyle.copyWith(
                              color: Colors.white, fontSize: 18.0),
                        )
                      : null,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Image.asset(
                        'assets/images/livehealth.png',
                        fit: BoxFit.cover,
                      )),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: "Pitch"),
                        Tab(text: "Discuss"),
                        Tab(text: "Updates")
                      ],
                    ),
                  ),
                  pinned: false,
                ),
              ];
            },
            body: TabBarView(controller: _tabController, children: <Widget>[
              pitchWidget(),
              Center(child: Text("Nothing to discuss yet.")),
              Center(child: Text("No updates yet.")),
            ]),
          ),
        ),
      ),
    );
  }

  pitchWidget() {
    return ListView(
      controller: ScrollController(),
      primary: false,
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomExpandedTile(
                  title: "Startup Summary", content: portfolio.startupSummary),
              SizedBox(height: 20),
              ExpandablePanel(
                  theme: ExpandableThemeData(iconColor: navbarBackgroundColor),
                  header: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Co Founders",
                      style: standardTextStyle.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  collapsed: Container(height: 0, width: 0),
                  expanded: FutureBuilder(
                      future: EntrepreneurPortfolioList()
                          .getAllEntrepreneurPortfolios(
                              searchQuery: '(venture: "${portfolio.id}")'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          print(snapshot.data);
                          List<EntrepreneurModel> entrepreneurPortfolios =
                              snapshot.data;
                          return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        coFounderWidget(
                                            entrepreneurPortfolios[index]),
                                    itemCount: snapshot.data.length,
                                  ),
                                ),
                              ]);
                        } else {
                          return Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              child: Container(
                                  child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Row(children: <Widget>[
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            "              " +
                                                " " +
                                                "             ",
                                            style: TextStyle(
                                                backgroundColor:
                                                    Colors.grey[200]),
                                          ),
                                        ),
                                      ]))));
                        }
                      })),
              SizedBox(height: 20),
              // CustomExpandedTile(title: "Our Analysis", content: longText),
              // SizedBox(height: 20),
              // CustomExpandedTile(title: "Contact", content: longText),
              // SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  coFounderWidget(EntrepreneurModel entrepreneurPortfolio) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: <Widget>[
            Expanded(
              flex: 4,
              child: Text(entrepreneurPortfolio.firstName +
                  " " +
                  entrepreneurPortfolio.lastName),
            ),
            // IconButton(
            //     icon: Container(
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(40),
            //           color: navbarBackgroundColor),
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Icon(Icons.arrow_forward_ios, size: 15.0),
            //       ),
            //     ),
            //     onPressed: () {})
            FlatButton(
              onPressed: () {
                _launchURL(entrepreneurPortfolio.linkedinProfile);
              },
              child: Text(
                "View",
                style: TextStyle(
                    color: navbarBackgroundColor,
                    fontSize: 15.0,
                    decoration: TextDecoration.underline),
              ),
            )
          ]),
        ),
      ),
    );
  }

  tabBarTitle(String title) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "$title",
        ));
  }

  linksButtonBar() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 28.0),
          child: RaisedButton(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            color: Colors.white,
            onPressed: () {
              _launchURL("https://google.com");
            },
            child: Row(
              children: <Widget>[
                Text('Website'),
                SizedBox(width: 10.0),
                Icon(Icons.launch, color: navbarBackgroundColor, size: 20)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 38.0, right: 0.0),
          child: RaisedButton(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            color: Colors.white,
            onPressed: () {
              _launchURL("https://linkedin.com/");
            },
            child: Row(
              children: <Widget>[
                Text('LinkedIn'),
                SizedBox(width: 10.0),
                Image.asset('assets/images/linkedin.png', height: 20, width: 20)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
