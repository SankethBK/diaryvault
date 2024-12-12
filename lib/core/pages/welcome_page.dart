import 'dart:math';

import 'package:dairy_app/core/data/quotes.dart';
import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  static String get route => '/';

  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late String quote;

  @override
  void initState() {
    super.initState();
    // Initialize the quote
    quote = getQuote();

    // Add a delay to navigate after displaying the quote
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushNamed(AuthPage.route);
    });
  }

  String getQuote() {
    const quotes = Quotes.quotes;
    final random = Random();
    return quotes[random.nextInt(quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9E8BD9), // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Application logo
            SizedBox(
              width: 150,
              height: 150,
              child: ClipOval(
                // Crop image in oval shape to match homepage logo
                child: Transform.scale(
                  scale: 1.5, // Increase the scale to crop more from the image
                  child: Image.asset(
                    'assets/images/splash_icon_4.webp',
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        'Error loading image',
                        style: TextStyle(color: Colors.red),
                      );
                    },
                    fit: BoxFit
                        .cover, // Ensures the image fills the circular frame
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Display the random quote
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                quote,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
