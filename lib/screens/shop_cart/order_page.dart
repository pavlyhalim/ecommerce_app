import 'package:flutter/material.dart';
import 'package:shopping_mall/models/order.dart';
import 'package:shopping_mall/screens/review/review.dart';

class OrderPage extends StatelessWidget {
  final Order? order;
  const OrderPage({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Order Confirmed!'),
            ElevatedButton(
              onPressed: () {
                // Navigate to the review page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewScreen(order: order),
                  ),
                );
              },
              child: const Text('Review Order'),
            ),
          ],
        ),
      ),
    );
  }
}
