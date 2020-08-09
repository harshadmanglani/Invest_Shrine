import 'package:MobileApp/backend/api_provider.dart';
import 'package:MobileApp/screens/entrepreneurs/inv_portfolio_page.dart';
import 'package:MobileApp/screens/investors/ent_portfolio_page.dart';
import 'package:MobileApp/shared/isafe_page.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  TextStyle navDrawerButtonStyle = TextStyle(fontSize: 16);
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3.0,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(user.category == 'INVESTOR'
                      ? user.investorPortfolioModel.displayImage
                      : user.entrepreneurPortfolioModel.displayImage)),
              accountName: Text(
                  user.category == 'INVESTOR'
                      ? '${user.investorPortfolioModel.firstName} ${user.investorPortfolioModel.lastName}'
                      : '${user.entrepreneurPortfolioModel.firstName} ${user.entrepreneurPortfolioModel.lastName}',
                  style: navDrawerButtonStyle.copyWith(
                      color: drawerHeaderTextColor)),
              accountEmail: Text(user.email,
                  style: navDrawerButtonStyle.copyWith(
                      color: drawerHeaderTextColor))),
          ListTile(
            title: Row(
              children: <Widget>[
                Text("Invest Shrine",
                    style: GoogleFonts.workSans(
                        textStyle: TextStyle(fontSize: 23))),
                SizedBox(width: 10),
                // Icon(Icons.account_balance, color: navbarBackgroundColor)
              ],
            ),
            onTap: null,
          ),
          ListTile(
            title: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Text("Portfolio", style: navDrawerButtonStyle)),
                Expanded(
                    flex: 1,
                    child: Icon(Icons.person_outline,
                        size: 28, color: Colors.black)),
              ],
            ),
            onTap: () {
              user.category == 'INVESTOR'
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvestorPortfolioPage(
                              investorPortfolioModel:
                                  user.investorPortfolioModel)))
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EntrepreneurPortfolioPage(
                              entrepreneurPortfolioModel:
                                  user.entrepreneurPortfolioModel)));
            },
          ),
          ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ISAFEPage()));
              },
              title: Row(
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: Text("iSAFE", style: navDrawerButtonStyle)),
                  Expanded(
                      flex: 1,
                      child: Icon(Icons.help_outline, color: Colors.black)),
                ],
              )),
          ListTile(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await Future.delayed(Duration(milliseconds: 50));
                setState(() {
                  isLoading = false;
                });

                Navigator.pushNamedAndRemoveUntil(
                    context, '/split_route', (route) => false);
                await Future.delayed(Duration(milliseconds: 20));
                user.logout();
              },
              title: isLoading
                  ? Center(
                      child: SpinKitThreeBounce(
                          color: navbarBackgroundColor, size: 20),
                    )
                  : Row(
                      children: <Widget>[
                        Expanded(
                            flex: 4,
                            child: Text(
                              "Logout",
                              style: navDrawerButtonStyle,
                            )),
                        Expanded(
                            flex: 1,
                            child: Icon(Icons.exit_to_app,
                                color: Colors.black //Colors.grey,
                                )),
                      ],
                    )),
        ],
      ),
    );
  }
}
