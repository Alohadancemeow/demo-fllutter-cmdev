import 'package:demo_fllutter_cmdev/models/floating_icon_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// # This class is for building lines, FAB.
class SingleSignOn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDivider(),
        SizedBox(height: 12),
        _buildSingleSignOnButton(),
      ],
    );
  }

  // # This method is for building 2 dividers.
  Row _buildDivider() {
    // # Gradient colors and lines.
    final gradientColor = const [Colors.white10, Colors.white];
    final line = (List<Color> colors) => Container(
          width: 80.0,
          height: 1.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.1, 1.0],
            ),
          ),
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        line(gradientColor),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'or',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ),
        line(gradientColor.reversed.toList()),
      ],
    );
  }

  // # This method is for using models's data
  // # To build 4 floatingActionButtons.
  Padding _buildSingleSignOnButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: SingleSignOnViewModel()
            .items
            .map(
              (item) => FloatingActionButton(
                heroTag: item.icon.toString(),
                onPressed: item.onPress,
                backgroundColor: item.backgroundColor,
                child: FaIcon(
                  item.icon,
                  color: Colors.white,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
