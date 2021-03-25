import 'package:demo_fllutter_cmdev/pages/tabs/chart.dart';
import 'package:demo_fllutter_cmdev/pages/tabs/report.dart';
import 'package:demo_fllutter_cmdev/pages/tabs/stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabMenu {
  final String title;
  final IconData icon;
  final Widget widget;

  const TabMenu(
    this.title,
    this.widget, {
    this.icon,
  });
}

class TabMenuViewModel {
  List<TabMenu> get items => <TabMenu>[
        TabMenu(
          "Stock",
          Stock(),
          icon: FontAwesomeIcons.box,
          
        ),
        TabMenu(
          "Chart",
          Chart(),
          icon: FontAwesomeIcons.chartArea,
        ),
        TabMenu(
          "Report",
          Report(),
          icon: FontAwesomeIcons.fileAlt,
        ),
      ];
}
