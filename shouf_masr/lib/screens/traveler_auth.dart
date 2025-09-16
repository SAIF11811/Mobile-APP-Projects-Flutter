import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/components.dart';

class TravelerAuth extends StatelessWidget {
  const TravelerAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcdcc00),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.network(
                'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/248cd0554d0da56d81aece5474bbcdfb9f21ec3a.png',
                width: 220,
                height: 80,
              ),
              const SizedBox(height: 80),

              // Login Button
              CustomElevatedButton(
                text: "Log in",
                onPressed: () => Get.toNamed('/traveler-login'),
                fullWidth: false,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                icon: Icons.login,
                iconRight: false,
              ),
              const SizedBox(height: 16),

              // Signup Button
              CustomElevatedButton(
                text: "Sign up",
                onPressed: () => Get.toNamed('/traveler-signup'),
                fullWidth: false,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                icon: Icons.app_registration,
                iconRight: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
