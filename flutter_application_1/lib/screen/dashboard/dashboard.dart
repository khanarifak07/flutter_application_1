import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilities/utilities.dart';
import 'package:flutter_application_1/screen/TODO/todo_list.dart';
import 'package:flutter_application_1/screen/cart/cart.dart';
import 'package:flutter_application_1/screen/categories/categories.dart';
import 'package:flutter_application_1/screen/home/home.dart';
import 'package:flutter_application_1/screen/login/login.dart';
import 'package:flutter_application_1/screen/profile/profile.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Home',
      'page': const Home(),
    },
    {
      'title': 'Categories',
      'page': const Categories(),
    },
    {
      'title': 'Cart',
      'page': const Cart(),
    },
    {
      'title': 'Profile',
      'page': const Profile(),
    },
    {
      'title': 'Todo',
      'page': const TodoList(),
    },
  ];

  int _currentIndex = 0;

  void onChange(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> logout() async {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Logging Out"),
            actions: [CircularProgressIndicator()],
          );
        });
    Future.delayed(const Duration(seconds: 2), () {
      Utilities.removeToken();
      Utilities.navigatePushReplacement(context, const Login());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(
          _pages[_currentIndex]['title'],
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          _currentIndex == 3
              ? IconButton(
                  onPressed: () async {
                    await logout();
                  },
                  icon: const Icon(Icons.logout))
              : const Text(""),
        ],
      ),
      body: _pages[_currentIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: onChange,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.category),
              label: "Categories",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.bag),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.user2),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.plus),
              label: "Todo",
            ),
          ]),
    );
  }
}
