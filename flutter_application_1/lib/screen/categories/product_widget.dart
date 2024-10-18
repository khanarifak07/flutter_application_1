import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/categories/Provider/categories_provider.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  final String categoryName;
  const ProductWidget({super.key, required this.categoryName});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  late CategoriesProvider _categoriesProvider;

  @override
  void initState() {
    _categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    //Removig the element of previous products
    _categoriesProvider.categoryProducts = [];
    WidgetsBinding.instance.addPostFrameCallback((value) {
      //save the loaded product in map to avoid unnecessary loading
      if (_categoriesProvider.categoriesMap.containsKey(widget.categoryName)) {
        setState(() {
          _categoriesProvider.categoryProducts =
              _categoriesProvider.categoriesMap[widget.categoryName]!;
        });
      }
      //calling getProductByCategory to get the latest data
      _categoriesProvider.getProductByCategory(
          categoryName: widget.categoryName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _categoriesProvider = Provider.of<CategoriesProvider>(context);
    return Scaffold(
      body: _categoriesProvider.categoryProducts != null &&
              _categoriesProvider.categoryProducts!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: _categoriesProvider.categoryProducts!.length,
                  itemBuilder: (context, index) {
                    var data = _categoriesProvider.categoryProducts![index];

                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            child: CachedNetworkImage(
                              imageUrl: data.images![0],
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              placeholder: (context, url) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            data.title!,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
