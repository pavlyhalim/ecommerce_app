import 'package:flutter/material.dart';


class CancelSubscriptionScreen extends StatefulWidget {
  const CancelSubscriptionScreen({Key? key}) : super(key: key);

  @override
  _CancelSubscriptionScreenState createState() =>
      _CancelSubscriptionScreenState();
}

class _CancelSubscriptionScreenState extends State<CancelSubscriptionScreen> {
  String? selectedReason;

  void _cancelSubscription() {
    if (selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a reason for cancellation'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Subscription cancelled for reason: $selectedReason'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancel Subscription'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tell us why you are leaving',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...[
              'Expensive subscription fee',
              'Reduced shopping time',
              'Cannot find items I’m looking for',
              'Others',
            ].map((reason) {
              return RadioListTile<String>(
                title: Text(reason),
                value: reason,
                groupValue: selectedReason,
                onChanged: (value) {
                  setState(() {
                    selectedReason = value;
                  });
                },
              );
            }),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _cancelSubscription,
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text(
                  'Cancel Subscription',
                  style: TextStyle(fontSize: 16,color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
