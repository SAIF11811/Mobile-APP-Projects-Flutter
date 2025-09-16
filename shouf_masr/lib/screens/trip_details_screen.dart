import 'package:flutter/material.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trip Details'), backgroundColor: const Color(0xFFcdcc00)),
      body: const Center(child: Text('Trip details content here')),
    );
  }
}
