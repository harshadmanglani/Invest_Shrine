import 'package:MobileApp/backend/entrepreneurs/portfolio_list.dart';
import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
import 'package:MobileApp/screens/experiments/ven_portfolio_page.dart';
import 'package:flutter/material.dart';

class InvestorHomePage extends StatefulWidget {
  @override
  _InvestorHomePageState createState() => _InvestorHomePageState();
}

class _InvestorHomePageState extends State<InvestorHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  FocusNode _focusNode;
  TextEditingController _textEditingController;
  var tabHeaderStyle = TextStyle(fontSize: 15);

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  TabBar _getTabBar() {
    return TabBar(
      tabs: <Widget>[
        Tab(child: Text("Explore", style: tabHeaderStyle)),
        Tab(child: Text("Startups", style: tabHeaderStyle)),
        Tab(child: Text("SMEs", style: tabHeaderStyle))
      ],
      controller: tabController,
    );
  }

  TabBarView _getTabBarView(tabs) {
    return TabBarView(
      children: tabs,
      controller: tabController,
    );
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: drawerWidget(),
        body: GestureDetector(
          onTap: () {
            _focusNode.unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Expanded(
                flex: 2,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: FlatButton.icon(
                            onPressed: () {
                              _scaffoldKey.currentState.openDrawer();
                            },
                            icon: Icon(Icons.menu),
                            label: Container(
                              height: 0,
                              width: 0,
                            )),
                      ),
                    ),
                    Expanded(
                        flex: 10,
                        child: TextField(
                          controller: _textEditingController,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                              isDense: true, prefixIcon: Icon(Icons.search)),
                        )),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: IconButton(
                          onPressed: () {
                            print("onPressed FilterButton");
                          },
                          icon: Icon(Icons.filter_list),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(flex: 2, child: _getTabBar()),
              Expanded(
                flex: 26,
                child: _getTabBarView(
                    <Widget>[Explore(), AllStartups(), AllSMEs()]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  drawerWidget() {
    return Drawer();
  }
}

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          FeaturedVentures(),
          SizedBox(height: 25),
          // SeasonedEntrepreneurs(),
          IndustryVentures(),
          SizedBox(height: 30),
          GrowingFast(),
          SizedBox(height: 20),
          // SizedBox(height: 40),
        ],
      ),
    );
  }
}

class IndustryVentures extends StatefulWidget {
  @override
  _IndustryVenturesState createState() => _IndustryVenturesState();
}

class _IndustryVenturesState extends State<IndustryVentures> {
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
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 20),
          child: Text("Industry", style: textTheme.headline5),
        ),
        SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 2,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image:
                                    AssetImage(industryImages[index]["image"]),
                                fit: BoxFit.contain)),
                      ),
                    ),
                  ),
                );
              },
              itemCount: industryImages.length,
            ),
          ),
        ),
      ],
    );
  }
}

class FeaturedVentures extends StatefulWidget {
  @override
  _FeaturedVenturesState createState() => _FeaturedVenturesState();
}

class _FeaturedVenturesState extends State<FeaturedVentures> {
  Future venturePortfolioList;

  @override
  void initState() {
    super.initState();
    venturePortfolioList = VenturePortfolioListAPI().getAllVenturePortfolios();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 10),
          child: FlatButton(
            onPressed: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Text("Featured", style: textTheme.headline5),
                ),
                Expanded(flex: 1, child: Icon(Icons.arrow_forward))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 230,
          child: FutureBuilder(
              future: venturePortfolioList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // print(snapshot.data);
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ExploreVentureCard(
                          venturePortfolioModel: snapshot.data[index]);
                    },
                    itemCount: snapshot.data.length,
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ExploreVentureCard(venturePortfolioModel: null);
                      },
                      itemCount: 10);
                }
              }),
        ),
      ],
    );
  }
}

class SeasonedEntrepreneurs extends StatefulWidget {
  @override
  _SeasonedEntrepreneursState createState() => _SeasonedEntrepreneursState();
}

class _SeasonedEntrepreneursState extends State<SeasonedEntrepreneurs> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 10.0),
          child: FlatButton(
            onPressed: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Text("Seasoned Entrepreneurs",
                      style: textTheme.headline5),
                ),
                Expanded(flex: 1, child: Icon(Icons.arrow_forward))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/cofounder.png'),
                      ),
                    ),
                    SizedBox(
                      width: 138,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Sameer Gulati",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.headline6),
                            SizedBox(height: 3),
                            Text(
                                "Ex-CEO, Apple Computer in Cupertine HQ, USA, United States",
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyText1),
                            SizedBox(height: 3),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}

class GrowingFast extends StatefulWidget {
  @override
  _GrowingFastState createState() => _GrowingFastState();
}

class _GrowingFastState extends State<GrowingFast> {
  Future venturePortfolioList;

