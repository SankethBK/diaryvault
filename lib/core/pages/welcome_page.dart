import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'home_page.dart';

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

    Timer(const Duration(seconds: 20), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  // Function to get a random quote
  String getQuote() {
    final quotes = [
      "The best time to plant a tree was 20 years ago. The second best time is now.",
      "Your limitation—it’s only your imagination.",
      "Push yourself, because no one else is going to do it for you.",
      "Great things never come from comfort zones.",
      "Dream it. Wish it. Do it."
    ];
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
            Image.asset(
              'assets/images/splash_icon_4.webp',
              errorBuilder: (context, error, stackTrace) {
                return const Text(
                  'Error loading image',
                  style: TextStyle(color: Colors.red),
                );
              },
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
