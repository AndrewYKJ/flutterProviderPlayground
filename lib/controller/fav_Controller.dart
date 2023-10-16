// controller.dart

// ignore_for_file: file_names

import 'package:demo_shopping_riverpod/controller/product_controller.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class FavouriteController extends ChangeNotifier {
  List<ProductElement> getFavoriteProducts() {
    return ProductController.products
        .where((product) => product.isFavourite!)
        .toList();
  }

  int numberOfFavorites() {
    return ProductController.products
        .where((product) => product.isFavourite!)
        .length;
  }

  void toggleFavorite(ProductElement product) {
    product.isFavourite = !product.isFavourite!;

    notifyListeners();
  }

  void removeFromFavorites(ProductElement product) {
    product.isFavourite = false;
    notifyListeners();
  }
}
