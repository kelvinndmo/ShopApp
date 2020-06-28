import 'package:flutter/material.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/providers/orders.dart';
import 'package:shopping/providers/products_provider.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/screens/orders_screen.dart';
import 'package:shopping/screens/product_detail.dart';
import 'package:shopping/screens/product_overview.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(create: (ctx) => Orders())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Millie Fashions',
          theme: ThemeData(
            // is not restarted.
            primarySwatch: Colors.blueAccent.shade50,

            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: ProductOviewScreen(),
          routes: {
            ProductDetailScreen.id: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen()
          }),
    );
  }
}
