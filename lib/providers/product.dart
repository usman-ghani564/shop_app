import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() async {
    bool previousIsFavorite = this.isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://shop-app-f9d30-default-rtdb.firebaseio.com/products/$id.json';

    final response = await http.patch(url,
        body: json.encode({
          'title': title,
          'description': description,
          'price': price,
          'imageUrl': imageUrl,
          'isFavorite': isFavorite,
        }));
    if (response.statusCode >= 400) {
      isFavorite = previousIsFavorite;
      notifyListeners();
      throw HttpException('Something wrong happend!');
    }
  }
}
