import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter_application_1/service/api_service.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
  //The current implementation of HomeProvider will fetch the product data as soon as an instance of HomeProvider is created.
  HomeProvider() {
    _initialize();
  }

  void _initialize() {
    getAllProducts();
  }

  bool isLoading = false;
  List<ProductModel>? products;
  // int index = 0;

  // Future<List<Product>?> getAllProductsMethod() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });

  //     //create dio instance
  //     Dio dio = Dio();
  //     //make dio get request
  //     Response response = await dio.get(APIService.getAllProducts.url);
  //     if (response.statusCode == 200) {
  //       List<dynamic> list = response.data['products'];
  //       List<Product> productsData = list.map((e)=> Product.fromJson(e)).toList();

  //       setState(() {
  //         productsData = products!;
  //       });

  //       return productsData;
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return null;
  // }

  //Get All Products
  Future<List<ProductModel>?> getAllProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      var response = await http.get(Uri.parse(APIService.getAllProducts.url));

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        List<dynamic> list = responseData['products'];
        List<ProductModel> products =
            list.map((e) => ProductModel.fromJson(e)).toList();
        log(list.toString());

        this.products = products;
        notifyListeners();

        return products;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
