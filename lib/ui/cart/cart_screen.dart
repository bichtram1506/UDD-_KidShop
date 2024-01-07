import 'package:flutter/material.dart';
import '/models/product.dart';
import 'cart_manager.dart';
import '/ui/orders/order_manager.dart';
import 'cart_item_card.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
 Widget build(BuildContext context) {
 final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ Hàng'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: buildCartDetails(cart),
          ),
          const SizedBox(height: 20),
          buildCartSummary(cart, context),
        ],
      ),
    );
  }
Widget buildCartDetails(CartManager cart) {
  return ListView(
    padding: const EdgeInsets.symmetric(vertical: 20),
    children: cart.productEntries
      .map(
        (entry) => CartItemCard(
          productId: entry.key,
          cardItem: entry.value,
        ),
      )
      .toList(),
  );
}

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Tổng cộng',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Chip(
              label: Text(
                '\$${cart.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                ),
              ),
              backgroundColor: Colors.pink,
            ),
            TextButton(
              onPressed: cart.totalAmount <= 0
                ? null
                : () {
                  context.read<OrdersManager>().addOrder(
                    cart.products,
                    cart.totalAmount,
                  );
                  cart.clear();
                },
                style: TextButton.styleFrom(
                  textStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                child: const Text('Đặt hàng'),
               )
          ],
        ),
      ),
    );
  }
}