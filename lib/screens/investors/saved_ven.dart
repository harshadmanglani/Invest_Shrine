import 'package:MobileApp/backend/entrepreneurs/portfolio_list.dart';
import 'package:MobileApp/models/entrepreneurs/venture_model.dart';
import 'package:MobileApp/screens/investors/inv_home_page.dart';

import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';

class SavedVentures extends StatefulWidget {
  @override
  _SavedVenturesState createState() => _SavedVenturesState();
}

class _SavedVenturesState extends State<SavedVentures>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  var tabHeaderStyle = TextStyle(fontSize: 15);

  @override
  void initState() {
    super.initState();
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
      children: <Widget>[
        SizedBox(height: 5),
        Expanded(flex: 2, child: _getTabBar()),
        Expanded(
          flex: 26,
          child: _getTabBarView(<Widget>[SavedStartups(), SavedSMEs()]),
        ),
      ],
    );
  }
}

class SavedStartups extends StatefulWidget {
  @override
  _SavedStartupsState createState() => _SavedStartupsState();
}

class _SavedStartupsState extends State<SavedStartups> {
  Future venturePortfolioList;
  List<VenturePortfolioModel> cachedVenturePortfolioList;

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
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return StartupCard(
                        savedCard: true,
                        venturePortfolioModel: snapshot.data[index],
                      );
                    },
                  );
                } else
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

class SavedSMEs extends StatefulWidget {
  @override
  _SavedSMEsState createState() => _SavedSMEsState();
}

class _SavedSMEsState extends State<SavedSMEs> {
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
                      savedCard: true,
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
