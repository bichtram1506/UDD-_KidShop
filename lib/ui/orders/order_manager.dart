import 'package:flutter/material.dart';

import '../../models/cart_item.dart';
import '../../models/order_item.dart';

class OrdersManager with ChangeNotifier {
  final List<OrderItem> _orders = [
    OrderItem(
      id: 'o1',
      amount: 59.98,
      products: [
        CartItem(
      id: 'c1',
      title: 'Cua Trong Suốt',
      price: 77.000,
      quantity: 2,
      imageUrl: 'https://tongkhothienan.com/wp-content/uploads/2022/07/do-choi-cho-be-con-phat-sang-banh-rang-tongkhothienan-2.jpg',
        )
      ],
      dateTime: DateTime.now(),
    )
  ];
  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }
  void addOrder(List<CartItem> cartProducts, double total) async {
    _orders.insert(
      0,
      OrderItem(
        id: 'o${DateTime.now().toIso8601String()}',
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}