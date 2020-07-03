import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/providers/products_provider.dart';
import 'package:shopping/screens/edit_product_screen.dart';
import 'package:shopping/widgets/app_drawer.dart';
import 'package:shopping/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = 'userProduct';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, index) => Column(
                  children: [
                    UserProductItem(
                      id: productsData.items[index].id,
                      imageUrl: productsData.items[index].imageUrl,
                      title: productsData.items[index].title,
                    ),
                    Divider()
                  ],
                )),
      ),
    );
  }
}
