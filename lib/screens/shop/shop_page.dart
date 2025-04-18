import 'package:flutter/material.dart';
import 'package:shopping_mall/screens/shop/ProductDetailPage.dart';

// صفحة المتجر الأصلية كما كانت
class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final Map<String, List<Map<String, dynamic>>> categories = {
    'Dessert': [
      {
        'name': 'Dark Marshmallow Chocolate (6 pieces)',
        'price': '12,000₩',
        'arrivalDate': 'Expected tomorrow',
        'deliveryCost': 'Free delivery',
        'rating': '★★★ 1,740',
        'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbyrBf2cSOrocaEERxKjP80AvIOgVbkHcW0zDehQY78RkLroY8D2IcNrBxhYZLPv9jAIw&usqp=CAU',
      },
      {
        'name': 'Large Dubai Chocolate (1 piece)',
        'price': '16,000₩',
        'arrivalDate': 'Expected tomorrow',
        'deliveryCost': 'Free delivery',
        'rating': '★★ 2,100',
        'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbyrBf2cSOrocaEERxKjP80AvIOgVbkHcW0zDehQY78RkLroY8D2IcNrBxhYZLPv9jAIw&usqp=CAU',
      },
    ],
    'Fresh Food': [
      {
        'name': 'Fresh Apples',
        'price': '5,000₩',
        'arrivalDate': 'Expected tomorrow',
        'deliveryCost': 'Free delivery',
        'rating': '★★★ 920',
        'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbyrBf2cSOrocaEERxKjP80AvIOgVbkHcW0zDehQY78RkLroY8D2IcNrBxhYZLPv9jAIw&usqp=CAU',
      },
    ],
    'Instant Food': [
      {
        'name': 'Instant Noodles',
        'price': '2,500₩',
        'arrivalDate': 'Expected tomorrow',
        'deliveryCost': 'Free delivery',
        'rating': '★ 1,050',
        'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbyrBf2cSOrocaEERxKjP80AvIOgVbkHcW0zDehQY78RkLroY8D2IcNrBxhYZLPv9jAIw&usqp=CAU',
      },
    ],
    'Household Goods': [
      {
        'name': 'Dishwashing Liquid',
        'price': '3,000₩',
        'arrivalDate': 'Expected tomorrow',
        'deliveryCost': 'Free delivery',
        'rating': '★★ 1,230',
        'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbyrBf2cSOrocaEERxKjP80AvIOgVbkHcW0zDehQY78RkLroY8D2IcNrBxhYZLPv9jAIw&usqp=CAU',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.keys.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shopping Categories'),
          elevation: 2,
          bottom: TabBar(
            tabs:
            categories.keys.map((category) => Tab(text: category)).toList(),
          ),
        ),
        body: TabBarView(
          children: categories.keys
              .map((category) => buildCategoryTab(categories[category]!))
              .toList(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            showSearch(
              context: context,
              delegate: ItemSearchDelegate(categories),
            );
          },
          child: const Icon(Icons.search),
        ),
      ),
    );
  }

  Widget buildCategoryTab(List<Map<String, dynamic>> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Image.network(
                  item['imageUrl'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text('Price: ${item['price']}'),
                      Text('Arrival: ${item['arrivalDate']}'),
                      Text('Delivery: ${item['deliveryCost']}'),
                      Text('Rating: ${item['rating']}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ItemSearchDelegate extends SearchDelegate {
  final Map<String, List<Map<String, dynamic>>> categories;

  ItemSearchDelegate(this.categories);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchResults = categories.values
        .expand((items) => items)
        .where((item) =>
        item['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (searchResults.isEmpty) {
      return const Center(child: Text('No results found'));
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final item = searchResults[index];
        return ListTile(
          leading: Image.network(
            item['imageUrl'],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(item['name']),
          subtitle: Text('Price: ${item['price']}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailPage(product: {
                  'name': 'Dark marshmallow 6 pieces',
                  'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbyrBf2cSOrocaEERxKjP80AvIOgVbkHcW0zDehQY78RkLroY8D2IcNrBxhYZLPv9jAIw&usqp=CAU',
                  'price': 12000,
                  'discount2': 2000,      // مثال: خصم على 2 قطعة
                  'discount4': 8000,      // مثال: خصم على 4 قطع
                  'arrivalDate': 'Tomorrow (Wed)',
                  'deliveryCost': 'Free Shipping',
                  'instructions': 'Store in Fridge · Consume within 1 year after purchase',
                  'orderBefore': '1 p.m.',
                  'stock': 87,
                  'totalReviews': 1740,
                  'reviews': [
                    {
                      'avatarUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbyrBf2cSOrocaEERxKjP80AvIOgVbkHcW0zDehQY78RkLroY8D2IcNrBxhYZLPv9jAIw&usqp=CAU',
                      'comment': 'Awesome taste!',
                      'stars': 5,
                    },
                    {
                      'avatarUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbyrBf2cSOrocaEERxKjP80AvIOgVbkHcW0zDehQY78RkLroY8D2IcNrBxhYZLPv9jAIw&usqp=CAU',
                      'comment': 'Too sweet for me',
                      'stars': 3,
                    },
                  ],
                }),
              ),
            );

          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = categories.values
        .expand((items) => items)
        .where((item) =>
        item['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return ListTile(
          leading: Image.network(
            item['imageUrl'],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(item['name']),
          subtitle: Text('Price: ${item['price']}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailPage(product: {
                  'name': 'Dark marshmallow 6 pieces',
                  'imageUrl': 'https://link.to/image.png',
                  'price': 12000,
                  'discount2': 2000,      // مثال: خصم على 2 قطعة
                  'discount4': 8000,      // مثال: خصم على 4 قطع
                  'arrivalDate': 'Tomorrow (Wed)',
                  'deliveryCost': 'Free Shipping',
                  'instructions': 'Store in Fridge · Consume within 1 year after purchase',
                  'orderBefore': '1 p.m.',
                  'stock': 87,
                  'totalReviews': 1740,
                  'reviews': [
                    {
                      'avatarUrl': 'https://via.placeholder.com/60',
                      'comment': 'Awesome taste!',
                      'stars': 5,
                    },
                    {
                      'avatarUrl': 'https://via.placeholder.com/60',
                      'comment': 'Too sweet for me',
                      'stars': 3,
                    },
                  ],
                }),
              ),
            );

          },
        );
      },
    );
  }
}


