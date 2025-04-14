import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_mall/screens/profile/SignIn.dart';
import 'package:shopping_mall/screens/review/review.dart';
import 'package:shopping_mall/screens/shop/shop_page.dart';
import 'package:shopping_mall/screens/shop_cart/shop_cart.dart';
import '../screens/coffee/coffeePage.dart';
import '../screens/coffee/coffee_cubit.dart';

class MainPage extends StatelessWidget {
  final List<Widget> _pages = [
    RecommendationsTab(),
    ShopPage(),
    ShoppingCartScreen(),
    ReviewScreen(),
    ProfileScreen(),
  ];

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
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
              context.read<NavigationCubit>().navigateTo(index); // تحديث الصفحة
            },
            items: [
              const BottomNavigationBarItem(icon: Icon(Icons.coffee), label: 'Coffee'),
              const BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shop'),
              const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Shop Cart'),
              const BottomNavigationBarItem(icon: Icon(Icons.rate_review), label: 'Review'),
              const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          );
        },
      ),
    );
  }
}
