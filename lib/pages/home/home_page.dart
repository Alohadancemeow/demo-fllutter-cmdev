import 'package:demo_fllutter_cmdev/models/tabbar_view_model.dart';
import 'package:demo_fllutter_cmdev/pages/home/drawer.dart';
import 'package:demo_fllutter_cmdev/pages/tabs/custom_tab.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title = 'Homepage'}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // ! error
    // # Recieve arguments from login page.
    // final Map<Object, Object> arguments =
    //     ModalRoute.of(context).settings.arguments;

    // // # Set arguments to models.
    // final models = Map<String, Object>.from(arguments);

    // // # Get key from models, then set to title.
    // var title = '';
    // // # is : smart cast.
    // if (models['title'] is String) {
    //   // set title key's value to title variable.
    //   title = models['title'];
    // }

    // # Tabs length
    final _tabsMenu = TabMenuViewModel().items;

    return DefaultTabController(
      length: _tabsMenu.length,
      child: Scaffold(
        appBar: buildAppBar(_tabsMenu),
        drawer: CustomDrawer(),
        body: TabBarView(
          // tabbarview = fragments
          children: _tabsMenu
              .map(
                (item) => item.widget,
              )
              .toList(),
        ),
      ),
    );
  }

  // # This method is for setting appbar.
  AppBar buildAppBar(List<TabMenu> _tabsMenu) {
    return AppBar(
      title: Text(widget.title),
      bottom: CustomTabs(_tabsMenu),
      actions: [
        IconButton(
          icon: Icon(Icons.bookmark_border),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.qr_code),
          onPressed: () {},
        )
      ],
    );
  }
}
