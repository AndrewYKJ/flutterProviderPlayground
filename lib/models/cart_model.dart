// cart.dart

import 'package:demo_shopping_riverpod/models/product_model.dart';

class CartItem {
  final ProductElement product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  CartItem copyWith({required int quantity, required ProductElement product}) {
    return CartItem(product: this.product, quantity: this.quantity);
  }
}
