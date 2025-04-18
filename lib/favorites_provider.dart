import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Product> _favoriteProducts = [];

  List<Product> get favoriteProducts => _favoriteProducts;

  bool isFavorite(Product product) {
    return _favoriteProducts.contains(product);
  }

  void addFavorite(Product product) {
    _favoriteProducts.add(product);
    notifyListeners();
  }

  void removeFavorite(Product product) {
    _favoriteProducts.remove(product);
    notifyListeners();
  }
}