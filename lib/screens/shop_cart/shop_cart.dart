import 'package:flutter/material.dart';
import 'package:shopping_mall/screens/shop_cart/order_page.dart';
// تأكد من تعديل import صفحة التبويب المفضلة لتقبل قائمة المنتجات المُفضلة
// إذا لم يكن ذلك موجودًا، يمكنك إنشاء FavoritesTab كما هو موضح أسفل الكود

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // بيانات المنتجات في الكارت
  List<int> quantities = [1, 1, 1]; // الكميات لكل منتج
  List<double> prices = [12000.0, 15000.0, 18000.0]; // الأسعار لكل منتج
  List<String> productImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHT4wlFIeFfriZP4yKzg4kKimLC244gV1I_we_iPfsj24q8LCXSbqtmDMVv_OFUPJr0T4&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHT4wlFIeFfriZP4yKzg4kKimLC244gV1I_we_iPfsj24q8LCXSbqtmDMVv_OFUPJr0T4&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHT4wlFIeFfriZP4yKzg4kKimLC244gV1I_we_iPfsj24q8LCXSbqtmDMVv_OFUPJr0T4&usqp=CAU',
  ];

  // قائمة لتخزين المنتجات المُفضلة
  List<Map<String, dynamic>> favoriteItems = [];

  double calculateTotal() {
    double total = 0.0;
    for (int i = 0; i < prices.length; i++) {
      total += quantities[i] * prices[i];
    }
    return total;
  }

  // دالة مساعدة لترتيب بيانات المنتج في كائن Map
  Map<String, dynamic> getProduct(int index) {
    return {
      'name': 'Product ${index + 1}',
      'price': prices[index],
      'quantity': quantities[index],
      'imageUrl': productImages[index],
    };
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        elevation: 2,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Cart'),
            // نقوم الآن بتمرير قائمة المنتجات المُفضلة إلى تبويب المفضلة
            Tab(text: 'Favorites'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // تبويب الكارت
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: prices.length,
                  itemBuilder: (context, index) {
                    final product = getProduct(index);
                    // تحقق إذا كان المنتج موجود في القائمة المُفضلة
                    bool isFavorite = favoriteItems.any(
                            (element) => element['name'] == product['name']);
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.network(
                          product['imageUrl'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product['name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Price: ${product['price']} won'),
                            Text('Quantity: ${quantities[index]}'),
                          ],
                        ),
                        // نجمع هنا عدة أزرار: التقليل، الزيادة وزر المفضلة
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (quantities[index] > 1) {
                                    quantities[index]--;
                                  }
                                });
                              },
                            ),
                            Text('${quantities[index]}'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  quantities[index]++;
                                });
                              },
                            ),
                            IconButton(
                              // أيقونة المفضلة تظهر مُعبّأة إذا كان المنتج مُفضّل
                              icon: isFavorite
                                  ? Icon(Icons.favorite, color: Colors.red)
                                  : Icon(Icons.favorite_border),
                              onPressed: () {
                                setState(() {
                                  if (isFavorite) {
                                    favoriteItems.removeWhere((element) =>
                                    element['name'] == product['name']);
                                  } else {
                                    favoriteItems.add(product);
                                  }
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border(top: BorderSide(color: Colors.grey)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: ${calculateTotal()} won',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // هنا يتم التنقل إلى صفحة الطلبات الحالية (PlaceOrderPage)
                        // مثال توضيحي لإنشاء كائن OrderDetails والانتقال لصفحة الطلب
                        OrderDetails orderDetails = OrderDetails(
                          deliveryAddress: "123 Main St, City",
                          deliveryInstructions: "In front of the door",
                          payment: "Naver Pay (Quick Payment)",
                          cashReceipt: "Cash Receipt Information",
                          items: [
                            OrderItemModel(
                              productName: "Dark Chocolates",
                              option: "Option: 3 pieces",
                              quantity: "Quantity: 2 pieces",
                              price: "24,000 KRW",
                            ),
                            OrderItemModel(
                              productName: "Milk Chocolates",
                              option: "Option: 1 piece",
                              quantity: "Quantity: 1 piece",
                              price: "4,000 KRW",
                            ),
                            OrderItemModel(
                              productName: "White Chocolates",
                              option: "Option: 2 pieces",
                              quantity: "Quantity: 2 pieces",
                              price: "16,000 KRW",
                            ),
                          ],
                          total: "44,000 KRW",
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlaceOrderScreen(),
                          ),
                        );
                      },
                      child: const Text('Order Now'),
                    )
                  ],
                ),
              ),
            ],
          ),
          // تبويب المفضلات
          FavoritesTab(favorites: favoriteItems),
        ],
      ),
    );
  }
}

// هنا مثال مبسط على FavoritesTab لعرض المنتجات المُفضلة
class FavoritesTab extends StatelessWidget {
  final List<Map<String, dynamic>> favorites;

  const FavoritesTab({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return Center(child: Text('No favorites added'));
    }
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final product = favorites[index];
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: Image.network(
              product['imageUrl'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product['name']),
            subtitle: Text('Price: ${product['price']} won'),
          ),
        );
      },
    );
  }
}

// نماذج افتراضية من أجل صفحة الطلبات (PlaceOrderPage) ونماذج الأوامر
// يمكنك تعديلها حسب هيكل مشروعك

class OrderDetails {
  final String deliveryAddress;
  final String deliveryInstructions;
  final String payment;
  final String cashReceipt;
  final List<OrderItemModel> items;
  final String total;

  OrderDetails({
    required this.deliveryAddress,
    required this.deliveryInstructions,
    required this.payment,
    required this.cashReceipt,
    required this.items,
    required this.total,
  });
}

class OrderItemModel {
  final String productName;
  final String option;
  final String quantity;
  final String price;

  OrderItemModel({
    required this.productName,
    required this.option,
    required this.quantity,
    required this.price,
  });
}

