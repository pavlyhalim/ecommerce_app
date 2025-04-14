import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: ListView(
        children: [
          buildOrderItem(
            context,
            'Dark Marshmallow Penguin Chocolate',
            12000,
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTuKdstaRR3eVsDtudLS0mUiDKmDXhEzKg6EgRQP1u4OyMt9SE-ThMeA5rPaD2QpHxcYg&usqp=CAU',
          ),
          buildOrderItem(
            context,
            'Milk Chocolate Deluxe',
            15000,
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTuKdstaRR3eVsDtudLS0mUiDKmDXhEzKg6EgRQP1u4OyMt9SE-ThMeA5rPaD2QpHxcYg&usqp=CAU',
          ),
        ],
      ),
    );
  }

  Widget buildOrderItem(BuildContext context, String title, int price, String imageUrl) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListTile(
        leading: Image.network(
          imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(title),
        subtitle: Text('Price: $price KRW'),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text('View Details'),
              onTap: () {
                // منطق عرض التفاصيل
              },
            ),
          ],
          child: Icon(Icons.more_vert),
        ),
        onTap: () {
          // اضغط للانتقال إلى صفحة التفاصيل
        },
      ),
    );
  }
}
