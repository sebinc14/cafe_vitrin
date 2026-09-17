import 'package:flutter/material.dart';
import 'package:cafe_vitrin/cafe_vitrin.dart';

void main() {
  runApp(const CafeVitrinExample());
}

/// Example app for Cafe Vitrin Widgets
class CafeVitrinExample extends StatelessWidget {
  /// Constructor for Example App
  const CafeVitrinExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe Vitrin Example',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: Scaffold(
        appBar: AppBar(title: const Text('Cafe Vitrin Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              AnimatedRatingModal.show(
                context,
                "Order-123",
                [
                  {"name": "Filter Coffee"},
                ],
                onSubmit: (rating, comment) {
                  debugPrint("Rating: $rating, Comment: $comment");
                },
              );
            },
            child: const Text('Değerlendir'),
          ),
        ),
      ),
    );
  }
}