  @override
  void initState() {
    super.initState();
    venturePortfolioList = VenturePortfolioListAPI().getAllVenturePortfolios();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 10),
          child: FlatButton(
            onPressed: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Text("Growing Fast🔥", style: textTheme.headline5),
                ),
                Expanded(flex: 1, child: Icon(Icons.arrow_forward))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 230,
          child: FutureBuilder(
              future: venturePortfolioList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // print(snapshot.data);
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ExploreVentureCard(
                          venturePortfolioModel: snapshot.data[index]);
                    },
                    itemCount: snapshot.data.length,
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ExploreVentureCard(venturePortfolioModel: null);
                      },
                      itemCount: 10);
                }
              }),
        ),
      ],
    );
  }
}

class ExploreVentureCard extends StatefulWidget {
  final VenturePortfolioModel venturePortfolioModel;
  ExploreVentureCard({this.venturePortfolioModel});
  @override
  _ExploreVentureCardState createState() => _ExploreVentureCardState();
}

class _ExploreVentureCardState extends State<ExploreVentureCard> {
  VenturePortfolioModel venturePortfolioModel;

  @override
  Widget build(BuildContext context) {
    double mainImageHeight = 145,
        mainImageWidth = 230,
        logoImageHeight = 58,
        logoImageWidth = 58,
        paddingWidth = 10;
    double overflowWidth = mainImageWidth - logoImageWidth - paddingWidth;
    venturePortfolioModel = widget.venturePortfolioModel;
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: InkWell(
        onTap: venturePortfolioModel != null
            ? () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VenturePortfolioPage(
                            venturePortfolioModel: venturePortfolioModel)));
              }
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                height: mainImageHeight,
                width: mainImageWidth,
                decoration: venturePortfolioModel != null
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image:
                                NetworkImage(venturePortfolioModel.mainImage),
                            fit: BoxFit.cover),
                      )
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300])),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      height: logoImageHeight,
                      width: logoImageWidth,
                      decoration: venturePortfolioModel != null
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      venturePortfolioModel.logoImage),
                                  fit: BoxFit.cover),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[300])),
                  SizedBox(width: paddingWidth),
                  SizedBox(
                    width: overflowWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        venturePortfolioModel != null
                            ? Text(venturePortfolioModel.ventureName,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.headline6)
                            : Text('                                ',
                                style: TextStyle(
                                    backgroundColor: Colors.grey[200],
                                    fontSize: 12)),
                        SizedBox(height: 3),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              flex: 2,
                              child: venturePortfolioModel != null
                                  ? Text(venturePortfolioModel.industry[0],
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.bodyText1)
                                  : Text('                  ',
                                      style: TextStyle(
                                          backgroundColor: Colors.grey[200],
                                          fontSize: 12)),
                            ),
                            SizedBox(width: 4),
                            venturePortfolioModel != null
                                ? Flexible(
                                    child: Icon(Icons.local_hospital,
                                        size: 15, color: Colors.red),
                                  )
                                : Container(
                                    height: 0,
                                    width: 0,
                                  ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 2,
                              child: venturePortfolioModel != null
                                  ? Text(venturePortfolioModel.location,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.grey[700]))
                                  : Text('                      ',
                                      style: TextStyle(
                                          backgroundColor: Colors.grey[200],
                                          fontSize: 12)),
                            ),
                            SizedBox(width: 3),
                            venturePortfolioModel != null
                                ? Flexible(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.grey[600],
                                      size: 14,
                                    ),
                                  )
                                : Container(height: 0, width: 0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllStartups extends StatefulWidget {
  @override
  _AllStartupsState createState() => _AllStartupsState();
}

class _AllStartupsState extends State<AllStartups> {
  Future venturePortfolioList;

  @override
  void initState() {
    super.initState();
    venturePortfolioList = VenturePortfolioListAPI().getAllVenturePortfolios();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: venturePortfolioList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return StartupCard(
                  venturePortfolioModel: snapshot.data[index],
                );
              },
            );
          else
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return StartupCard(
                  venturePortfolioModel: null,
                );
              },
            );
        });
  }
}

class StartupCard extends StatefulWidget {
  final VenturePortfolioModel venturePortfolioModel;

  StartupCard({this.venturePortfolioModel});
  @override
  _StartupCardState createState() => _StartupCardState();
}

