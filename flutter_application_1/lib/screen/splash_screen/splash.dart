import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilities/utilities.dart';
import 'package:flutter_application_1/screen/dashboard/dashboard.dart';
import 'package:flutter_application_1/screen/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      initialize();
    });
    super.initState();
  }

  void initialize() async {
    var token = await Utilities.getToken();
    print(token);
    if (token == null) {
      Utilities.navigatePushReplacement(context, const Login());
    } else {
      Utilities.navigatePushReplacement(context, const Dashboard());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash Screen Loading...."),
      ),
    );
  }
}
