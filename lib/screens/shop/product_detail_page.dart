import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'package:provider/provider.dart';
import '../../cart_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../favorites_provider.dart';
import '../../models/review.dart';
import '../../widgets/review_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedQuantity = 1; // Initial quantity selection
  int _currentImageIndex = 0;
  final List<String> _imageUrls = [
    'https://example.com/chocolate1.jpg',
    'https://example.com/chocolate2.jpg',
    'https://example.com/chocolate3.jpg',
    'https://example.com/chocolate4.jpg',
    'https://example.com/chocolate4.jpg',
    'https://example.com/chocolate5.jpg',
  ];

  void _addToCart() {
    final cartProvider = CartProvider.of(context);
    cartProvider?.addItem(widget.product, _selectedQuantity);
  }

  void _orderNow() {
    // TODO: Implement order now functionality - navigate to order page with selected quantity and product
  }

  void _shareProduct() {
    Share.share('Check out this awesome product: ${widget.product.name} - https://example.com/product/${widget.product.id}');
  }

  @override
  Widget build(BuildContext context) {
    List<Review> reviews = [
      Review(
        reviewerName: 'John Doe',
        reviewText: 'Great product!',
        rating: 5,
        likes: 10,
        comments: ['Awesome!', 'I agree!'],
      ),
      Review(
        reviewerName: 'Jane Smith',
        reviewText: 'Good product, but...',
        rating: 4,
        likes: 5,
        comments: ['Could be better.'],
      ),
      Review(
        reviewerName: 'Peter Jones',
        reviewText: 'Not what I expected.',
        rating: 2,
        likes: 2,
        comments: [],
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 16,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: _shareProduct,
          ),
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final isFavorite = favoritesProvider.isFavorite(widget.product);
              return IconButton(
                icon:
                    Icon(isFavorite ? Icons.star : Icons.star_border, color: Colors.black),
                onPressed: () {
                  if (isFavorite) {
                    favoritesProvider.removeFavorite(widget.product);
                  } else {
                    favoritesProvider.addFavorite(widget.product);
                  }
                },
              );
            },
          ),
        ],
        elevation: 0, // Removes shadow
        toolbarHeight: 56,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. Hero Image & Carousel Indicator
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: _imageUrls.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        _imageUrls[index],
                        fit: BoxFit.cover,
                      );
                    },
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: 24,
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_back_ios, color: Colors.white60, size: 12),
                          Text(
                            'Frame \${_currentImageIndex + 1}/${_imageUrls.length}',
                            style: const TextStyle(fontSize: 12, color: Colors.white60),
                          ),
                          const SizedBox(width: 4),
                          Row(
                            children: List.generate(
                              _imageUrls.length,
                              (index) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      _currentImageIndex == index ? Colors.white60 : Colors.white60.withOpacity(0.3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 3. Product Title & Shipping Info
                  Text(
                    widget.product.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF333333)),
                  ),
                  Text(
                    widget.product.description,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tomorrow (Wed) Expected · Free Shipping',
                    style: TextStyle(fontSize: 14, color: Color(0xFF777777)),
                  ),

                  const SizedBox(height: 16),

                  // 4. Quantity & Pricing Selector Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFEEEEEE)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildQuantityOption(1, 12000),
                        const SizedBox(height: 12),
                        _buildQuantityOption(2, 22000),
                        const SizedBox(height: 12),
                        _buildQuantityOption(4, 40000),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 5. Purchase Instructions & Stock Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFEEEEEE)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Instructions on purchase',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Store in Fridge · Consume within 1 year after purchase.',
                          style: TextStyle(fontSize: 14, color: Color(0xFF555555)),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Order before to start delivery today',
                          style: TextStyle(fontSize: 14, color: Color(0xFF555555)),
                        ),
                        Text(
                          '1 p.m.',
                          style: TextStyle(fontSize: 12, color: Color(0xFF888888)),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text(
                              'Left in Stock',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                            ),
                            Text(
                              '87',
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 6. Reviews & Ratings Section
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star,
                        color: Color(0xFFFFC107),
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // Add some spacing
                  SizedBox(
                    height: 150, // Adjust the height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        return ReviewWidget(
                          review: reviews[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _addToCart,
                child: const Text('Add to Cart', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _orderNow,
                child: const Text('Order now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityOption(int quantity, int price) {
    //bool isSelected = _selectedQuantity == quantity;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedQuantity = quantity;
        });
      },
      child: Row(
        children: [
          Radio<int>(
            value: quantity,
            groupValue: _selectedQuantity,
            onChanged: (value) {
              setState(() {
                _selectedQuantity = value!;
              });
            },
          ),
          Text('$quantity Quantity $price KRW (1 piece ${price / quantity} KRW)'),
        ],
      ),
    );
  }
}