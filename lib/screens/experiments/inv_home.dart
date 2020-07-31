import 'package:MobileApp/backend/entrepreneurs/portfolio_list.dart';
import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
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

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  TabBar _getTabBar() {
    return TabBar(
      tabs: <Widget>[
        Tab(text: "Explore"),
        Tab(text: "Startups"),
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
                              // contentPadding:
                              //     EdgeInsets.only(top: 40, bottom: 40),
                              isDense: true,
                              prefixIcon: Icon(Icons.search)),
                        )),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.filter_list),
                            label: Container(
                              height: 0,
                              width: 0,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(flex: 2, child: _getTabBar()),
              Expanded(
                flex: 26,
                child: _getTabBarView(<Widget>[
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        FeaturedVentures(),
                        SizedBox(height: 20),
                        // SeasonedEntrepreneurs(),
                        IndustryVentures(),
                        SizedBox(height: 20),
                        GrowingFast(),
                        SizedBox(height: 20),
                        // SizedBox(height: 40),
                      ],
                    ),
                  ),
                  AllVentures()
                ]),
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
                  print(snapshot.data);
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ExploreVentureCard(
                          venturePortfolio: snapshot.data[index]);
                    },
                    itemCount: snapshot.data.length,
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ExploreVentureCard(venturePortfolio: null);
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
                  print(snapshot.data);
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ExploreVentureCard(
                          venturePortfolio: snapshot.data[index]);
                    },
                    itemCount: snapshot.data.length,
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ExploreVentureCard(venturePortfolio: null);
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
  final VentureModel venturePortfolio;
  ExploreVentureCard({this.venturePortfolio});
  @override
  _ExploreVentureCardState createState() => _ExploreVentureCardState();
}

class _ExploreVentureCardState extends State<ExploreVentureCard> {
  VentureModel venturePortfolio;

  @override
  Widget build(BuildContext context) {
    double mainImageHeight = 145,
        mainImageWidth = 230,
        logoImageHeight = 58,
        logoImageWidth = 58,
        paddingWidth = 10;
    double overflowWidth = mainImageWidth - logoImageWidth - paddingWidth;
    venturePortfolio = widget.venturePortfolio;
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: mainImageHeight,
              width: mainImageWidth,
              decoration: venturePortfolio != null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(venturePortfolio.mainImage),
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
                    decoration: venturePortfolio != null
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(venturePortfolio.logoImage),
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
                      venturePortfolio != null
                          ? Text(venturePortfolio.ventureName,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.headline6.copyWith(fontSize: 17))
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
                            child: venturePortfolio != null
                                ? Text(venturePortfolio.industry[0],
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.bodyText1)
                                : Text('                  ',
                                    style: TextStyle(
                                        backgroundColor: Colors.grey[200],
                                        fontSize: 12)),
                          ),
                          SizedBox(width: 4),
                          venturePortfolio != null
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
                            child: venturePortfolio != null
                                ? Text(venturePortfolio.location,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.grey[700]))
                                : Text('                      ',
                                    style: TextStyle(
                                        backgroundColor: Colors.grey[200],
                                        fontSize: 12)),
                          ),
                          SizedBox(width: 3),
                          venturePortfolio != null
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
    );
  }
}

class AllVentures extends StatefulWidget {
  @override
  _AllVenturesState createState() => _AllVenturesState();
}

class _AllVenturesState extends State<AllVentures> {
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
                return VentureCard(
                  venturePortfolio: snapshot.data[index],
                );
              },
            );
          else
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return VentureCard(
                  venturePortfolio: null,
                );
              },
            );
        });
  }
}

class VentureCard extends StatefulWidget {
  final VentureModel venturePortfolio;

  VentureCard({this.venturePortfolio});
  @override
  _VentureCardState createState() => _VentureCardState();
}

class _VentureCardState extends State<VentureCard> {
  VentureModel venturePortfolio;
  @override
  Widget build(BuildContext context) {
    venturePortfolio = widget.venturePortfolio;
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0, top: 16),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                height: 90,
                decoration: venturePortfolio != null
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(venturePortfolio.mainImage)))
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
                        child: venturePortfolio != null
                            ? Text(
                                venturePortfolio.ventureName,
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
                        child: venturePortfolio != null
                            ? Text(
                                venturePortfolio.tagLine,
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
                                      child: venturePortfolio != null
                                          ? Text(venturePortfolio.industry[1],
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.bodyText1)
                                          : Container(height: 0, width: 0),
                                    ),
                                    SizedBox(width: 4),
                                    venturePortfolio != null
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
                                      child: venturePortfolio != null
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
                                      child: venturePortfolio != null
                                          ? Text(venturePortfolio.location,
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
