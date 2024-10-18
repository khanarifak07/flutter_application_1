import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Categories/categories_model.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider extends ChangeNotifier {
  CategoriesProvider() {
    _initialize();
  }

  void _initialize() {
    getCategoryList();
  }

//Map to store the product once loaded
  Map<String, List<CategoriesModel>> categoriesMap = {};

  List<String>? categoryList;
  //Get Categories List
  Future<List<String>?> getCategoryList() async {
    try {
      var response = await http
          .get(Uri.parse('https://dummyjson.com/products/category-list'));
      if (response.statusCode == 200) {
        //1.
        // var responseData = json.decode(response.body) as List;
        // List<String> categories =
        //     responseData.map((e) => e.toString()).toList();
        // categoryList = categories;
        //2.
        var responseData = json.decode(response.body);
        categoryList = List<String>.from(responseData);
        notifyListeners();
        return categoryList;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //Get Product By Categories
  List<CategoriesModel>? categoryProducts;

  Future<List<CategoriesModel>?> getProductByCategory({
    required String categoryName,
  }) async {
    try {
      var response = await http.get(
          Uri.parse('https://dummyjson.com/products/category/$categoryName'));
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        List<dynamic> list = responseData['products'];
        List<CategoriesModel> products =
            list.map((e) => CategoriesModel.fromJson(e)).toList();

        categoryProducts = products;
        categoriesMap[categoryName] = products;
        notifyListeners();

        log(responseData.toString());
        return products;
      }
    } catch (e) {
      log('Error while fetching products by categories $e');
    }
    return null;
  }
}
