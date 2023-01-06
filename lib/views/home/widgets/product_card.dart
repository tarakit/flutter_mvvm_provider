
import 'package:flutter/material.dart';

import '../../../models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Attributes? product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${product?.title}'),
      subtitle: Text('${product?.price}'),
      leading: product?.thumbnail?.data == null ?
          CircularProgressIndicator() :
        Image.network('https://cms.istad.co${product?.thumbnail?.data?.attributes?.url}'),
    );
  }
}