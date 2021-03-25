import 'package:demo_fllutter_cmdev/config/route.dart' as myRoute;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// # This class is for require.
class DrawerMenu {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Function(BuildContext context) onTap;

  const DrawerMenu(
    this.title, {
    this.icon,
    this.iconColor,
    this.onTap,
  });
}

// # This class is for building required models.
class MenuViewModel {
  List<DrawerMenu> get items => <DrawerMenu>[
        // menu 1
        DrawerMenu(
          'Profile',
          icon: FontAwesomeIcons.user,
          iconColor: Colors.blue,
          onTap: (context) {
            // todo
          },
        ),
        // menu 2
        DrawerMenu(
          'Dashboard',
          icon: FontAwesomeIcons.chartPie,
          iconColor: Colors.green,
          onTap: (context) {
            Navigator.pushNamed(context, myRoute.Route.dashboard);
          },
        ),
        // menu 3
        DrawerMenu(
          'Inbox',
          icon: FontAwesomeIcons.inbox,
          iconColor: Colors.amber,
          onTap: (context) {
            // todo
          },
        ),
        // menu 4
        DrawerMenu(
          'Setting',
          icon: FontAwesomeIcons.cogs,
          iconColor: Colors.blueGrey,
          onTap: (context) {
            // todo
          },
        ),
      ];
}
