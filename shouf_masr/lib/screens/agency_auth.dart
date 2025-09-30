import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/components.dart';

class AgencyAuth extends StatelessWidget {
  const AgencyAuth({super.key});

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
              Image.asset(
                'assets/images/minilogo.png',
                width: 220,
                height: 80,
              ),
              const SizedBox(height: 80),

              // Login Button
              CustomElevatedButton(
                text: "Log in",
                onPressed: () => Get.toNamed('/agency-login'),
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
                onPressed: () => Get.toNamed('/agency-signup'),
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
