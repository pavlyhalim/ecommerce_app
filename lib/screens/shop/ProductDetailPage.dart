import 'package:flutter/material.dart';
import 'package:shopping_mall/screens/shop_cart/shop_cart.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _selectedQty = 1;

  @override
  Widget build(BuildContext context) {
    // Example qty-price map, can come from widget.product
    final Map<int, int> priceMap = {
      1: widget.product['price'],
      2: widget.product['price'] * 2 - widget.product['discount2'] ?? 0,
      4: widget.product['price'] * 4 - widget.product['discount4'] ?? 0,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['name']),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.star_border)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.product['imageUrl'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                widget.product['name'],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                widget.product['arrivalDate'] + ' · ' + widget.product['deliveryCost'],
                style: const TextStyle(color: Colors.black),
              ),

              const SizedBox(height: 24),
              // Quantity selector
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),

                ),
                child: Column(
                  children: priceMap.entries.map((entry) {
                    final qty = entry.key;
                    final total = entry.value;
                    final perPiece = (total ~/ qty);
                    return RadioListTile<int>(
                      value: qty,
                      groupValue: _selectedQty,
                      onChanged: (v) => setState(() => _selectedQty = v!),
                      activeColor: Colors.black,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$qty Quantity', style: const TextStyle(color: Colors.black)),
                          Text('${_formatNumber(total)}KRW', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
                        ],
                      ),
                      subtitle: Text('1 piece ${_formatNumber(perPiece)}KRW', style: const TextStyle(color: Colors.black, fontSize: 12)),
                      dense: true,
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 24),
              // Instructions & stock
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Instructions on purchase', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
                    const Divider(color: Colors.black),
                    Text(widget.product['instructions'], style: const TextStyle(color: Colors.black)),
                    const SizedBox(height: 12),
                    const Text('Order before to start delivery today', style: TextStyle(color: Colors.black)),
                    Text(widget.product['orderBefore'], style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
                    const SizedBox(height: 12),
                    const Text('Left in Stock', style: TextStyle(color: Colors.black)),
                    Text('${widget.product['stock']}', style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              // Reviews
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ...List.generate(5, (i) => const Icon(Icons.star, size: 20, color: Colors.orange)),
                        const SizedBox(width: 8),
                        Text('(${widget.product['totalReviews']})', style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...widget.product['reviews'].take(2).map<Widget>((rev) => _buildReview(rev)).toList(),
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Show all', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ShoppingCartScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Add to Cart', style: TextStyle(fontSize: 16, color: Colors.black)),
              ),
            ),

            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // هنا تقدر تحط أكشن الطلب المباشر
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Order Now'),
                      content: const Text('Order placed successfully!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Order Now', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),

    );
  }

  String _formatNumber(int value) {
    return value.toString().replaceAllMapped(RegExp(r"\B(?=(\d{3})+(?!\d))"), (m) => ',');
  }

  Widget _buildReview(Map<String, dynamic> rev) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(rev['avatarUrl'], width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rev['comment'], style: const TextStyle(color: Colors.black, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(
                    5,
                        (i) => Icon(i < rev['stars'] ? Icons.star : Icons.star_border, size: 16, color: Colors.orange),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
