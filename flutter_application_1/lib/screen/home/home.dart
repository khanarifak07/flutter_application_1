import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilities/app_theme.dart';
import 'package:flutter_application_1/Utilities/utilities.dart';
import 'package:flutter_application_1/screen/categories/Provider/categories_provider.dart';
import 'package:flutter_application_1/screen/home/products_details_page.dart';
import 'package:flutter_application_1/screen/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeProvider homeProvider;
  late CategoriesProvider categoriesProvider;

  // @override
  // void initState() {
  //   homeProvider = Provider.of<HomeProvider>(context, listen: false);
  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (value) {
  //       homeProvider.getAllProductsMethod();
  //     },
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    categoriesProvider = Provider.of<CategoriesProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: homeProvider.products != null && homeProvider.products!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.3,
                ),
                itemCount: homeProvider.products!.length,
                itemBuilder: (context, index) {
                  final product = homeProvider.products![index];
                  return GestureDetector(
                    onTap: () {
                      Utilities.nextScreen(
                        context,
                        ProductsDetailPage(
                          productModel: product,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            height: 100,
                            imageUrl: product.images[0],
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            placeholder: (context, url) =>
                                const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product.title,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: AppTheme.subtitle.copyWith(fontSize: 11.rs),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
