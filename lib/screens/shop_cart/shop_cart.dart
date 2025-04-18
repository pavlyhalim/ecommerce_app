import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'package:shopping_mall/screens/shop_cart/order_page.dart';
import '../../cart_provider.dart';
import '../../models/order.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  double calculateTotal(List<Product> cartItems) {
    double total = 0.0;
    for (int i = 0; i < cartItems.length; i++) {
      total += cartItems[i].quantity * cartItems[i].price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = CartProvider.of(context);

    return Scaffold(
      appBar: AppBar(
      ),
      body: ValueListenableBuilder<List<Product>>(
        valueListenable: cartProvider!.cartItems,
        builder: (context, cartItems, child) {
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final product = cartItems[index];
              return ListTile(
                leading: Image.network(
                  product.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(product.name),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        cartProvider.removeItem(product);
                      },
                    ),
                    Text('${product.quantity}'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        cartProvider.incrementQuantity(product);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: \$${calculateTotal(cartProvider.cartItems.value).toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {
                // Create a new order
                final order = Order(
                  orderId: DateTime.now().toString(),
                  products: cartProvider.cartItems.value,
                  totalAmount: calculateTotal(cartProvider.cartItems.value),
                  orderDate: DateTime.now(),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderPage(order: order)),
                );
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
