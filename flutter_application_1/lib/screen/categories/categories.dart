import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/categories/Provider/categories_provider.dart';
import 'package:flutter_application_1/screen/categories/product_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with TickerProviderStateMixin {
  late CategoriesProvider _categoriesProvider;
  TabController? _tabController;
  int tabCurrentIndex = 0;
  late TabController _shimmerTabController;

  @override
  void initState() {
    _categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    if (_categoriesProvider.categoryList != null) {
      _shimmerTabController = TabController(
          length: _categoriesProvider.categoryList!.length, vsync: this);
      _tabController = TabController(
          length: _categoriesProvider.categoryList!.length, vsync: this);
    }

    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _categoriesProvider = Provider.of<CategoriesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
        bottom: _categoriesProvider.categoryList != null
            ? PreferredSize(
                preferredSize: const Size.fromHeight(kTextTabBarHeight),
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    dividerColor: Colors.white,
                    isScrollable: true,
                    controller: _tabController,
                    tabAlignment: TabAlignment.start,
                    tabs: _categoriesProvider.categoryList!
                        .map((e) =>
                            Tab(text: e[0].toUpperCase() + e.substring(1)))
                        .toList(),
                  ),
                ),
              )
            : PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[100]!,
                  highlightColor: Colors.grey[200]!,
                  child: TabBar(
                    isScrollable: true,
                    controller: _shimmerTabController,
                    tabs: List.generate(10, (index) {
                      return Container(
                        height: 40,
                        width: 90,
                        color: Colors.grey,
                      );
                    }),
                  ),
                ),
              ),
      ),
      body: _categoriesProvider.categoryList != null
          ? TabBarView(
              controller: _tabController,
              children: _categoriesProvider.categoryList!
                  .map((e) => ProductWidget(categoryName: e))
                  .toList(),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
