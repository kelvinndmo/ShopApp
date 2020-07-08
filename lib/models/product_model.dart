import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shopping/models/exceptions.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavourite = false});

  Future<void> toggleFavouriteStatus(String token, String userId) async {
    print(userId);
    var status = isFavourite;

    final url =
        'https://milliefashions-d83c0.firebaseio.com/userFavourites/$userId/$id.json?auth=$token';
    try {
      isFavourite = !isFavourite;
      notifyListeners();
      final res = await http.put(url, body: json.encode(isFavourite));
      if (res.statusCode >= 400) {
        isFavourite = status;
        notifyListeners();
      }
    } catch (e) {
      isFavourite = status;
      notifyListeners();
      throw HttpException("There was an error favouring");
    }

    notifyListeners();
  }
}
