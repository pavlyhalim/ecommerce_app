import 'package:flutter/material.dart';

void main() {
  runApp(const SearchPage());
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ItemPage(),
    );
  }
}

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sliding Images
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: PageView(
                    children: [
                      Image.network(
                          'https://cdn.salla.sa/ZwVgx/4b66248c-accc-4852-a0e4-6c28d562f495-1000x1000-KsD6AtWVX2x1IARjiGTrGpiPg6LEhfoYRXNDJc5s.jpg',
                          fit: BoxFit.cover
                      ),
                      Image.network(
                          'https://cdn.salla.sa/ZwVgx/4b66248c-accc-4852-a0e4-6c28d562f495-1000x1000-KsD6AtWVX2x1IARjiGTrGpiPg6LEhfoYRXNDJc5s.jpg',
                          fit: BoxFit.cover
                      ),
                      Image.network(
                          'https://cdn.salla.sa/ZwVgx/4b66248c-accc-4852-a0e4-6c28d562f495-1000x1000-KsD6AtWVX2x1IARjiGTrGpiPg6LEhfoYRXNDJc5s.jpg',
                          fit: BoxFit.cover
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // Seller Name
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Seller: Chocolate World',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),

                // Product Name
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Product: Mini Dubai Chocolate (10 pieces)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),

                // Expected Delivery Date
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Expected Delivery Date: Thursday',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),

                // Delivery Price
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Delivery Price: Free delivery',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),

                // Quantity Selector
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Text(
                        'Quantity:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Product Description
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Description: This delicious mini Dubai chocolate comes in a box of 10 pieces. Perfect for gifting or indulging yourself.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),

                // Reviews
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reviews:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '★ ★ ★ ★ ★ Amazing product!',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        '★ ★ ★ ★ ★ Worth the price!',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100), // مساحة لإظهار الأزرار في الأسفل
              ],
            ),
          ),

          // Bottom Buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('Added to Cart');
                    },
                    child: const Text('Add to Cart'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('Purchased Now');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Purchase Now'),
                  ),
                  IconButton(
                    onPressed: () {
                      print('Marked as Favorite');
                    },
                    icon: const Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      print('Shared');
                    },
                    icon: const Icon(Icons.share),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
