import 'package:demo_fllutter_cmdev/models/tabbar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTabs extends StatelessWidget implements PreferredSizeWidget {
  final List<TabMenu> tabsMenu;
  const CustomTabs(this.tabsMenu);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabsMenu
          .map(
            (item) => Tab(
              child: Row(
                children: [
                  FaIcon(item.icon, size: 18),
                  SizedBox(width: 12),
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
