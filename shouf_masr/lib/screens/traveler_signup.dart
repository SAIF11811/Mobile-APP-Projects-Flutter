import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/components.dart';
import 'traveler_login.dart';
import 'role_selection.dart';

class TravelerSignup extends StatefulWidget {
  const TravelerSignup({super.key});

  @override
  State<TravelerSignup> createState() => _TravelerSignupState();
}

class _TravelerSignupState extends State<TravelerSignup> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable system back
      child: Scaffold(
        backgroundColor: const Color(0xFFcdcc00),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Clickable Logo
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => const RoleSelection());
                    },
                    child: Image.network(
                      'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/248cd0554d0da56d81aece5474bbcdfb9f21ec3a.png',
                      width: 220,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Form fields
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name
                      CustomTextField(
                        controller: nameController,
                        label: "Full Name",
                        hintText: "Enter full name",
                        prefixIcon: Icons.person,
                        validator: (value) =>
                        value == null || value.isEmpty
                            ? "Enter your name"
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Email
                      CustomTextField(
                        controller: emailController,
                        label: "Email",
                        hintText: "Enter email",
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                        value != null && value.contains("@")
                            ? null
                            : "Invalid email",
                      ),
                      const SizedBox(height: 16),

                      // Password
                      CustomTextField(
                        controller: passwordController,
                        label: "Password",
                        hintText: "Enter password",
                        isPassword: true,
                        prefixIcon: Icons.lock,
                        validator: (value) =>
                        value != null && value.length >= 6
                            ? null
                            : "Min 6 characters",
                      ),
                      const SizedBox(height: 16),

                      // Confirm Password
                      CustomTextField(
                        controller: confirmPasswordController,
                        label: "Confirm Password",
                        hintText: "Re-enter password",
                        isPassword: true,
                        prefixIcon: Icons.lock_outline,
                        validator: (value) =>
                        value != passwordController.text
                            ? "Passwords do not match"
                            : null,
                      ),
                      const SizedBox(height: 24),

                      // Continue Button
                      Center(
                        child: CustomElevatedButton(
                          text: "Continue",
                          onPressed: () {
                            Get.toNamed('/search');
                          },
                          fullWidth: false,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          icon: Icons.arrow_forward,
                          iconRight: true,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Already have an account? Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const TravelerLogin());
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
