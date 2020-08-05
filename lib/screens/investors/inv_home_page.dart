import 'package:MobileApp/backend/entrepreneurs/portfolio_list.dart';
import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
import 'package:MobileApp/screens/investors/ven_portfolio_page.dart';
import 'package:MobileApp/shared/nav_drawer.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';

class InvestorHomePage extends StatefulWidget {
  @override
  _InvestorHomePageState createState() => _InvestorHomePageState();
}

class _InvestorHomePageState extends State<InvestorHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  var tabHeaderStyle = TextStyle(fontSize: 15);

  @override
  void initState() {
    super.initState();
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
        Tab(child: Text("SMEs", style: tabHeaderStyle)),
      ],
      indicatorColor: navbarBackgroundColor,
      controller: tabController,
    );
  }

  TabBarView _getTabBarView(tabs) {
    return TabBarView(
      children: tabs,
      controller: tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15),
        Expanded(flex: 2, child: _getTabBar()),
        Expanded(
          flex: 26,
          child: _getTabBarView(<Widget>[Explore(), AllStartups(), AllSMEs()]),
        ),
      ],
    );
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
                  List<VenturePortfolioModel> venturePortfolios = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ExploreVentureCard(
                          venturePortfolioModel: venturePortfolios[index]);
                    },
                    itemCount: venturePortfolios.length,
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

class ExploreVentureCard extends StatelessWidget {
  final VenturePortfolioModel venturePortfolioModel;
  ExploreVentureCard({this.venturePortfolioModel});

  @override
  Widget build(BuildContext context) {
    double mainImageHeight = 130,
        mainImageWidth = 200,
        logoImageHeight = 53,
        logoImageWidth = 53,
        paddingWidth = 10;
    double overflowWidth = mainImageWidth - logoImageWidth - paddingWidth;
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
                                style:
                                    textTheme.headline6.copyWith(fontSize: 16))
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
                                      style: textTheme.bodyText2
                                          .copyWith(fontSize: 13))
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
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 13))
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
    return Column(
      children: <Widget>[
        Expanded(child: SizedBox(), flex: 2),
        Expanded(
          flex: 90,
          child: FutureBuilder(
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
              }),
        ),
      ],
    );
  }
}

class StartupCard extends StatelessWidget {
  final VenturePortfolioModel venturePortfolioModel;

  StartupCard({this.venturePortfolioModel});
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 8.0, top: 4, bottom: 4),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VenturePortfolioPage(
                            venturePortfolioModel: venturePortfolioModel,
                          )));
            },
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Container(
                      height: 100,
                      width: 138,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 95,
                            width: 125,
                            decoration: venturePortfolioModel != null
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            venturePortfolioModel.mainImage)))
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[300]),
                          ),
                          Positioned(
                            top: 55,
                            left: 90,
                            child: Container(
                              height: 47.5,
                              width: 47.5,
                              decoration: venturePortfolioModel != null
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.white, width: 3),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              venturePortfolioModel.logoImage)))
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 105,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5),
                          Expanded(
                              flex: 1,
                              child: venturePortfolioModel != null
                                  ? Text(
                                      venturePortfolioModel.ventureName,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.headline6,
                                    )
                                  : Container(
                                      height: 0,
                                      width: 0,
                                    )),
                          SizedBox(height: 5),
                          Expanded(
                              flex: venturePortfolioModel != null ? 2 : 5,
                              child: venturePortfolioModel != null
                                  ? Text(
                                      venturePortfolioModel.tagLine,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.bodyText1.copyWith(
                                          color: Colors.grey[800],
                                          fontSize: 13),
                                    )
                                  : Column(
                                      children: <Widget>[
                                        Text(
                                            '                                         ',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                backgroundColor:
                                                    Colors.grey[200])),
                                        SizedBox(height: 6),
                                        Text(
                                            '                                         ',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                backgroundColor:
                                                    Colors.grey[200])),
                                      ],
                                    )),
                          Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            flex: 2,
                                            child: venturePortfolioModel != null
                                                ? Text(
                                                    venturePortfolioModel
                                                        .industry[1],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: textTheme.bodyText1
                                                        .copyWith(fontSize: 13))
                                                : Text(
                                                    '           ',
                                                    style: TextStyle(
                                                        backgroundColor:
                                                            Colors.grey[200]),
                                                  ),
                                          ),
                                          SizedBox(width: 4),
                                          venturePortfolioModel != null
                                              ? Flexible(
                                                  child: Icon(
                                                      Icons.local_hospital,
                                                      size: 15,
                                                      color: Colors.red),
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
                                                : Container(
                                                    height: 0, width: 0),
                                          ),
                                          SizedBox(width: 3),
                                          Expanded(
                                            flex: 3,
                                            child: venturePortfolioModel != null
                                                ? Text(
                                                    venturePortfolioModel
                                                        .location,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Colors.grey[600]))
                                                : Container(
                                                    height: 0, width: 0),
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
          ),
        ),
        // Divider(color: Colors.grey[400])
      ],
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
      padding: const EdgeInsets.only(left: 12.0, right: 15.0, top: 20),
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
                    childAspectRatio: 0.68,
                    mainAxisSpacing: 5.0,
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
                    childAspectRatio: 0.68,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 12.0,
                    crossAxisCount: 2,
                  ));
          }),
    );
  }
}

class SMECard extends StatelessWidget {
  final VenturePortfolioModel venturePortfolioModel;
  SMECard({this.venturePortfolioModel});
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      // decoration: BoxDecoration(
      //     border: Border(bottom: BorderSide(color: Colors.grey[300]))),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VenturePortfolioPage(
                    venturePortfolioModel: venturePortfolioModel),
              ));
        },
        child: Column(
          children: <Widget>[
            Container(
              height: 105,
              width: 155,
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                    child: Container(
                      height: 100,
                      decoration: venturePortfolioModel != null
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      venturePortfolioModel.mainImage)))
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[300]),
                    ),
                  ),
                  // Positioned(
                  //   top: 70,
                  //   left: -6,
                  //   child: Container(
                  //     height: 47.5,
                  //     width: 47.5,
                  //     decoration: venturePortfolioModel != null
                  //         ? BoxDecoration(
                  //             borderRadius: BorderRadius.circular(15),
                  //             border: Border.all(color: Colors.white, width: 3),
                  //             image: DecorationImage(
                  //                 fit: BoxFit.cover,
                  //                 image: NetworkImage(
                  //                     venturePortfolioModel.logoImage)))
                  //         : null,
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15),
                  venturePortfolioModel != null
                      ? Text(
                          venturePortfolioModel.ventureName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: textTheme.headline6,
                        )
                      : Text(
                          '                          ',
                          style: TextStyle(backgroundColor: Colors.grey[200]),
                        ),
                  SizedBox(height: 8),
                  venturePortfolioModel != null
                      ? Text(
                          venturePortfolioModel.tagLine,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyText1
                              .copyWith(color: Colors.grey[800], fontSize: 13),
                        )
                      : Text('                                    ',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(backgroundColor: Colors.grey[200])),
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
                                        style: textTheme.bodyText1
                                            .copyWith(fontSize: 13))
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
                                            fontSize: 13))
                                    : Container(height: 0, width: 0),
                              ),
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
/* NOTE: Might need later, don't delete
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
} */