class _StartupCardState extends State<StartupCard> {
  VenturePortfolioModel venturePortfolioModel;
  @override
  Widget build(BuildContext context) {
    venturePortfolioModel = widget.venturePortfolioModel;
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0, top: 16),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                height: 90,
                decoration: venturePortfolioModel != null
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(venturePortfolioModel.mainImage)))
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300]),
              )),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 85,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: venturePortfolioModel != null
                            ? Text(
                                venturePortfolioModel.ventureName,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.headline6,
                              )
                            : Text(
                                '                                     ',
                                style: TextStyle(
                                    backgroundColor: Colors.grey[200]),
                              )),
                    SizedBox(height: 6),
                    Expanded(
                        flex: 2,
                        child: venturePortfolioModel != null
                            ? Text(
                                venturePortfolioModel.tagLine,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyText1
                                    .copyWith(color: Colors.grey[800]),
                              )
                            : Text(
                                '                                         \n                                         ',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    backgroundColor: Colors.grey[200]))),
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 2,
                                      child: venturePortfolioModel != null
                                          ? Text(
                                              venturePortfolioModel.industry[1],
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.bodyText1)
                                          : Container(height: 0, width: 0),
                                    ),
                                    SizedBox(width: 4),
                                    venturePortfolioModel != null
                                        ? Flexible(
                                            child: Icon(Icons.local_hospital,
                                                size: 15, color: Colors.red),
                                          )
                                        : Container(
                                            height: 0,
                                            width: 0,
                                          ),
                                  ],
                                )),
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: venturePortfolioModel != null
                                          ? Icon(
                                              Icons.location_on,
                                              color: Colors.grey[500],
                                              size: 14,
                                            )
                                          : Container(height: 0, width: 0),
                                    ),
                                    SizedBox(width: 3),
                                    Expanded(
                                      flex: 3,
                                      child: venturePortfolioModel != null
                                          ? Text(venturePortfolioModel.location,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey[600]))
                                          : Container(height: 0, width: 0),
                                    ),
                                  ],
                                ))
                          ],
                        )),
                    SizedBox(height: 4)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AllSMEs extends StatefulWidget {
  @override
  _AllSMEsState createState() => _AllSMEsState();
}

class _AllSMEsState extends State<AllSMEs> {
  Future venturePortfolioList;

  @override
  void initState() {
    super.initState();
    venturePortfolioList = VenturePortfolioListAPI().getAllVenturePortfolios();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20),
      child: FutureBuilder(
          future: venturePortfolioList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return SMECard(
                      venturePortfolioModel: snapshot.data[index],
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.70,
                    mainAxisSpacing: 25.0,
                    crossAxisSpacing: 12.0,
                    crossAxisCount: 2,
                  ));
            else
              return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SMECard(
                      venturePortfolioModel: null,
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 25.0,
                    crossAxisSpacing: 12.0,
                    crossAxisCount: 2,
                  ));
          }),
    );
  }
}

class SMECard extends StatefulWidget {
  final VenturePortfolioModel venturePortfolioModel;
  SMECard({this.venturePortfolioModel});
  @override
  _SMECardState createState() => _SMECardState();
}

class _SMECardState extends State<SMECard> {
  VenturePortfolioModel venturePortfolioModel;
  @override
  Widget build(BuildContext context) {
    venturePortfolioModel = widget.venturePortfolioModel;
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Container(
                decoration: venturePortfolioModel != null
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(venturePortfolioModel.mainImage)))
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300]),
              )),
          Expanded(
            flex: 4,
            child: SizedBox(
              // height: 85,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    // Expanded(
                    // flex: 2,
                    // child:
                    venturePortfolioModel != null
                        ? Text(
                            venturePortfolioModel.ventureName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: textTheme.headline6,
                          )
                        : Text(
                            '                                     ',
                            style: TextStyle(backgroundColor: Colors.grey[200]),
                          ),
                    SizedBox(height: 8), //),
                    // Expanded(
                    // flex: 3,
                    // child:
                    venturePortfolioModel != null
                        ? Text(
                            venturePortfolioModel.tagLine,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyText1.copyWith(
                                color: Colors.grey[800], fontSize: 14),
                          )
                        : Text(
                            '                                         \n                                         ',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                backgroundColor: Colors.grey[200])), //),
                    // Expanded(
                    // flex: 1,
                    // child:
                    SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  flex: 2,
                                  child: venturePortfolioModel != null
                                      ? Text(venturePortfolioModel.industry[1],
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.bodyText1)
                                      : Container(height: 0, width: 0),
                                ),
                                SizedBox(width: 2),
                                venturePortfolioModel != null
                                    ? Flexible(
                                        child: Icon(Icons.local_hospital,
                                            size: 15, color: Colors.red),
                                      )
                                    : Container(
                                        height: 0,
                                        width: 0,
                                      ),
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: venturePortfolioModel != null
                                      ? Icon(
                                          Icons.location_on,
                                          color: Colors.grey[500],
                                          size: 14,
                                        )
                                      : Container(height: 0, width: 0),
                                ),
                                SizedBox(width: 2),
                                Expanded(
                                  flex: 3,
                                  child: venturePortfolioModel != null
                                      ? Text(venturePortfolioModel.location,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14))
                                      : Container(height: 0, width: 0),
                                ),
                              ],
                            ))
                      ],
                    ) //),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
