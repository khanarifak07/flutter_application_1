import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilities/utilities.dart';
import 'package:flutter_application_1/model/product_model.dart';

class CartProvider extends ChangeNotifier {
  //The current implementation of HomeProvider will fetch the cart items data as soon as an instance of CartProvider is created.
  // CartProvider() {
  //   _initialize();
  // }

  // // //
  // void _initialize() {
  //   getCartItems();
  // }

  //
  List<ProductModel>? products;
  //
  Future<void> getCartItems() async {
    products = await Utilities.getCartProducts();
    notifyListeners();
  }

  //
  Future<void> updateQuantity(ProductModel product, int change) async {
    product.quantity += change;
    notifyListeners();
    if (product.quantity < 1) {
      products?.remove(product);
    }
    notifyListeners();
    await Utilities.saveToCart(products!);
  }

  //
  Future<void> removeFromCart(int index) async {
    products!.removeAt(index);
    await Utilities.saveToCart(products!);
    notifyListeners();
  }

  //
  double getTotalPrice() {
    double totalPrice = 0.0;
    if (products != null) {
      for (var product in products!) {
        totalPrice += product.price * product.quantity;
      }
    }
    return totalPrice;
  }

  // Function to get the total price of all products in the cart
  // double getTotalPrice() {
  //   return products!.fold(0.0, (sum, product) => sum + product.price * product.quantity);
  // }
}
