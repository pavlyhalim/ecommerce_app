import 'package:flutter/material.dart';
import 'package:shopping_mall/screens/profile/my_page.dart';
import 'package:shopping_mall/screens/profile/my_story.dart';

class profile_page extends StatelessWidget {
  const profile_page({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab( text: 'My Story'),
              Tab( text: 'My Page'),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            StoryScreen(),
            MyPage(),
          ],
        ),
      ),
    );
  }
}

