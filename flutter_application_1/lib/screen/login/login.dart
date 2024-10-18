import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilities/utilities.dart';
import 'package:flutter_application_1/model/profile_model.dart';
import 'package:flutter_application_1/screen/dashboard/dashboard.dart';
import 'package:flutter_application_1/service/api_service.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameCtrl = TextEditingController(text: "emilys");
  final passwordCtrl = TextEditingController(text: "emilyspass");
  bool isLoading = false;

  Future<void> login(
      {required String username, required String password}) async {
    setState(() {
      isLoading = true;
    });
    try {
      Map<String, dynamic> data = {
        'username': username,
        'password': password,
      };

      var apiResponse = await http.post(
        Uri.parse(APIService.loginURL),
        body: data,
      );
      if (apiResponse.statusCode == 200) {
        var response = json.decode(apiResponse.body);
        ProfileModel profileModel = ProfileModel.fromJson(response);
        //save user details
        Utilities.saveUserDetails(profileModel);
        //save token
        String token = response['token'];
        Utilities.saveToken(token);
        //navigate to home page
        Utilities.navigatePushReplacement(context, const Dashboard());

        log(apiResponse.body.toString());
      }
    } catch (e) {
      log("Error while logging $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Map<String, dynamic> profileData = {};
  // ProfileModel? pData;

  // Future<void> loadUserData() async {
  //   try {
  //     var profileData = await Utilities.getUserDetails();
  //     pData = ProfileModel.fromJson(profileData);
  //     setState(() {});
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(profileData['email'])),
      // appBar: AppBar(
      //   title: Text(pData!.email!),
      //   actions: [
      //     Image.network(pData!.image!),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login Here",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: usernameCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "username",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "password",
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      login(
                          username: usernameCtrl.text,
                          password: passwordCtrl.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent),
                    child: const Text("Login"),
                  )
          ],
        ),
      ),
    );
  }
}
