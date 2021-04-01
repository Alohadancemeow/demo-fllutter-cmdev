import 'package:demo_fllutter_cmdev/api/network_service.dart';
import 'package:demo_fllutter_cmdev/models/productItem.dart';
import 'package:demo_fllutter_cmdev/models/products.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:demo_fllutter_cmdev/config/route.dart' as myRoute;

class Stock extends StatefulWidget {
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  final spacing = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildNetwork(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('fab');
          // push to new page, then wait it get data back.
          Navigator.pushNamed(context, myRoute.Route.management).then((value) {
            setState(() {});
          });
        },
        child: FaIcon(
          FontAwesomeIcons.plus,
        ),
      ),
    );
  }

  FutureBuilder<List<Product>> buildNetwork() {
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
            // child: Text(snapshot.error.toString()
            child: Text((snapshot.error as DioError).message),
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
  GridView buildProductGridView(List<Product> products) {
    return GridView.builder(
      itemCount: products.length,
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
          final product = products[index];
          return ProductItem(
            constraints.maxHeight,
            product,
            onTap: () {
              // push to management page
              Navigator.pushNamed(
                context,
                myRoute.Route.management,
                arguments: product,
              ).then((value) {
                setState(() {});
              });
            },
          );
        },
      ),
    );
  }
}
