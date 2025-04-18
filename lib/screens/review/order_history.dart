import 'package:flutter/material.dart';
import '../../models/order.dart';
import 'package:intl/intl.dart';

class OrderHistory extends StatelessWidget {
  final List<Order> orders;

  const OrderHistory({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: orders.isEmpty
          ? const Center(
              child: Text('No orders yet.'),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ID: ${order.orderId}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Order Date: ${DateFormat('yyyy-MM-dd – kk:mm').format(order.orderDate)}',
                        ),
                        Text('Total Amount: \$${order.totalAmount.toStringAsFixed(2)}'),
                        const Text('Products:'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: order.products.map((product) => Text(product.name)).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}