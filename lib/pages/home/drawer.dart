import 'package:badges/badges.dart';
import 'package:demo_fllutter_cmdev/config/route.dart' as myRoute;
import 'package:demo_fllutter_cmdev/models/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfile(),
          ..._buildMainMenu(),
          Spacer(),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.grey,
            ),
            title: Text("logout"),
            onTap: showDialogLogOut,
          ),
        ],
      ),
    );
  }

  void showDialogLogOut() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('title'),
          content: Text('content'),
          actions: [
            TextButton(
              child: Text('buttonText'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(myRoute.Route.login);
              },
            ),
          ],
        );
      },
    );
  }

  // # This method is for build drawer header.
  _buildProfile() {
    return UserAccountsDrawerHeader(
      accountName: Text('text header'),
      accountEmail: Text('email@gmail.com'),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://cdn-images-1.medium.com/max/140/1*X5PBTDQQ2Csztg3a6wofIQ@2x.png'),
      ),
    );
  }

  // # This method id for building drawer's menu.
  _buildMainMenu() {
    return MenuViewModel()
        .items
        // map = getting model's data,
        // to create listtiles.
        .map(
          (item) => ListTile(
            title: Text(
              item.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            leading: Badge(
              // show badge inbox only.
              showBadge: item.icon == FontAwesomeIcons.inbox,
              badgeColor: Colors.red,
              badgeContent: Text(
                '99',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              child: FaIcon(
                item.icon,
                color: item.iconColor,
                size: 20.0,
              ),
            ),
            onTap: () {
              item.onTap(context);
            },
          ),
        )
        .toList();
  }
}
