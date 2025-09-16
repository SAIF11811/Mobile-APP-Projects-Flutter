import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.photo_camera, size:80, color: Colors.amber),
              const SizedBox(height:12),
              const Text('Page Not Found', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height:12),
              const Padding(padding: EdgeInsets.symmetric(horizontal:24.0), child: Text('The moment you\'s looking for seems to have been lost in the shadows.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFCCCCCC)))),
              const SizedBox(height:20),
              ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: ()=>Get.offAllNamed('/'), child: const Text('Return Home', style: TextStyle(color: Color(0xFF0a0a0a), fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }
}
