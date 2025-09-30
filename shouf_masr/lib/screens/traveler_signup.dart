import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared_preference.dart';
import '../widgets/components.dart';
import 'traveler_login.dart';
import 'role_selection.dart';

class TravelerSignup extends StatefulWidget {
  const TravelerSignup({super.key});

  @override
  State<TravelerSignup> createState() => _TravelerSignupState();
}

class _TravelerSignupState extends State<TravelerSignup> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedLogin();
  }

  void _loadSavedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? remember = prefs.getBool('remember_me') ?? false;
    if (remember) {
      setState(() => _rememberMe = true);
    }
  }

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      await SharedPreferenceHelper.setTravelerRememberMe(_rememberMe);
      Get.offAllNamed('/wait');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFFcdcc00),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Get.offAll(() => const RoleSelection()),
                    child: Image.asset(
                      'assets/images/minilogo.png',
                      width: 220,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 30),

                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: nameController,
                          label: "Full Name",
                          hintText: "Enter full name",
                          prefixIcon: Icons.person,
                          validator: (value) =>
                          value == null || value.isEmpty
                              ? "Enter your full name"
                              : null,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: emailController,
                          label: "Email",
                          hintText: "Enter email",
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email required";
                            }
                            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value)) {
                              return "Invalid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                              activeColor: Colors.blue,
                            ),
                            const Text(
                              "Remember me",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: CustomElevatedButton(
                            text: "Sign Up",
                            onPressed: _signup,
                            fullWidth: false,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            icon: Icons.arrow_forward,
                            iconRight: true,
                          ),
                        ),
                        const SizedBox(height: 20),
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
                              onPressed: () => Get.to(() => const TravelerLogin()),
                              child: const Text(
                                "Log In",
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
