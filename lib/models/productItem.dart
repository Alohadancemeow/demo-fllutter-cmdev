import 'package:demo_fllutter_cmdev/constants/api.dart';
import 'package:demo_fllutter_cmdev/constants/assets.dart';
import 'package:demo_fllutter_cmdev/constants/format.dart';
import 'package:demo_fllutter_cmdev/constants/image_notfound.dart';
import 'package:demo_fllutter_cmdev/models/products.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final double maxHeight;
  final Product product;
  const ProductItem(this.maxHeight, this.product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('onTap ${product.id}');
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildImage(),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  _buildImage() {
    final height = maxHeight * 0.7;
    final productImage = product.image;
    print(productImage);
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height,
          child: productImage != null && productImage.isNotEmpty
              ? Image.network("${API.IMAGE_URL}/$productImage")
              : ImageNotFound(),
        ),
        if (product.stock <= 0) _buildOutOfStock(),
      ],
    );
  }

  Expanded _buildInfo() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "฿${formatCurrency.format(product.price)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${formatNumber.format(product.stock)} Pieces',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildOutOfStock() {
    return Positioned(
      top: 2,
      right: 2,
      child: Card(
        margin: EdgeInsets.all(0),
        color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: Text(
            'Out of Stock',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
