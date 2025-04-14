import 'package:flutter/material.dart';

class PageWithIcon extends StatelessWidget {
   IconData icon;
   String label;

  PageWithIcon({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.grey), // الأيقونة الرمادية
        Expanded(
          child: Center(
            child: Text('$label Page', style: TextStyle(fontSize: 24)),
          ),
        ),
      ],
    );
  }
}
