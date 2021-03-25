import 'package:demo_fllutter_cmdev/config/route.dart' as myRoute;
import 'package:demo_fllutter_cmdev/constants/setting.dart';
import 'package:demo_fllutter_cmdev/pages/home/home_page.dart';
import 'package:demo_fllutter_cmdev/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //set route here
      routes: myRoute.Route.getRoute(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Demo Flutter : CMDev'),
      home: LoginPage(),

      // ! Not success
      // home: FutureBuilder<SharedPreferences>(
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       final token = snapshot.data.getString(Setting.TOKEN_PREF) ?? "";
      //       if (token.isNotEmpty) {
      //         return MyHomePage();
      //       }
      //       return LoginPage();
      //     }
      //     return MyHomePage();
      //   },
      // ),
    );
  }
}
