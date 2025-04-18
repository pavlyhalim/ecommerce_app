import 'package:flutter/material.dart';
import 'package:shopping_mall/models/order.dart';

class ReviewScreen extends StatelessWidget {
  final Order? order;

  const ReviewScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Order')),
      body: order == null || order!.products.isEmpty
          ? const Center(child: Text('No products to review.'))
          : ListView.builder(
              itemCount: order!.products.length,
              itemBuilder: (context, index) {
                final product = order!.products[index];
                return ReviewItem(product: product);
              },
            ),
    );
  }
}

class ReviewItem extends StatefulWidget {
  final dynamic product;

  const ReviewItem({Key? key, this.product}) : super(key: key);

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Rating:'),
                const SizedBox(width: 8),
                DropdownButton<double>(
                  value: _rating == 0 ? null : _rating,
                  hint: const Text('Select rating'),
                  items: [1.0, 2.0, 3.0, 4.0, 5.0].map((double value) {
                    return DropdownMenuItem<double>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _rating = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Comment',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Submit review logic here
                submitReview(widget.product, _rating, _commentController.text);
              },
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }

  void submitReview(product, rating, comment) {
    print('Review submitted for ${product.name} with rating $rating and comment: $comment');
  }
}
