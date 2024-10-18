import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter_application_1/model/profile_model.dart';
import 'package:flutter_application_1/model/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utilities {
  //
  static Future<bool> saveUserDetails(ProfileModel profileModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString('userDetails', json.encode(profileModel));
  }

  //
  static getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString('userDetails')!);
  }

  //
  static saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', token);
  }

  //
  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token != null) {
      return token;
    } else {
      return null;
    }
  }

  //
  static removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('token');
  }

  //
  static navigatePushReplacement(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  //
  static nextScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  //save todos
  static Future<bool> saveTodoToSharedPreference(List<TodoModel> todos) async {
    //convert list of model into list of string
    List<String> todoJsonList =
        todos.map((e) => jsonEncode(e.toJson())).toList();
    //save to sharepred
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('todos', todoJsonList);
  }

  // Get Todos
  static Future<List<TodoModel>> getTodosFromSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoJsonList = prefs.getStringList('todos');
    //Convert list of string into todo model class
    List<TodoModel> todo = todoJsonList != null
        ? todoJsonList.map((e) => TodoModel.fromJson(jsonDecode(e))).toList()
        : [];

    return todo;
  }

  //remove todo
  static Future<void> removeAllTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('todos');
  }

  //save to cart
  static Future<bool> saveToCart(List<ProductModel> products) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //convert list of product model into list of string
    List<String> productStrings =
        products.map((product) => jsonEncode(product.toJson())).toList();
    //save to sharedPref
    return prefs.setStringList('cartProducts', productStrings);
  }

  //add to cart
  static Future<bool> addToCart(ProductModel product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the existing cart products
    List<String>? existingProducts = prefs.getStringList('cartProducts');
    List<ProductModel> productsList = [];

    // If there are existing products, decode them into ProductModel objects
    if (existingProducts != null) {
      productsList = existingProducts
          .map((e) => ProductModel.fromJson(jsonDecode(e)))
          .toList();
    }

    // Check if the product already exists in the cart
    int index = productsList.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      // Product already in cart, so increase the quantity
      productsList[index].quantity += 1;
    } else {
      // New product, add it to the cart
      productsList.add(product);
    }

    // Save the updated list back to SharedPreferences
    List<String> updatedProducts =
        productsList.map((e) => jsonEncode(e.toJson())).toList();
    return prefs.setStringList('cartProducts', updatedProducts);
  }

  //get cart products
  static Future<List<ProductModel>> getCartProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonString = prefs.getStringList('cartProducts');
    //convert list of string into list of model
    List<ProductModel> products = jsonString != null
        ? jsonString.map((e) => ProductModel.fromJson(jsonDecode(e))).toList()
        : [];

    return products;
  }

  static DateFormat dateFormat = DateFormat('yyyy-MM-dd');
}
