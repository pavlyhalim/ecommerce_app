import 'package:flutter/material.dart';
import 'package:shopping_mall/screens/coffee/widgets/notification.dart';

class RecommendationsTab extends StatefulWidget {
  const RecommendationsTab({super.key});

  @override
  _RecommendationsTabState createState() => _RecommendationsTabState();
}

class _RecommendationsTabState extends State<RecommendationsTab> {
  List<Map<String, dynamic>> posts = [
    {
      'user': 'User 1',
      'content': 'This is the content of post number 0.',
      'likes': <String>{},
      'comments': <Map<String, dynamic>>[],
    },
    {
      'user': 'User 2',
      'content': 'This is the content of post number 1.',
      'likes': <String>{},
      'comments': <Map<String, dynamic>>[],
    },
  ];

  final TextEditingController _postController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _editCommentController = TextEditingController();

  void _addPost(String content) {
    setState(() {
      posts.add({
        'user': 'User ${posts.length + 1}',
        'content': content,
        'likes': <String>{},
        'comments': <Map<String, dynamic>>[],
      });
    });
  }

  void _addComment(int postIndex, String comment) {
    setState(() {
      posts[postIndex]['comments'].add({'text': comment});
    });
  }

  void _editComment(int postIndex, int commentIndex) {
    _editCommentController.text =
    posts[postIndex]['comments'][commentIndex]['text'];
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _editCommentController,
                decoration: const InputDecoration(
                  labelText: 'Edit your comment...',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    posts[postIndex]['comments'][commentIndex]['text'] =
                        _editCommentController.text;
                  });
                  _editCommentController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteComment(int postIndex, int commentIndex) {
    setState(() {
      posts[postIndex]['comments'].removeAt(commentIndex);
    });
  }

  void _addFriend(String userName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$userName added as a friend!')),
    );
  }

  void _openPostWindow() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize:MainAxisSize.max,
            children: [
              TextField(
                controller: _postController,
                decoration: const InputDecoration(
                  labelText: 'Write your post...',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_postController.text.isNotEmpty) {
                    _addPost(_postController.text);
                    _postController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Post'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommendations"),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularNotificationIcon(
              onIconPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InteractionPage(),
                  ),
                );
              },
              hasNotification: false,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Posts',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _openPostWindow,
                  ),
                ],
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: posts.length,
              itemBuilder: (context, postIndex) {
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => _addFriend(posts[postIndex]['user']),
                              child: const CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              posts[postIndex]['user'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(posts[postIndex]['content']),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    posts[postIndex]['likes'].contains('user')
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                  ),
                                  color:
                                  posts[postIndex]['likes'].contains('user')
                                      ? Colors.red
                                      : Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      if (posts[postIndex]['likes']
                                          .contains('user')) {
                                        posts[postIndex]['likes'].remove('user');
                                      } else {
                                        posts[postIndex]['likes'].add('user');
                                      }
                                    });
                                  },
                                ),
                                Text('${posts[postIndex]['likes'].length}'),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.mode_comment_outlined),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: _commentController,
                                            decoration: const InputDecoration(
                                              labelText: 'Write a comment...',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (_commentController
                                                  .text.isNotEmpty) {
                                                _addComment(postIndex,
                                                    _commentController.text);
                                                _commentController.clear();
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text('Post Comment'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            Text('${posts[postIndex]['comments'].length}'),
                          ],
                        ),
                        if (posts[postIndex]['comments'].isNotEmpty)
                          ...posts[postIndex]['comments']
                              .asMap()
                              .entries
                              .map((entry) {
                            int commentIndex = entry.key;
                            Map<String, dynamic> comment = entry.value;
                            return ListTile(
                              title: Text(comment['text']),
                              subtitle: Row(
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        _editComment(postIndex, commentIndex),
                                    child: const Text('Edit'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        _deleteComment(postIndex, commentIndex),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
