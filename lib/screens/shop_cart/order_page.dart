import 'package:flutter/material.dart';
import 'package:shopping_mall/screens/shop_cart/OrderCompleteScreen.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  // تعريف المتحكمات لكل حقل من حقول الإدخال
  late TextEditingController addressController;
  late TextEditingController instructionsController;
  late TextEditingController paymentController;
  late TextEditingController cashReceiptController;
  late TextEditingController totalController;
  // نستخدم List من المتحكمات لعناصر الطلب
  late List<TextEditingController> orderItemControllers;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController(text: "Default Address:");
    instructionsController = TextEditingController(text: "In front of the door");
    paymentController = TextEditingController(text: "Naver Pay (Quick Payment)");
    cashReceiptController = TextEditingController(text: "Cash Receipt Information");
    totalController = TextEditingController(text: "Total: 44,000 KRW");

    // ثلاثة عناصر افتراضية ضمن تفاصيل الطلب
    orderItemControllers = [
      TextEditingController(
          text: "Dark Chocolates / option: 3 pieces / Quantity: 2 pieces 24,000 KRW"),
      TextEditingController(
          text: "Dark Chocolates / option: 1 piece / Quantity: 1 piece 4,000 KRW"),
      TextEditingController(
          text: "Dark Chocolates / option: 2 pieces / Quantity: 2 pieces 16,000 KRW"),
    ];
  }

  @override
  void dispose() {
    addressController.dispose();
    instructionsController.dispose();
    paymentController.dispose();
    cashReceiptController.dispose();
    totalController.dispose();
    for (var controller in orderItemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place Order"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان التوصيل
            const Text(
              "Delivery Address",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Delivery Address",
              ),
            ),
            const SizedBox(height: 16),
            // تعليمات التوصيل
            const Text(
              "Delivery Instructions",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: instructionsController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Instructions",
              ),
            ),
            const SizedBox(height: 16),
            // طريقة الدفع
            const Text(
              "Payment",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: paymentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Payment Method",
              ),
            ),
            const SizedBox(height: 16),
            // معلومات الاستلام النقدي
            const Text(
              "Cash Receipt",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: cashReceiptController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Cash Receipt Information",
              ),
            ),
            const SizedBox(height: 16),
            // تفاصيل الطلب
            const Text(
              "Order Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            // استخدام ListView.builder داخل SingleChildScrollView
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: orderItemControllers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextField(
                    controller: orderItemControllers[index],
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Order Item ${index + 1}",
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            // إجمالي السعر
            const Text(
              "Total",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: totalController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Total",
              ),
            ),
            const SizedBox(height: 16),
            // زر Place Order
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: double.infinity,
          height: 50, // ارتفاع أنيق للزر
          child: ElevatedButton(
            onPressed: () {
              // طباعة القيم أو أي أكشن آخر
              print("Delivery Address: ${addressController.text}");
              print("Delivery Instructions: ${instructionsController.text}");
              print("Payment: ${paymentController.text}");
              print("Cash Receipt: ${cashReceiptController.text}");
              for (var controller in orderItemControllers) {
                print("Order Item: ${controller.text}");
              }
              print("Total: ${totalController.text}");

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderCompleteScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,  // لون الزر أبيض
              foregroundColor: Colors.white,  // لون النص أسود
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Place Order",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),

    );
  }
}
