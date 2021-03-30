import 'package:demo_fllutter_cmdev/api/network_service.dart';
import 'package:demo_fllutter_cmdev/api/post_data.dart';
import 'package:demo_fllutter_cmdev/models/productItem.dart';
import 'package:demo_fllutter_cmdev/models/products.dart';
import 'package:flutter/material.dart';

class Stock extends StatefulWidget {
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  final spacing = 4.0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: NetworkService().getAllProduct(),
      builder: (context, snapshot) {
        // has data
        if (snapshot.hasData) {
          List<Product> product = snapshot.data;
          if (product == null || product.isEmpty) {
            return Container(
              margin: EdgeInsets.only(top: 22),
              alignment: Alignment.topCenter,
              child: Text('No data'),
            );
          }
          return RefreshIndicator(
            // work on list only.
            onRefresh: () async {
              setState(() {});
            },
            child: buildProductGridView(product),
          );
        }

        // has error
        if (snapshot.hasError) {
          return Container(
            margin: EdgeInsets.only(top: 22),
            alignment: Alignment.topCenter,
            child: Text(snapshot.error.toString()),
          );
        }

        // loading..
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // # This method is for building products with gridview layout.
  GridView buildProductGridView(List<Product> product) {
    return GridView.builder(
      itemCount: product.length,
      padding: EdgeInsets.only(
        left: spacing,
        right: spacing,
        top: spacing,
        bottom: 50,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemBuilder: (context, index) => LayoutBuilder(
        builder: (context, constraints) {
          return ProductItem(constraints.maxHeight, product[index]);
        },
      ),
    );
  }
}
