import 'package:flutter/material.dart';
import 'package:shopping/models/exceptions.dart';
import 'package:shopping/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [];

  var _showFavourites = false;
  final String token;
  final String userId;

  Products(this.token, this._items, this.userId);

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

  Future<void> fetchProducts() async {
    try {
      final url =
          'https://milliefashions-d83c0.firebaseio.com/products.json?auth=$token&orderBy="creatorId"&equalTo="$userId"';
      final response = await http.get(url);

      final List<Product> loadProducts = [];

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      var favUrl =
          'https://milliefashions-d83c0.firebaseio.com/userFavourites/$userId.json?auth=$token';
      final favouriteResponse = await http.get(favUrl);
      final favouriteData = json.decode(favouriteResponse.body);

      extractedData.forEach((prodId, prodData) {
        loadProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavourite:
                favouriteData == null ? false : favouriteData[prodId] ?? false,
            imageUrl: prodData['imageUrl']));
      });
      _items = loadProducts;

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProducts(Product product) async {
    final url =
        'https://milliefashions-d83c0.firebaseio.com/products.json?auth=$token';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId
          }));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavourite: product.isFavourite,
        id: json.decode(response.body)['name'],
      );

      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    final url =
        'https://milliefashions-d83c0.firebaseio.com/products/$id.json?auth=$token';

    if (prodIndex >= 0) {
      try {
        await http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
              'price': newProduct.price,
            }));
        _items[prodIndex] = newProduct;

        notifyListeners();
      } catch (e) {}
    } else {
      print("...");
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://milliefashions-d83c0.firebaseio.com/products/$id.json?auth=$token';
    final existingProductIndex = _items.indexWhere((prod) => id == prod.id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException("Could not delete product");
    }
    existingProduct = null;
  }
}
