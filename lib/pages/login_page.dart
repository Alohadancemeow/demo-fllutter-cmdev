import 'package:demo_fllutter_cmdev/config/theme.dart' as customTheme;
import 'package:demo_fllutter_cmdev/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  // # Fixed color.
  final _color = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              // use gradient color
              gradient: customTheme.ThemeBG.gradient,
            ),
          ),
          Column(
            children: [
              Header(),
              loginForm(),
            ],
          ),
        ],
      ),
    );
  }

  // # Build login form.
  Stack loginForm() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        buildCardForm(),
        submitButton(),
      ],
    );
  }

  // # This method is for building card form.
  Card buildCardForm() {
    // # Functional variable.
    // # For setting the form textstyles and then return it.
    final TextStyle Function() _textStyle = () {
      return TextStyle(fontWeight: FontWeight.w500, color: _color);
    };

    return Card(
      margin: EdgeInsets.only(bottom: 22, left: 22, right: 22),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 58,
          left: 28,
          right: 28,
        ),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Email',
                hintText: 'Enter your email',
                icon: FaIcon(
                  FontAwesomeIcons.envelope,
                  size: 22.0,
                  color: _color,
                ),
                labelStyle: _textStyle(),
              ),
            ),
            // # Add Dividing line
            Divider(
              height: 22,
              thickness: 1,
              indent: 13,
              endIndent: 13,
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Password',
                icon: FaIcon(
                  FontAwesomeIcons.lock,
                  size: 22.0,
                  color: _color,
                ),
                labelStyle: _textStyle(),
              ),
              obscureText: true, //hide text
            ),
          ],
        ),
      ),
    );
  }

  // # This method is for submitting data.
  Container submitButton() {
    return Container(
      width: 220,
      height: 50,
      decoration: _boxDecoration(),
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  // # This method is for decoratting button.
  BoxDecoration _boxDecoration() {
    // # Create variables for getting colors from themeBG.
    final gradientStart = customTheme.ThemeBG.gradientStart;
    final gradientEnd = customTheme.ThemeBG.gradientEnd;

    // # Functional variable.
    // # For setting shadow color in this scope only.
    final BoxShadow Function(Color color) boxShadowItem = (Color color) {
      // make shadow color
      return BoxShadow(
        color: color,
        offset: Offset(1.0, 6.0),
        blurRadius: 20.0,
      );
    };

    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      boxShadow: [
        // call boxShadowItem
        boxShadowItem(gradientStart),
        boxShadowItem(gradientEnd),
      ],
      // make gradient color from here
      gradient: LinearGradient(
        colors: [
          gradientEnd,
          gradientStart,
        ],
        begin: const FractionalOffset(0, 0),
        end: const FractionalOffset(1.0, 1.0),
        stops: [0.0, 1.0],
      ),
    );
  }
}

// # Extract widget
// # This class is for displaying logo image only.
class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 50, bottom: 38),
      margin: EdgeInsets.all(50),
      child: Image.asset(
        Assets.LOGO_IMAGE,
        height: 80,
      ),
    );
  }
}
