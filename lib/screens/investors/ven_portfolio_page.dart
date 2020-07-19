import 'package:MobileApp/backend/entrepreneurs/portfolio_list.dart';
import 'package:MobileApp/models/entrepreneurs/entrepreneur_model.dart';
import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
import 'package:MobileApp/shared/custom_expanded_tile.dart';
import 'package:MobileApp/shared/industry_widget.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app.dart';
import 'package:expandable/expandable.dart';

class VenturePortfolioPage extends StatefulWidget {
  @override
  _VenturePortfolioPageState createState() => _VenturePortfolioPageState();
}

class _VenturePortfolioPageState extends State<VenturePortfolioPage>
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

  launchURL(String url) async {
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
            // physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  shape: appBarShape,
                  expandedHeight: 210.0,
                  forceElevated: innerBoxIsScrolled,
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
                      collapseMode: CollapseMode.pin,
                      centerTitle: true,
                      background: Image.asset(
                        arguments['assetLink'],
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
                        Tab(child: Text("Pitch")),
                        Tab(child: Text("Discuss")),
                        Tab(child: Text("Updates"))
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
    return Container(
      child: ListView.builder(
          // key: PageStorageKey<String>(listKey),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 20,
          //itemExtent: 1.0,
          itemBuilder: (context, index) {
            return new ListTile(
              title: new Text("Item $index"),
            );
          }),
    );
    var constEntrepreneurCFListWidget = EntrepreneurCFList(portfolio.id);
    return ListView(
      // controller: ScrollController(),
      addAutomaticKeepAlives: true,
      primary: true,
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 12.0, 5.0, 12.0),
                      child: Text(
                        portfolio.ventureName,
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 30.0),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: linksButtonBar())
                ],
              ),
              SizedBox(height: 10),
              Text(
                portfolio.tagLine,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: standardTextStyle,
              ),
              SizedBox(height: 30),
              IndustryWidget(industry: portfolio.industry, limitToTwo: false),
              SizedBox(height: 20),
              Text("Funding Goal: Rs. ${portfolio.investment}",
                  style: standardTextStyle.copyWith(
                    // fontWeight: FontWeight.w600,
                    fontSize: 18,
                    // decoration: TextDecoration.underline)
                  )),
              SizedBox(height: 20),
              CustomExpandedTile(
                  title: "Startup Summary",
                  content: portfolio.startupSummary,
                  initallyExpanded: false,
                  hasIcon: true),
              SizedBox(height: 20),
              constEntrepreneurCFListWidget,
            ],
          ),
        ),
      ],
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
        IconButton(
            icon: Icon(Icons.launch, color: navbarBackgroundColor),
            onPressed: () {
              launchURL(portfolio.website);
            }),
        IconButton(
            icon: Image.asset('assets/images/linkedin.png',
                height: 21, width: 21),
            onPressed: () {
              launchURL(portfolio.vLinkedinProfile);
            })
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

class EntrepreneurCFList extends StatefulWidget {
  final String id;
  EntrepreneurCFList(this.id);

  @override
  _EntrepreneurCFListState createState() => _EntrepreneurCFListState();
}

class _EntrepreneurCFListState extends State<EntrepreneurCFList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var standardTextStyle = Theme.of(context).textTheme.caption;

    return ExpandablePanel(
        theme: ExpandableThemeData(iconColor: navbarBackgroundColor),
        header: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "Co Founders",
            style: standardTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        collapsed: Container(height: 0, width: 0),
        expanded: FutureBuilder(
            future: EntrepreneurPortfolioListAPI().getAllEntrepreneurPortfolios(
                searchQuery: '(venture: "${widget.id}")'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data);
                List<EntrepreneurModel> entrepreneurPortfolios = snapshot.data;
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.loose,
                        child: ListView.builder(
                          addAutomaticKeepAlives: true,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              EntrepreneurWidget(entrepreneurPortfolios[index]),
                          itemCount: snapshot.data.length,
                        ),
                      ),
                    ]);
              } else {
                return Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Container(
                        child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "              " + " " + "             ",
                                  style: TextStyle(
                                      backgroundColor: Colors.grey[200]),
                                ),
                              ),
                            ]))));
              }
            }));
  }
}

class EntrepreneurWidget extends StatefulWidget {
  final EntrepreneurModel entrepreneurPortfolio;

  EntrepreneurWidget(this.entrepreneurPortfolio);

  @override
  _EntrepreneurWidgetState createState() => _EntrepreneurWidgetState();
}

class _EntrepreneurWidgetState extends State<EntrepreneurWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  EntrepreneurModel entrepreneurPortfolio;
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    entrepreneurPortfolio = widget.entrepreneurPortfolio;
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, top: 0.0, bottom: 0.0, right: 8.0),
          child: Row(children: <Widget>[
            Expanded(
              flex: 4,
              child: Text(entrepreneurPortfolio.firstName +
                  " " +
                  entrepreneurPortfolio.lastName),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, '/entrepreneur_portfolio_page');
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
}
