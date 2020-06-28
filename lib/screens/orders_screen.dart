import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/orders.dart';
import 'package:shopping/widgets/app_drawer.dart';
import 'package:shopping/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        body: ListView.builder(
          itemCount: orders.orders.length,
          itemBuilder: (ctx, index) => OneOrderItem(
            order: orders.orders[index],
          ),
        ));
  }
}
