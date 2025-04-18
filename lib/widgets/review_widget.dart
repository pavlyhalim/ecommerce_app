import 'package:flutter/material.dart';

import '../../models/review.dart';

class ReviewWidget extends StatefulWidget {
  final Review review;

  const ReviewWidget({Key? key, required this.review}) : super(key: key);

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage('https://via.placeholder.com/48'),
              ),
              const SizedBox(width: 8),
              Text(
                widget.review.reviewerName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.review.reviewText,
            style: const TextStyle(fontSize: 12, color: Color(0xFF555555)),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              5,
              (index) => const Icon(
                Icons.star,
                color: Color(0xFFFFC107),
                size: 12,
                semanticLabel: '\u{a4b}',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up_alt_outlined, size: 16),
                    onPressed: () {
                      setState(() {
                        widget.review.likes++;
                      });
                    },
                  ),
                  const SizedBox(width: 4),
                  Text('${widget.review.likes}'),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.comment, size: 16),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Add a comment'),
                            content: TextField(
                              controller: _commentController,
                              decoration: const InputDecoration(
                                hintText: 'Write your comment here...',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    widget.review.comments.add(_commentController.text);
                                    _commentController.clear();
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Text('Add'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 4),
                  Text('${widget.review.comments.length}'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}