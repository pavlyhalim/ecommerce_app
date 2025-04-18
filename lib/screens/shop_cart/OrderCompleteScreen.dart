import 'package:flutter/material.dart';
import 'package:shopping_mall/layout/home_layout.dart';
import 'package:shopping_mall/screens/coffee/coffeePage.dart';

class OrderCompleteScreen extends StatelessWidget {
  const OrderCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const OrderCompleteScreen(),
            ),
          );
        }, icon: const Icon(Icons.arrow_back_rounded)),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => MainPage(),
              ),
              );

            }
            ,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Order Complete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
