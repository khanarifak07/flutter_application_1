import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilities/app_theme.dart';
import 'package:flutter_application_1/Utilities/my_button.dart';
import 'package:flutter_application_1/screen/cart/cart_provider.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late CartProvider _cartProvider;

  @override
  void initState() {
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((val) {
      _cartProvider.getCartItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: _cartProvider.products != null && _cartProvider.products!.isNotEmpty
          ? Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _cartProvider.products!.length,
                  itemBuilder: (context, index) {
                    final product = _cartProvider.products![index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.all(10),
                        tileColor: Colors.amber[100],
                        leading: CachedNetworkImage(
                          fit: BoxFit.contain,
                          width: 60,
                          imageUrl: product.images[0],
                        ),
                        title: Text(product.title),
                        subtitle: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _cartProvider.updateQuantity(product, -1);
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text('${product.quantity}'),
                            IconButton(
                              onPressed: () async {
                                _cartProvider.updateQuantity(product, 1);
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        // trailing: Text('\$${product.price * product.quantity}'),
                        trailing: IconButton(
                          onPressed: () async {
                            // _cartProvider.updateQuantity(product, -1);
                            _cartProvider.removeFromCart(index);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),
                MyButton(
                    title:
                        'Total Price : \$\t${_cartProvider.getTotalPrice().toStringAsFixed(2)}',
                    bgColor: AppTheme.ratingColor,
                    ontap: () {}),
                MyButton(
                    title: 'Proceed to buy',
                    bgColor: AppTheme.buyNowColor,
                    ontap: () {}),
                SizedBox(height: 10.rh)
              ],
            )
          : const Center(
              child: Text('No items in cart'),
            ),
    );
  }
}
