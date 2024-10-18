import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilities/app_theme.dart';
import 'package:flutter_application_1/Utilities/my_button.dart';
import 'package:flutter_application_1/Utilities/rating.dart';
import 'package:flutter_application_1/Utilities/utilities.dart';
import 'package:flutter_application_1/model/product_model.dart';

class ProductsDetailPage extends StatefulWidget {
  final ProductModel productModel;
  const ProductsDetailPage({super.key, required this.productModel});

  @override
  State<ProductsDetailPage> createState() => _ProductsDetailPageState();
}

class _ProductsDetailPageState extends State<ProductsDetailPage> {
  final PageController _pageController = PageController();
  int currentPageIndex = 0;

  // 1. First method to update the currentPageIndex
  // @override
  // void initState() {
  //   _pageController.addListener(() {
  //     setState(() {
  //       currentPageIndex = _pageController.page!.round();
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        toolbarHeight: kToolbarHeight * 0.1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ProductRating(
                    rating: widget.productModel.rating, isOverAll: true),
              ],
            ),
            SizedBox(
              height: 320,
              child: PageView(
                  controller: _pageController,
                  // 2. Second method to update the currentPageIndex
                  onPageChanged: (value) {
                    setState(() {
                      currentPageIndex = value;
                    });
                  },
                  children: widget.productModel.images.map((e) {
                    return CachedNetworkImage(
                      imageUrl: e,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      placeholder: (context, url) => const SizedBox.shrink(),
                    );
                  }).toList()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(widget.productModel.images.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: currentPageIndex == index
                            ? Colors.amber
                            : Colors.amber[100],
                        borderRadius: BorderRadius.circular(20)),
                    height: 10,
                    width: 10,
                  ),
                );
              }),
            ),
            SizedBox(height: 10.rh),
            Text(
              widget.productModel.description,
              style: AppTheme.description,
            ),
            SizedBox(height: 5.rh),
            const Divider(),
            Text("\$\t${widget.productModel.price}", style: AppTheme.title),
            SizedBox(height: 5.rh),
            const Divider(),
            MyButton(
              ontap: () {
                Utilities.addToCart(widget.productModel);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added To Cart")));
              },
              title: 'Add to Cart',
              bgColor: AppTheme.ratingColor,
              overlayColor: Colors.orange,
            ),
            SizedBox(height: 5.rh),
            MyButton(
              ontap: () {},
              title: 'Buy Now',
              overlayColor: Colors.red,
              bgColor: AppTheme.buyNowColor,
            ),
            SizedBox(height: 5.rh),
            const Divider(),
            Text("Comments", style: AppTheme.description),
            const Divider(),
            SizedBox(height: 5.rh),
            ...widget.productModel.reviews.map((e) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.rh),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.reviewerName,
                          style: AppTheme.subtitle,
                        ),
                        Row(
                          children: [
                            ProductRating(
                              rating: e.rating.toDouble(),
                              isOverAll: false,
                            ),
                            Text(
                              e.rating.toString(),
                              style: AppTheme.subtitle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(e.comment),
                  ],
                ),
              );
            }),
            SizedBox(height: 5.rh),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
