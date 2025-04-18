import 'package:flutter/material.dart';

class CircularNotificationIcon extends StatefulWidget {
  final bool hasNotification; // Made final
  final VoidCallback onIconPressed;

   const CircularNotificationIcon({ // Added const
    Key? key,
       required this.hasNotification,
    required this.onIconPressed,
  }) : super(key: key);

  @override
  State<CircularNotificationIcon> createState() => _CircularNotificationIconState();
}

class _CircularNotificationIconState extends State<CircularNotificationIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onIconPressed, // تنفيذ العملية عند الضغط
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueGrey, // لون الخلفية حول الصورة
                ),
                child: const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
                  ),
                ),
              ),
              // Conditionally show the red dot based on hasNotification
              if (widget.hasNotification)
                Positioned(
                  right: 5, // مكان النقطة الحمراء
                  top: 5,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10), // مساحة بين الصورة والنص
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "pang2chocolate",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "teste",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      )

    );
  }
}

class InteractionPage extends StatelessWidget {
  final List<Map<String, String>> interactions = [
    {"post": "Post 1", "interaction": "Liked by Ali"},
    {"post": "Post 2", "interaction": "Commented by Maha"},
    {"post": "Post 3", "interaction": "Shared by Karim"},
  ];

  InteractionPage({super.key}); // Removed const

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recent Interactions"),
      ),
      body: ListView.builder(
        itemCount: interactions.length,
        itemBuilder: (context, index) {
          final interaction = interactions[index];
          return ListTile(
            title: Text("Post: ${interaction['post']}"),
            subtitle: Text("Interaction: ${interaction['interaction']}"),
          );
        },
      ),
    );
  }
}
