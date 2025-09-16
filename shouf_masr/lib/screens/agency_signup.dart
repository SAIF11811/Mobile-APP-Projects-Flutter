import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/components.dart';
import 'role_selection.dart';

class AgencySignup extends StatefulWidget {
  const AgencySignup({super.key});

  @override
  State<AgencySignup> createState() => _AgencySignupState();
}

class _AgencySignupState extends State<AgencySignup> {

  final companyController = TextEditingController();
  final licenseController = TextEditingController();
  final yearController = TextEditingController();
  final sizeController = TextEditingController();

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

                  const Text(
                    "Company Information",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Company Name
                  CustomTextField(
                    controller: companyController,
                    label: "Company Name",
                    hintText: "Enter company name",
                    prefixIcon: Icons.business,
                    validator: (value) =>
                    value == null || value.isEmpty
                        ? "Enter company name"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // License
                  CustomTextField(
                    controller: licenseController,
                    label: "Commercial License Number",
                    hintText: "Enter license number",
                    prefixIcon: Icons.assignment,
                    validator: (value) =>
                    value == null || value.isEmpty
                        ? "Enter license number"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Year
                  CustomTextField(
                    controller: yearController,
                    label: "Year of Establishment",
                    hintText: "Enter year",
                    prefixIcon: Icons.calendar_today,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                    value == null || value.isEmpty
                        ? "Enter year"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Size
                  CustomTextField(
                    controller: sizeController,
                    label: "Company Size",
                    hintText: "Enter company size",
                    prefixIcon: Icons.group,
                    validator: (value) =>
                    value == null || value.isEmpty
                        ? "Enter company size"
                        : null,
                  ),
                  const SizedBox(height: 30),

                  // Continue Button
                  Center(
                    child: CustomElevatedButton(
                      text: "Next",
                      onPressed: () {
                          Get.toNamed('/agency-contact');
                      },
                      fullWidth: false,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      icon: Icons.arrow_forward,
                      iconRight: true,
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
