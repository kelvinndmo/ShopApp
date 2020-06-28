import 'package:flutter/material.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/providers/products_provider.dart';
import 'package:shopping/widgets/product_item.dart';
import "package:provider/provider.dart";

class ProductGrid extends StatelessWidget {
  final bool showFabs;

  const ProductGrid({
    Key key,
    this.showFabs = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFabs ? productsData.favouriteItems : productsData.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          value: products[index],
          //rigght approach, the provuder works even if data changes for the widget
          // create: (ctx) => products[index]
          child: ProductItem()),
      padding: EdgeInsets.all(10.0),
      itemCount: products.length,
    );
  }
}
