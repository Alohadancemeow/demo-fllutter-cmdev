import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// # This class is for building modles.
class SingleSignOnModel {
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onPress;

  SingleSignOnModel({
    this.icon,
    this.backgroundColor,
    this.onPress,
  });
}

// # This class is for getting models's values,
// # Then return them.
class SingleSignOnViewModel {
  // GET : Functional variable.
  List<SingleSignOnModel> get items => <SingleSignOnModel>[
        SingleSignOnModel(
          icon: FontAwesomeIcons.apple,
          backgroundColor: Colors.black,
          onPress: () {},
        ),
        SingleSignOnModel(
          icon: FontAwesomeIcons.google,
          backgroundColor: Colors.red,
          onPress: () {},
        ),
        SingleSignOnModel(
          icon: FontAwesomeIcons.facebookF,
          backgroundColor: Colors.blue,
          onPress: () {},
        ),
        SingleSignOnModel(
          icon: FontAwesomeIcons.line,
          backgroundColor: Colors.green,
          onPress: () {},
        )
      ];
}
