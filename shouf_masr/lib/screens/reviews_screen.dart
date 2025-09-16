import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reviews'), backgroundColor: const Color(0xFFcdcc00)),
      body: const Center(child: Text('Reviews list here')),
    );
  }
}
