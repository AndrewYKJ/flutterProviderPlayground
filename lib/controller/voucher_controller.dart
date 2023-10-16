import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../models/voucher_model.dart';

final cartController2Provider =
    StateNotifierProvider<CartController2, CartState>(
  (ref) => CartController2(),
);

class CartController2 extends StateNotifier<CartState> {
  List<Voucher> vouchers = [
    Voucher(
      id: '1',
      title: 'Free Shipping',
      description: 'Get free shipping on your order!',
      discount: 1.0, // 100% discount, so it makes shipping free
      applicableGenre: 'All', // Applicable to all product genres
    ),
    Voucher(
      id: '2',
      title: '10% Discount on Apple',
      description: 'Save 10% on all Apple products.',
      discount: 0.1, // 10% discount
      applicableGenre:
          'Apple', // Applicable to products with genre 'Electronics'
    ),
    Voucher(
      id: '3',
      title: '5% Discount on Samsung',
      description: 'Enjoy 5% off on Samsung products.',
      discount: 0.05, // 5% discount
      applicableGenre:
          'Samsung', // Applicable to products with genre 'Clothing'
    ),
    Voucher(
      id: '4',
      title: 'No Discount Voucher',
      description: "This voucher doesn't provide any discounts.",
      discount: 0.0, // No discount
      applicableGenre: 'All', // Applicable to all product genres
    ),
  ];

  CartController2() : super(CartState(cartItems: []));

  void addProduct(ProductElement product) {
    final updatedCart = [...state.cartItems!];
    final index =
        updatedCart.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      updatedCart[index] = updatedCart[index].copyWith(
          quantity: updatedCart[index].quantity + 1,
          product: updatedCart[index].product);
    } else {
      updatedCart.add(CartItem(product: product, quantity: 1));
    }
    state = state.copyWith(cartItems: updatedCart);
  }

  List<CartItem> get getCartItems => state.cartItems ?? [];

  int get numberOfCart => state.cartItems != null ? state.cartItems!.length : 0;

  int getProductQuantity(int index) {
    return state.cartItems![index].quantity;
  }

  void increaseQuantity(CartItem cartItem) {
    final updatedCart = [...state.cartItems!];
    final index = updatedCart
        .indexWhere((item) => item.product.id == cartItem.product.id);

    if (index >= 0) {
      updatedCart[index] = CartItem(
          quantity: updatedCart[index].quantity + 1,
          product: updatedCart[index].product);
    } else {
      updatedCart.add(CartItem(product: cartItem.product, quantity: 1));
    }

    print(updatedCart[index].quantity);
    state.cartItems = updatedCart;
  }

  void decreaseQuantity(CartItem cartItem) {
    // Decrease the quantity of a cart item
    // ...
    //notifyListeners();
  }

  double calculateTotalAmount() {
    // Calculate the total amount of the items in the cart
    double total = 0;
    for (var cartItem in state.cartItems ?? []) {
      total += cartItem.product.price! * cartItem.quantity;
    }
    return total;
  }

  void applyVoucher(Voucher voucher) {
    // Apply a voucher to the cart
    // ...
    //notifyListeners();
  }

  void removeVoucher() {
    // Remove a voucher from the cart
    // ...
    // notifyListeners();
  }
}

class CartState {
  List<CartItem>? cartItems;
  double? totalAmount;
  Voucher? appliedVoucher;

  CartState({
    this.cartItems,
    this.totalAmount,
    this.appliedVoucher,
  });

  CartState copyWith({
    List<CartItem>? cartItems,
    double? totalAmount,
    Voucher? appliedVoucher,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      totalAmount: totalAmount ?? this.totalAmount,
      appliedVoucher: appliedVoucher ?? this.appliedVoucher,
    );
  }
}
