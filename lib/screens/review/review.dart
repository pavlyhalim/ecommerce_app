import 'package:flutter/material.dart';
import 'package:shopping_mall/screens/review/order%20history.dart';

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int currentRating = 0; // التقييم الحالي
  TextEditingController reviewController = TextEditingController(); // للتحكم في النص

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // عدد التبويبات
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reviews and Orders'),
          elevation: 2,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Write a Review'),
              Tab(text: 'Order History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WriteReviewTab(
              onRatingSelected: (rating) {
                setState(() {
                  currentRating = rating;
                });
              },
              currentRating: currentRating,
              reviewController: reviewController,
            ),
            OrderHistoryPage(),
          ],
        ),
      ),
    );
  }
}

class WriteReviewTab extends StatelessWidget {
  final Function(int) onRatingSelected;
  final int currentRating;
  final TextEditingController reviewController;

  WriteReviewTab({
    required this.onRatingSelected,
    required this.currentRating,
    required this.reviewController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ReviewItem(
          itemName: "Penguin Chocolate",
          itemImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTuKdstaRR3eVsDtudLS0mUiDKmDXhEzKg6EgRQP1u4OyMt9SE-ThMeA5rPaD2QpHxcYg&usqp=CAU",
          onRatingSelected: onRatingSelected,
          currentRating: currentRating,
          reviewController: reviewController,
        ),
      ],
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String itemName;
  final String itemImageUrl;
  final Function(int) onRatingSelected;
  final int currentRating;
  final TextEditingController reviewController;

  ReviewItem({
    required this.itemName,
    required this.itemImageUrl,
    required this.onRatingSelected,
    required this.currentRating,
    required this.reviewController,
  });

  void submitReview(BuildContext context) {
    if (currentRating == 0 || reviewController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete your review before submitting.')),
      );
      return;
    }

    // تنفيذ إرسال المراجعة (يمكن الاتصال بالخادم هنا)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Review submitted successfully!')),
    );

    // إعادة التهيئة
    reviewController.clear();
    onRatingSelected(0);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Redirect to item details
                  },
                  child: Image.network(
                    itemImageUrl,
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    // Redirect to item details
                  },
                  child: Text(
                    itemName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: List.generate(
                5,
                    (index) => IconButton(
                  icon: Icon(
                    index < currentRating ? Icons.star : Icons.star_border,
                  ),
                  onPressed: () {
                    onRatingSelected(index + 1);
                  },
                ),
              ),
            ),
            TextField(
              controller: reviewController,
              decoration: InputDecoration(
                labelText: 'Write your review...',
              ),
            ),
            ElevatedButton(
              onPressed: () => submitReview(context),
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}

