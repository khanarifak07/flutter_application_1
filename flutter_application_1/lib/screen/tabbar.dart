import 'dart:developer';

import 'package:flutter/material.dart';

class TabBarDemo extends StatefulWidget {
  const TabBarDemo({super.key});

  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> with TickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;

  @override
  void initState() {
    print('initState Called');
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          currentIndex = _tabController.index;
        });
      }
      log(currentIndex.toString());
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependency Called");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TabBar Demo"),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text("One"),
            ),
            Tab(
              child: Text("Two"),
            ),
            Tab(
              child: Text("Three"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(
            child: Text("One"),
          ),
          Center(
            child: Text("Two"),
          ),
          Center(
            child: Text("Three"),
          ),
        ],
      ),
    );
  }
}
