import 'package:flutter_application_1/api_endpoint.dart';

class APIService {
  //base url
  static const String baseURL = 'https://dummyjson.com';
  static const String getAllProductsURL = '$baseURL/products';
  static const String loginURL = 'https://dummyjson.com/auth/login';

  static APIEndPoint getAllProducts = APIEndPoint(
    url: getAllProductsURL,
    method: "GET",
    requireAuth: false,
  );
}
