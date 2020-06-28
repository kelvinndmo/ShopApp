import 'package:flutter/foundation.dart';
import 'package:shopping/models/cart_item.dart';
import 'package:shopping/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}