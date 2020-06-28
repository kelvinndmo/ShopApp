import 'package:flutter/material.dart';
import 'package:shopping/models/product_model.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://images.unsplash.com/photo-1522338140262-f46f5913618a?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1503236823255-94609f598e71?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjY1MDE0fQ&auto=format&fit=crop&w=634&q=80',
    ),
    Product(
      id: 'p4',
      title: 'Nail Polish',
      description: 'Nail Polish.',
      price: 49.99,
      imageUrl:
          'https://images.unsplash.com/photo-1522337660859-02fbefca4702?ixlib=rb-1.2.1&auto=format&fit=crop&w=1049&q=80',
    ),
    Product(
      id: 'p5',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://images.unsplash.com/photo-1522338140262-f46f5913618a?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    ),
    Product(
      id: 'p6',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1503236823255-94609f598e71?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
    ),
    Product(
      id: 'p7',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjY1MDE0fQ&auto=format&fit=crop&w=634&q=80',
    ),
    Product(
      id: 'p8',
      title: 'Nail Polish',
      description: 'Nail Polish.',
      price: 49.99,
      imageUrl:
          'https://images.unsplash.com/photo-1522337660859-02fbefca4702?ixlib=rb-1.2.1&auto=format&fit=crop&w=1049&q=80',
    ),
  ];

  var _showFavourites = false;

  List<Product> get items {
    // if (_showFavourites) {
    //   return _items.where((element) => element.isFavourite).toList();
    // }
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  // void showFavouritesOnly() {
  //   _showFavourites = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavourites = false;
  //   notifyListeners();
  // }
}
