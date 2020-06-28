import 'package:flutter/material.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/providers/products_provider.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/widgets/app_drawer.dart';
import 'package:shopping/widgets/badge.dart';
import 'package:shopping/widgets/product_grid.dart';
import 'package:shopping/widgets/product_item.dart';
import 'package:provider/provider.dart';

enum filterOptions { Favourites, All }

class ProductOviewScreen extends StatefulWidget {
  @override
  _ProductOviewScreenState createState() => _ProductOviewScreenState();
}

class _ProductOviewScreenState extends State<ProductOviewScreen> {
  var _showOnlyFavourites = false;
  @override
  Widget build(BuildContext context) {
    // final products = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Millie Fashions'),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (filterOptions selected) {
              if (selected == filterOptions.Favourites) {
                setState(() {
                  _showOnlyFavourites = true;
                });
              } else {
                setState(() {
                  _showOnlyFavourites = false;
                });
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: filterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: filterOptions.All,
              )
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(
        showFabs: _showOnlyFavourites,
      ),
    );
  }
}
