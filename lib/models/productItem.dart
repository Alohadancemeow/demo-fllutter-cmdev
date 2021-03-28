import 'package:demo_fllutter_cmdev/constants/assets.dart';
import 'package:demo_fllutter_cmdev/constants/format.dart';
import 'package:demo_fllutter_cmdev/constants/image_notfound.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final double maxHeight;
  const ProductItem(this.maxHeight);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('onTap');
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
    final productImage = Assets.LOGO_IMAGE;
    // final productImage = '';
    final stock = 1;
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height,
          child: productImage != null && productImage.isNotEmpty
              ? Image.asset(productImage)
              : ImageNotFound(),
        ),
        if (stock <= 0) _buildOutOfStock(),
      ],
    );
  }

  Expanded _buildInfo() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'etraset sheets containing Lorem Ipsum passages,',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "฿${formatCurrency.format(10000)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${formatNumber.format(1100)} Pieces',
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
