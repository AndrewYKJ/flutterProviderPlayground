// controller.dart

// ignore_for_file: file_names

import 'package:demo_shopping_riverpod/models/cart_model.dart';
import 'package:demo_shopping_riverpod/models/product_model.dart';
import 'package:flutter/material.dart';

import '../models/voucher_model.dart';

class CartController extends ChangeNotifier {
  List<CartItem> cartItems = [];
  List<Voucher> selectedVoucher = [];
  double deliveryfee = 0;
  List<CartItem> get getCartItems => cartItems;

  int get numberOfCart => cartItems.length;

  RichText getPrice(CartItem item) {
    var price = item.product.price! * item.quantity;
    double? discountPrice;
    var discount;
    if (selectedVoucher.isNotEmpty) {
      if (selectedVoucher
          .any((element) => element.applicableGenre == item.product.brand)) {
        discount = selectedVoucher
            .firstWhere(
                (element) => element.applicableGenre == item.product.brand)
            .discount;
      }

      discountPrice = discount != null
          ? (item.product.price!.toDouble() * (1 - discount)) * item.quantity
          : null;

      return discountPrice != null
          ? RichText(
              text: TextSpan(children: [
              TextSpan(
                  text: "\$$price",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      decoration: TextDecoration.lineThrough)),
              TextSpan(
                  text: " \$${(discountPrice.toStringAsFixed(2))}",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
            ]))
          : RichText(
              text: TextSpan(children: [
              TextSpan(
                  text: "\$$price",
                  style: const TextStyle(fontSize: 14, color: Colors.black)),
            ]));
    }

    return RichText(
        text: TextSpan(children: [
      TextSpan(text: "\$$price", style: TextStyle(color: Colors.black)),
    ]));
  }

  void addProduct(ProductElement product) {
    final updatedCart = [...cartItems];
    final index =
        updatedCart.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      updatedCart[index] = updatedCart[index].copyWith(
          quantity: updatedCart[index].quantity + 1,
          product: updatedCart[index].product);
    } else {
      updatedCart.add(CartItem(product: product, quantity: 1));
    }
    cartItems = updatedCart;
    notifyListeners();
  }

  void removeProduct(ProductElement product) {
    final updatedCart = [...cartItems];
    final index =
        updatedCart.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      if (updatedCart[index].quantity > 1) {
        updatedCart[index] = updatedCart[index].copyWith(
            quantity: updatedCart[index].quantity - 1,
            product: updatedCart[index].product);
      } else {
        updatedCart.removeAt(index);
      }
      cartItems = updatedCart;
    }
    notifyListeners();
  }

  // void selectVoucher(Voucher? voucher) {
  //   state = state.copyWith(selectedVoucher: voucher);
  // }

  void applyVoucher(Voucher voucher) {
    //  selectedVoucher = voucher;
    selectedVoucher.any((element) => element.id == voucher.id)
        ? selectedVoucher.removeWhere(
            (element) => element.id == voucher.id,
          )
        : selectedVoucher.add(voucher);
    notifyListeners();
  }

  // void addToCart(ProductElement product) {
  //   for (var cartItem in cartItems) {
  //     if (cartItem.product.id == product.id) {
  //       cartItem.quantity++;
  //       // notifyListeners();
  //       return;
  //     }
  //   }

  //   cartItems.add(CartItem(product: product, quantity: 1));
  //   // notifyListeners();
  // }

  void increaseQuantity(CartItem cartItem) {
    cartItem.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(CartItem cartItem) {
    if (cartItem.quantity == 1) {
      cartItems
          .removeWhere((element) => element.product.id == cartItem.product.id);
    }
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    }
    notifyListeners();
  }

  double calculateTotalAmount() {
    double total = 0;

    if (selectedVoucher.isNotEmpty) {
      final totalAmount = cartItems.fold(0.0, (total, cartItem) {
        dynamic discount;
        if (selectedVoucher.any(
            (element) => element.applicableGenre == cartItem.product.brand)) {
          discount = selectedVoucher
              .firstWhere((element) =>
                  element.applicableGenre == cartItem.product.brand)
              .discount;
        }
        return total +
            (discount != null
                    ? (cartItem.product.price!.toDouble() * (1 - discount))
                    : cartItem.product.price!) *
                cartItem.quantity;
      });
      deliveryfee = totalAmount * 0.1;
      return totalAmount;
    } else {
      for (var cartItem in cartItems) {
        total += cartItem.product.price! * cartItem.quantity;
      }
      deliveryfee = total * 0.1;
      return total;
    }
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }
}
