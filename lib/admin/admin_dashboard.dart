import 'package:flutter/material.dart';
import '../models/product.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Coffee 1',
      description: 'Delicious coffee',
      price: 5.0,
      imageUrl: 'https://example.com/coffee1.jpg',
      quantity: 10,
      category: 'Drinks',
    ),
    Product(
      id: '2',
      name: 'Coffee 2',
      description: 'Strong coffee',
      price: 6.0,
      imageUrl: 'https://example.com/coffee2.jpg',
      quantity: 5,
      category: 'Drinks',
    ),
  ];

  void _addProduct() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String name = '';
        String description = '';
        double price = 0.0;
        String imageUrl = '';
        int quantity = 0;
        String category = 'Food'; // Default category
        const categories = ['Food', 'Drinks', 'Fruits', 'Vegetables', 'Dairy', 'Snacks', 'Baked Goods'];

        return AlertDialog(
          title: const Text('Add New Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (value) => name = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  onChanged: (value) => description = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => price = double.tryParse(value) ?? 0.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  onChanged: (value) => imageUrl = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => quantity = int.tryParse(value) ?? 0,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Category'),
                  value: category,
                  items: categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    category = newValue!;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  products.add(Product(
                    id: DateTime.now().toString(), // Generate a unique ID
                    name: name,
                    description: description,
                    price: price,
                    imageUrl: imageUrl,
                    quantity: quantity,
                    category: category,
                  ));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              products[index].imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)} - ${products[index].category}'),
          );
        },
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: _addProduct, child: const Icon(Icons.add)),
    );
  }
}