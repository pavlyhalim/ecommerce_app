import 'package:flutter/material.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late List<Post> posts;

  @override
  void initState() {
    super.initState();
    posts = [
      // المنشور الأول بدون منتجات
      Post(
        id: '1',
        userName: 'pang2chocolate',
        userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqg5cwEEGmR3J8Z-aha6ndTY7LyoC-E93-FORojKEhqslFRT6XJYrnwRnxhZmc30JY2Xk&usqp=CAU',
        content: 'Testing',
        likes: 16,
        comments: 36,
      ),
      // المنشور الثاني يحتوي على قائمة منتجات
      Post(
        id: '2',
        userName: 'hayan_sool',
        userImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqg5cwEEGmR3J8Z-aha6ndTY7LyoC-E93-FORojKEhqslFRT6XJYrnwRnxhZmc30JY2Xk&usqp=CAU',
        content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi interdum tincidunt nisi, sed euismod nibh viverra eu. Phasellus hendrerit et libero vitae malesuada.',
        likes: 16,
        comments: 36,
        products: [
          Product(
            id: 'p1',
            imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwflYNIEMP6Ilq0CwgHPzBip2HFR9PTqDW-Q&s',
            name: '다크 초콜릿 아이스크림 6개입',
            price: '12,000원',
            rating: 7.0,
          ),
          Product(
            id: 'p2',
            imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQnMDYr58ysmzQqwdkdqwrDs4ApjK54vb42w&s',
            name: '대형 도마배 초콜릿 1개',
            price: '16,000원',
            rating: 7.0,
          ),
          Product(
            id: 'p3',
            imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwflYNIEMP6Ilq0CwgHPzBip2HFR9PTqDW-Q&s',
            name: '미니 도마배 초콜릿 10개입',
            price: '15,000원',
            rating: 7.0,
          ),
          Product(
            id: 'p4',
            imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQnMDYr58ysmzQqwdkdqwrDs4ApjK54vb42w&s',
            name: '화이트 마시멜로 5kg',
            price: '38,000원',
            rating: 7.0,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(post: posts[index]);
      },
    );
  }
}

/// نموذج بيانات المنشور
class Post {
  final String id;
  final String userName;
  final String userImageUrl;
  final String content;
  int likes;
  int comments;
  final List<Product>? products;

  Post({
    required this.id,
    required this.userName,
    required this.userImageUrl,
    required this.content,
    this.likes = 0,
    this.comments = 0,
    this.products,
  });
}

/// نموذج بيانات المنتج
class Product {
  final String id;
  final String imageUrl;
  final String name;
  final String price;
  final double rating;

  Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
  });
}

/// Widget عرض المنشور بشكل بطاقة تفاعلية مع صورة المستخدم
class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  // حالات تحديد التفاعل: إعجاب وتعليق
  bool hasLiked = false;
  bool hasCommented = false;
  bool showCommentField = false;
  final TextEditingController _commentController = TextEditingController();

  // التعامل مع زر الإعجاب: يمكن النقر لإضافة الإعجاب أو إزالته
  void _handleLike() {
    setState(() {
      if (hasLiked) {
        widget.post.likes = widget.post.likes > 0 ? widget.post.likes - 1 : 0;
        hasLiked = false;
      } else {
        widget.post.likes++;
        hasLiked = true;
      }
    });
  }

  // التعامل مع زر التعليق: إذا كان المستخدم قد علق مسبقًا يتم إزالة التعليق، وإلا يعرض حقل الإدخال
  void _toggleComment() {
    setState(() {
      if (hasCommented) {
        widget.post.comments = widget.post.comments > 0 ? widget.post.comments - 1 : 0;
        hasCommented = false;
      } else {
        showCommentField = !showCommentField;
      }
    });
  }

  // عند نشر التعليق يتم تحديث عدد التعليقات
  void _submitComment() {
    final commentText = _commentController.text.trim();
    if (commentText.isNotEmpty) {
      setState(() {
        widget.post.comments++;
        hasCommented = true;
        showCommentField = false;
      });
      _commentController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إضافة التعليق')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // رأس المنشور: صورة المستخدم واسم المستخدم
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.post.userImageUrl),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.post.userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // محتوى المنشور
            Text(widget.post.content),
            const SizedBox(height: 10),
            // قائمة المنتجات (إن وجدت)
            if (widget.post.products != null)
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.post.products!.length,
                  itemBuilder: (context, index) {
                    final product = widget.post.products![index];
                    return ProductCard(product: product);
                  },
                ),
              ),
            const SizedBox(height: 10),
            // صف التفاعلات: زر إعجاب وتعليق
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: _handleLike,
                  icon: Icon(
                    Icons.favorite_outlined,
                    color: hasLiked ? Colors.red : Colors.grey[500],
                  ),
                  label: Text('${widget.post.likes}'),
                ),
                TextButton.icon(
                  onPressed: _toggleComment,
                  icon: Icon(
                    Icons.mode_comment_outlined,
                    color: hasCommented ? Colors.grey[800] : Colors.grey[400],
                  ),
                  label: Text('${widget.post.comments}'),
                ),
              ],
            ),
            // حقل إدخال التعليق عند التفعيل
            if (showCommentField)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          hintText: 'اكتب تعليق...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _submitComment,
                      child: const Text('نشر'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Widget عرض بيانات المنتج داخل قائمة أفقية
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // عند الضغط على المنتج، عرض SnackBar مع اسم المنتج
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selected: ${product.name}")),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 8),
        child: Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة المنتج
              Image.network(
                product.imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  product.price,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text('${product.rating}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}