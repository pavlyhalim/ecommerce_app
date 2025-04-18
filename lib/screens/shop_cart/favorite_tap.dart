import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../favorites_provider.dart';

class FavoriteTap extends StatelessWidget {
  const FavoriteTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteProducts = favoritesProvider.favoriteProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(
              child: Text('No favorites added yet.'),
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.network(
                          product.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            product.name,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            favoritesProvider.removeFavorite(product);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}