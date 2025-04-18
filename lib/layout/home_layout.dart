import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_mall/screens/shop/shop_page.dart';
import 'package:shopping_mall/screens/shop_cart/shop_cart.dart';
import '../screens/coffee/coffee_page.dart';
import '../screens/coffee/coffee_cubit.dart';
import 'package:shopping_mall/screens/profile/profile.dart';
import '../models/product.dart';
import '../cart_provider.dart';
import '../widgets/search_page.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ValueNotifier<List<Product>> _cartItems = ValueNotifier<List<Product>>([]);

  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    readJsonData();
  }

  Future<void> readJsonData() async {
    try {
      final jsonData = await rootBundle.rootBundle.loadString('products.json');
      final list = json.decode(jsonData) as List<dynamic>;
      setState(() {
        products = list.map((e) => Product.fromJson(e)).toList();
      });
    } catch (e) {
      print('Error loading products.json: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CartProvider(
      cartItems: _cartItems,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shopping Mall'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(products: products),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            if (currentIndex == 1) {
              // ShopPage
              return ShopPage(
                products: products,
                onAddToCart: (Product product) {
                  _cartItems.value = List.from(_cartItems.value)..add(product);
                },
              );
            }
            return _pages[currentIndex];
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return BottomNavigationBar(
              currentIndex: currentIndex,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                context.read<NavigationCubit>().navigateTo(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.coffee), label: 'Coffee'),
                BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shop'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Shop Cart'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              ],
            );
          },
        ),
      ),
    );
  }

  final List<Widget> _pages = [
    const RecommendationsTab(),
    Container(), //Placeholder
    const ShoppingCartScreen(),
    const ProfilePage(),
  ];
}
