// controller.dart
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductController extends ChangeNotifier {
  static List<ProductElement> products = [];

  setProductItems(List<ProductElement> inComingProduct) {
    products = inComingProduct;
    notifyListeners();
  }

  List<ProductElement> getProductItems() {
    return products;
  }

  List<ProductElement> get getProducts => products;

  // void removeProduct(int index) {
  //   products.removeAt(index);
  //   notifyListeners();
  // }

  // void shuffle(ProductElement item) {
  //   Future.delayed(const Duration(milliseconds: 310), () {
  //     if (item.isFavourite == false) {
  //       products.insert(0, item);
  //     } else {
  //       products.insert(products.length, item);
  //     }
  //     notifyListeners();
  //   });
  // }
}
