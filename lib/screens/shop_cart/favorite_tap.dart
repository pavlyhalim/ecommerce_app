import 'package:flutter/material.dart';

class FavoritesTab extends StatefulWidget {
  @override
  _FavoritesTabState createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  List<Map<String, dynamic>> favoriteItems = [
    {
      'name': 'Dark Marshmallow Chocolate (6 pcs)',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTuKdstaRR3eVsDtudLS0mUiDKmDXhEzKg6EgRQP1u4OyMt9SE-ThMeA5rPaD2QpHxcYg&usqp=CAU',
      'deliveryInfo': 'Order by 11 PM to get it by Wednesday',
      'price': 12000
    },
    {
      'name': 'Milk Chocolate Bars (10 pcs)',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTuKdstaRR3eVsDtudLS0mUiDKmDXhEzKg6EgRQP1u4OyMt9SE-ThMeA5rPaD2QpHxcYg&usqp=CAU',
      'deliveryInfo': 'Order by 9 PM to get it by Tuesday',
      'price': 15000
    },
    {
      'name': 'White Chocolate Delights (5 pcs)',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTuKdstaRR3eVsDtudLS0mUiDKmDXhEzKg6EgRQP1u4OyMt9SE-ThMeA5rPaD2QpHxcYg&usqp=CAU',
      'deliveryInfo': 'Order by 1 PM to get it tomorrow',
      'price': 18000
    },
  ];

  void removeItem(int index) {
    setState(() {
      favoriteItems.removeAt(index);
    });
  }

  void openItemDetails(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailsScreen(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return favoriteItems.isEmpty
        ? Center(child: Text('No favorites yet!'))
        : ListView.builder(
      itemCount: favoriteItems.length,
      itemBuilder: (context, index) {
        final item = favoriteItems[index];
        return Card(
          child: ListTile(
            leading: Image.network(
              item['imageUrl'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(item['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['deliveryInfo']),
                Text('Price: ${item['price']} KRW'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => removeItem(index), // Remove from favorites
            ),
            onTap: () => openItemDetails(item), // Open item details
          ),
        );
      },
    );
  }
}

class ItemDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  ItemDetailsScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              item['imageUrl'],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              item['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              item['deliveryInfo'],
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              'Price: ${item['price']} KRW',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
