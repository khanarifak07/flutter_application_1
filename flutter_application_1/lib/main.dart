import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/routes.dart';
import 'package:flutter_application_1/screen/cart/cart_provider.dart';
import 'package:flutter_application_1/screen/categories/Provider/categories_provider.dart';
import 'package:flutter_application_1/screen/home/home.dart';
import 'package:flutter_application_1/screen/home/provider/home_provider.dart';
import 'package:flutter_application_1/screen/login/login.dart';
import 'package:flutter_application_1/screen/splash_screen/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider())
      ],
      child: Flexify(
        designHeight: 812,
        designWidth: 375,
        app: MaterialApp(
          home: const SplashScreen(),
          routes: {
            Routes.LOGIN: (_) => const Login(),
            Routes.HOME: (_) => const Home(),
          },
        ),
      ),
    );
  }
}
