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
import 'ven_portfolio_card.dart';

class VenturePortfolioPage extends StatefulWidget {
  @override
  _VenturePortfolioPageState createState() => _VenturePortfolioPageState();
}

class _VenturePortfolioPageState extends State<VenturePortfolioPage>
    with SingleTickerProviderStateMixin {
  TextStyle standardTextStyle;
  TabController _tabController;
  VenturePortfolioModel venturePortfolioModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
    venturePortfolioModel = arguments['venturePortfolioModel'];
    standardTextStyle = Theme.of(context).textTheme.caption;
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  shape: appBarShape,
                  expandedHeight: 210.0,
                  forceElevated: innerBoxIsScrolled,
                  floating: false,
                  pinned: true,
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
                  flexibleSpace: FlexibleSpaceBar(
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
    var constEntrepreneurCFListWidget = EntrepreneurCFList(
        venturePortfolioModel.id, venturePortfolioModel.ventureName);
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
                        venturePortfolioModel.ventureName,
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
                venturePortfolioModel.tagLine,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: standardTextStyle,
              ),
              SizedBox(height: 30),
              IndustryWidget(
                  industry: venturePortfolioModel.industry, limitToTwo: false),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(text: 'Funding Goal: '),
                    TextSpan(
                        text:
                            'Rs. ${priceFormatter(venturePortfolioModel.investment)}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CustomExpandedTile(
                  title: "Startup Summary",
                  content: venturePortfolioModel.startupSummary,
                  initallyExpanded: false,
                  hasIcon: true),
              SizedBox(height: 20),
              constEntrepreneurCFListWidget,
              SizedBox(height: 30)
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
              launchURL(venturePortfolioModel.website);
            }),
        IconButton(
            icon: Image.asset('assets/images/linkedin.png',
                height: 21, width: 21),
            onPressed: () {
              launchURL(venturePortfolioModel.vLinkedinProfile);
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
  final String ventureName;
  EntrepreneurCFList(this.id, this.ventureName);

  @override
  _EntrepreneurCFListState createState() => _EntrepreneurCFListState();
}

class _EntrepreneurCFListState extends State<EntrepreneurCFList> {
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
                          itemBuilder: (context, index) => EntrepreneurWidget(
                              entrepreneurPortfolios[index],
                              widget.ventureName),
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
  final String ventureName;
  EntrepreneurWidget(this.entrepreneurPortfolio, this.ventureName);

  @override
  _EntrepreneurWidgetState createState() => _EntrepreneurWidgetState();
}

class _EntrepreneurWidgetState extends State<EntrepreneurWidget> {
  String ventureName;
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
    ventureName = widget.ventureName;
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
                Navigator.pushNamed(context, '/entrepreneur_portfolio_page',
                    arguments: {
                      'entrepreneurPortfolio': entrepreneurPortfolio,
                      'ventureName': ventureName
                    });
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
