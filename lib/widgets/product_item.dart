import 'package:flutter/material.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/screens/product_detail.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => ProductDetailScreen()));
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: Colors.purple,
              ),
              onPressed: () {
                product.toggleFavouriteStatus();
              },
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.purple,
            ),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                elevation: 2,
                backgroundColor: Colors.blueAccent,
                content: Text("Item added to cart"),
                action: SnackBarAction(
                  label: 'UNDO',
                  textColor: Colors.white,
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
