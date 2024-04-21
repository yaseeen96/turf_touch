import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turf_touch/src/config/theme/theme_state.dart';

class OrderFailureScreen extends StatelessWidget {
  const OrderFailureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CTheme.of(context).theme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 100,
              color: CTheme.of(context)
                  .theme
                  .primaryColor, // Branding color for the error icon
            ),
            const SizedBox(height: 20), // Space between icon and text
            Text(
              'Order Failed',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: CTheme.of(context)
                    .theme
                    .primaryColor, // Branding color for the text
              ),
            ),
            const SizedBox(height: 10), // Space between text and subtext
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Something went wrong with your order. Please try again later.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: CTheme.of(context)
                      .theme
                      .backgroundInverse, // Subtext color
                ),
              ),
            ),
            const SizedBox(height: 30), // Space between subtext and button
            ElevatedButton(
              onPressed: () {
                context.go(
                    "/home"); // Assuming popping this screen will navigate back to home
              },
              style: CTheme.of(context).theme.buttonStyle,
              child: const Text(
                'Back to Home',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
