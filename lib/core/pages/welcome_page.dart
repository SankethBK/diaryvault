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
final List<String> quotes = [
  "The best way to predict the future is to create it.",
  "Success is not final, failure is not fatal: It is the courage to continue that counts.",
  "Believe you can and you're halfway there.",
  "The only way to do great work is to love what you do.",
  "It does not matter how slowly you go as long as you do not stop."
];


@override
void initState() {
  super.initState();
  // Initialize the quote
   quote = getQuote();


  // Add a delay to navigate after displaying the quote
  Future.delayed(const Duration(seconds: 2), () {
     Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => const HomePage()), // Navigate to homepage next
       );
  });
}


String getQuote() {
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
         /*  Image.asset(
            'assets/images/splash_icon_4.webp',
            errorBuilder: (context, error, stackTrace) {
              return const Text(
                'Error loading image',
                style: TextStyle(color: Colors.red),
              );
            },
          ), */
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
