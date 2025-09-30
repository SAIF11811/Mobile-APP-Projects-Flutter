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
  final _formKey = GlobalKey<FormState>();
  final companyController = TextEditingController();
  final licenseController = TextEditingController();
  final yearController = TextEditingController();
  final sizeController = TextEditingController();

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      Get.toNamed('/agency-contact');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.05;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFFcdcc00),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
              child: Column(
                children: [
                  // Logo
                  GestureDetector(
                    onTap: () => Get.offAll(() => const RoleSelection()),
                    child: SizedBox(
                      width: size.width * 0.5,
                      height: size.height * 0.1,
                      child: Image.asset(
                        'assets/images/minilogo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),

                  const Text(
                    "Company Information",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: companyController,
                          label: "Company Name",
                          hintText: "Enter company name",
                          prefixIcon: Icons.business,
                          validator: (val) => val == null || val.isEmpty ? "Enter company name" : null,
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextField(
                          controller: licenseController,
                          label: "Commercial License Number",
                          hintText: "Enter license number",
                          prefixIcon: Icons.assignment,
                          validator: (val) => val == null || val.isEmpty ? "Enter license number" : null,
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextField(
                          controller: yearController,
                          label: "Year of Establishment",
                          hintText: "Enter year",
                          prefixIcon: Icons.calendar_today,
                          keyboardType: TextInputType.number,
                          validator: (val) => val == null || val.isEmpty ? "Enter year" : null,
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextField(
                          controller: sizeController,
                          label: "Company Size",
                          hintText: "Enter company size",
                          prefixIcon: Icons.group,
                          validator: (val) => val == null || val.isEmpty ? "Enter company size" : null,
                        ),
                        SizedBox(height: size.height * 0.04),

                        CustomElevatedButton(
                          text: "Next",
                          onPressed: _nextStep,
                          fullWidth: true,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          icon: Icons.arrow_forward,
                          iconRight: true,
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
