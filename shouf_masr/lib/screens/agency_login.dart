import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared_preference.dart';
import '../widgets/components.dart';
import 'role_selection.dart';
import 'agency_signup.dart';
import 'agency_notifications_screen.dart';

class AgencyLogin extends StatefulWidget {
  const AgencyLogin({super.key});

  @override
  State<AgencyLogin> createState() => _AgencyLoginState();
}

class _AgencyLoginState extends State<AgencyLogin> {
  final _formKey = GlobalKey<FormState>();
  final companyController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedLogin();
  }

  void _loadSavedLogin() async {
    final remember = await SharedPreferenceHelper.getAgencyRememberMe();
    if (remember) {
      final company = await SharedPreferenceHelper.getCompany();
      final email = await SharedPreferenceHelper.getEmail();
      final password = await SharedPreferenceHelper.getPassword();

      setState(() {
        _rememberMe = true;
        if (company != null) companyController.text = company;
        if (email != null) emailController.text = email;
        if (password != null) passwordController.text = password;
      });
    }
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final company = companyController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (company == "EgyTrips" &&
          email == "egytrips@gmail.com" &&
          password == "egy123") {
        await SharedPreferenceHelper.setAgencyRememberMe(
          _rememberMe,
          company: company,
          email: email,
          password: password,
        );
        Get.offAll(() => AgencyNotificationsScreen());
      } else {
        Get.snackbar(
          "Login Failed",
          "Invalid company name, email or password",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(12),
        );
      }
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
                      children: [
                        CustomTextField(
                          controller: companyController,
                          label: "Company Name",
                          hintText: "Enter company name",
                          prefixIcon: Icons.business,
                          validator: (val) =>
                          val != null && val.isNotEmpty
                              ? null
                              : "Enter company name",
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: emailController,
                          label: "Email",
                          hintText: "Enter email address",
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>
                          val != null && val.contains("@")
                              ? null
                              : "Invalid email",
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: passwordController,
                          label: "Password",
                          hintText: "Enter password",
                          isPassword: true,
                          prefixIcon: Icons.lock,
                          validator: (val) =>
                          val != null && val.length >= 3
                              ? null
                              : "Min 3 characters",
                        ),
                        const SizedBox(height: 12),
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
                            text: "Log In",
                            onPressed: _login,
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
                              "Don’t have an account?",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Get.to(() => const AgencySignup()),
                              child: const Text(
                                "Sign Up",
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
