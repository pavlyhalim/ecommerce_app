import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends InheritedWidget {
  final ValueNotifier<List<Product>> cartItems;

  const CartProvider({
    Key? key,
    required this.cartItems,
    required Widget child,
  }) : super(key: key, child: child);

  static CartProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartProvider>();
  }

  void addItem(Product product, int quantity) {
    int index = cartItems.value.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      // If the item is already in the cart, update the quantity
      cartItems.value[index].quantity = quantity;
      notifyListeners();
    } else {
      // If the item is not in the cart, add it with the specified quantity
      product.quantity = quantity;
      cartItems.value = [...cartItems.value, product];
    }
  }

  void removeItem(Product product) {
    cartItems.value = cartItems.value.where((item) => item != product).toList();
  }

  void incrementQuantity(Product product) {
    int index = cartItems.value.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      cartItems.value[index].quantity++;
      notifyListeners();
    }
  }

  @override
  bool updateShouldNotify(CartProvider oldWidget) {
    return cartItems != oldWidget.cartItems;
  }

  void notifyListeners() {
      cartItems.value = [...cartItems.value];
  }

  
}