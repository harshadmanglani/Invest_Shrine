// import 'package:MobileApp/screens/investors/entr_portfolio_page.dart';
// import 'package:MobileApp/screens/investors/ven_portfolio_card.dart';
import 'package:MobileApp/screens/investors/ven_portfolio_page.dart';
import 'package:flutter/material.dart';
import 'theme/app.dart';
import 'screens/login.dart';
import 'screens/investors/investor_home.dart';
import 'screens/investors/ven_portfolio_list.dart';
import 'screens/investors/ent_portfolio_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kAppTheme,
      routes: {
        '/login': (BuildContext context) => LoginPage(),
        '/investor_home': (BuildContext context) => InvestorHome(),
        '/venture_portfolio_list': (BuildContext context) =>
            VenturePortfolioList(),
        '/venture_portfolio_page': (BuildContext context) =>
            VenturePortfolioPage(),
        '/entrepreneur_portfolio_page': (BuildContext context) =>
            EntrepreneurPortfolioPage(),
      },
      initialRoute: '/investor_home',
    );
  }
}

// DONT'REMOVE THIS CODE, MIGHT NEED IT LATER

// import 'package:flutter/material.dart';

// void main() async {
//   runApp(new TestApp());
// }

// class TestApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       theme: new ThemeData(primarySwatch: Colors.yellow),
//       home: new TestAppHomePage(),
//     );
//   }
// }

// class TestAppHomePage extends StatefulWidget {
//   @override
//   State createState() => new TestAppHomePageState();
//   //FPDetailScreen({Key key, @required this.period}) : super(key: key);
// }

// class TestAppHomePageState extends State<TestAppHomePage>
//     with SingleTickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: DefaultTabController(
//         length: 3,
//         child: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverAppBar(
//                 expandedHeight: 120.0,
//                 floating: false,
//                 forceElevated: innerBoxIsScrolled,
//                 backgroundColor: Colors.green,
//                 pinned: true,
//                 flexibleSpace: FlexibleSpaceBar(
//                   collapseMode: CollapseMode.pin,
//                   centerTitle: true,
//                   title: Text(
//                     "Foo Bar Baz",
//                     style: TextStyle(color: Colors.white),
//                     textAlign: TextAlign.left,
//                     overflow: TextOverflow.ellipsis,
//                     softWrap: true,
//                     maxLines: 1,
//                   ),
//                   background: Container(
//                     alignment: Alignment.topCenter,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Row(
//                           children: <Widget>[
//                             Text(
//                               '10.00 TL',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                           mainAxisAlignment: MainAxisAlignment.center,
//                         ),
//                         Container(
//                           width: 0,
//                           height: 0,
//                         )
//                       ],
//                     ),
//                   ),
//                   //background: ,
//                 ),
//               ),
//               SliverPersistentHeader(
//                 pinned: true,
//                 delegate: _SliverAppBarDelegate(
//                   TabBar(
//                     tabs: [
//                       Tab(
//                         child: Text(
//                           "Tab1",
//                           style: TextStyle(
//                               color: Colors.black, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Tab(
//                         child: Text(
//                           "Tab2",
//                           style: TextStyle(
//                               color: Colors.black, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ];
//           },
//           body: TabBarView(
//               //controller: _tabController,
//               children: [
//                 CardList('one'),
//                 CardList('two'),
//               ]),
//         ),
//       ),
//     );
//   }
// }

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate(this._tabBar);

//   final TabBar _tabBar;

//   @override
//   double get minExtent => _tabBar.preferredSize.height;
//   @override
//   double get maxExtent => _tabBar.preferredSize.height;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return new Container(
//       color: Colors.white,
//       child: _tabBar,
//     );
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }

// class CardList extends StatelessWidget {
//   final String listKey;

//   CardList(this.listKey);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListView.builder(
//           key: PageStorageKey<String>(listKey),
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           itemCount: 20,
//           //itemExtent: 1.0,
//           itemBuilder: (context, index) {
//             return new ListTile(
//               title: new Text("Item $index"),
//             );
//           }),
//     );
//   }
// }
