import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping/models/order_model.dart';
import 'package:intl/intl.dart';

class OneOrderItem extends StatefulWidget {
  final OrderItem order;

  const OneOrderItem({Key key, this.order}) : super(key: key);

  @override
  _OneOrderItemState createState() => _OneOrderItemState();
}

class _OneOrderItemState extends State<OneOrderItem> {
  var _showMore = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle:
                Text(DateFormat('dd/MM/yyyy').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_showMore ? Icons.expand_more : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _showMore = !_showMore;
                });
              },
            ),
          ),
          if (_showMore)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: min(widget.order.products.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.order.products
                    .map((prod) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prod.title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${prod.quantity}x \$${prod.price}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            )
                          ],
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
