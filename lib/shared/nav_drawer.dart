import 'package:MobileApp/backend/api_provider.dart';
import 'package:MobileApp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  TextStyle navDrawerButtonStyle = TextStyle(fontSize: 16);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3.0,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(user.category == 'INVESTOR'
                      ? user.investorModel.displayImage
                      : user.entrepreneurModel.displayImage)),
              accountName: Text(
                  user.category == 'INVESTOR'
                      ? '${user.investorModel.firstName} ${user.investorModel.lastName}'
                      : '${user.entrepreneurModel.firstName} ${user.entrepreneurModel.lastName}',
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
                Icon(Icons.account_balance, color: navbarBackgroundColor)
              ],
            ),
            onTap: null,
          ),
          ListTile(
              title: Row(
            children: <Widget>[
              Expanded(
                  flex: 4, child: Text("Help", style: navDrawerButtonStyle)),
              Expanded(
                  flex: 1,
                  child:
                      Icon(Icons.help_outline, color: navbarBackgroundColor)),
            ],
          )),
          ListTile(
              onTap: () {
                user.logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/split_route', (route) => false);
              },
              title: Row(
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
                          color: navbarBackgroundColor //Colors.grey,
                          )),
                ],
              )),
        ],
      ),
    );
  }
}
