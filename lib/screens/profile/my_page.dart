import 'package:flutter/material.dart';
import 'package:shopping_mall/screens/profile/CancelMember.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() =>
      _MyPageState();
}

class _MyPageState extends State<MyPage> {
  // Controllers for input fields
  final TextEditingController _nicknameController =
  TextEditingController(text: 'pang2chocolate');
  final TextEditingController _userIdController =
  TextEditingController(text: '+82 10-XXXX-XXXX');
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _nicknameController.dispose();
    _userIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Action for the "Complete" button
  void _completeAction() {
    final nickname = _nicknameController.text;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Account details sent for $nickname'),
        duration: const Duration(seconds: 3),
      ),
    );
  }


  // Action to open the Customer Help Center
  void _openCustomerHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening Customer Help Center'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Custom InputDecoration for consistency across fields
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Color(0xFF6200EE), width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Nickname TextField
            TextField(
              controller: _nicknameController,
              decoration: _inputDecoration('Nickname'),
            ),
            const SizedBox(height: 16),
            // User ID TextField
            TextField(
              controller: _userIdController,
              decoration: _inputDecoration('User ID'),
            ),
            const SizedBox(height: 16),
            // Password TextField with visibility toggle
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: _inputDecoration('Password').copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            // "Complete" button
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: _completeAction,
                child: const Text(
                  'Complete',
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Conditional display for membership cancellation
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>CancelSubscriptionScreen()
                          ));

                    },
                    child: const Text(
                      'Cancel Membership Subscription',
                      style: TextStyle(fontSize: 18,color: Colors.black),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            // Customer Help Center button
            Center(
              child:SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _openCustomerHelp,
                  child: const Text(
                    'Customer Help Center',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
