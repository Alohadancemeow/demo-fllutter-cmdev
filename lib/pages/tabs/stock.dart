import 'package:demo_fllutter_cmdev/models/productItem.dart';
import 'package:flutter/material.dart';

class Stock extends StatelessWidget {
  final spacing = 4.0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(
        left: spacing,
        right: spacing,
        top: spacing,
        bottom: 100,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemBuilder: (context, index) => LayoutBuilder(
        builder: (context, constraints) {
          return ProductItem(constraints.maxHeight);
        },
      ),
      itemCount: 5,
    );
  }
}
