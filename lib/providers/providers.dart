// final cartController = Provider<CartController>((ref)=> null;);
import 'package:demo_shopping_riverpod/controller/fav_Controller.dart';
import 'package:demo_shopping_riverpod/controller/product_controller.dart';
import 'package:demo_shopping_riverpod/controller/voucher_controller.dart';
import 'package:demo_shopping_riverpod/models/cart_model.dart';
import 'package:demo_shopping_riverpod/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/addToCart_controller.dart';
import '../dio/api/getProduct.dart';

final favController = ChangeNotifierProvider<FavouriteController>((ref) {
  return FavouriteController();
});

final cartController = ChangeNotifierProvider<CartController>(
  (ref) => CartController(),
);

final productApiProvider = Provider<ProductApi>((ref) {
  return ProductApi();
});

final productDataProvider = FutureProvider<Product>((ref) async {
  return ref.watch(productApiProvider).getProduct();
});

final productController = Provider<ProductController>((ref) {
  return ProductController();
});

final cart2 = StateNotifierProvider<CartController2, CartState>((ref) {
  return CartController2();
});
