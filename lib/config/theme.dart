import 'package:flutter/cupertino.dart';

class ThemeBG {
  // # Every variables in this class
  // # Must be final.
  const ThemeBG();

  // # create gradients BG color
  // #1488CC #2B32B2 #24C6DC #514A9D #00d2ff #3a7bd5
  // #141e30 #243b55 #3C3B3F #605C3C #2193b0 #6dd5ed #e65c00 #F9D423
  static const Color gradientStart = const Color(0xFF1488CC);
  static const Color gradientEnd = const Color(0xFF2B32B2);

  // # set gradients
  static const gradient = const LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 1.0],
  );
}
