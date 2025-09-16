import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/components.dart';
import 'role_selection.dart';

class AgencyContact extends StatefulWidget {
  const AgencyContact({super.key});

  @override
  State<AgencyContact> createState() => _AgencyContactState();
}

class _AgencyContactState extends State<AgencyContact> {

  final contactName = TextEditingController();
  final password = TextEditingController();
  final position = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

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
                    "Contact Details",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Contact Name
                  CustomTextField(
                    controller: contactName,
                    label: "Contact Person Name",
                    hintText: "Enter contact name",
                    prefixIcon: Icons.person,
                    validator: (value) =>
                    value == null || value.isEmpty
                        ? "Enter contact name"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Password
                  CustomTextField(
                    controller: password,
                    label: "Password",
                    hintText: "Enter password",
                    isPassword: true,
                    prefixIcon: Icons.lock,
                    validator: (value) =>
                    value == null || value.length < 6
                        ? "Min 6 characters"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Position
                  CustomTextField(
                    controller: position,
                    label: "Position/Role",
                    hintText: "Enter position",
                    prefixIcon: Icons.work,
                    validator: (value) =>
                    value == null || value.isEmpty
                        ? "Enter position"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Phone
                  CustomTextField(
                    controller: phone,
                    label: "Phone Number",
                    hintText: "Enter phone number",
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                    value == null || value.isEmpty
                        ? "Enter phone number"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Address
                  CustomTextField(
                    controller: address,
                    label: "Company Address",
                    hintText: "Enter address",
                    prefixIcon: Icons.location_on,
                    validator: (value) =>
                    value == null || value.isEmpty
                        ? "Enter company address"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // File Uploads styled like text fields
                  _buildUploadField("Trade License"),
                  const SizedBox(height: 16),
                  _buildUploadField("Company Logo"),
                  const SizedBox(height: 16),
                  _buildUploadField("Sample Package PDF"),
                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Back button
                      CustomElevatedButton(
                        text: "Back",
                        onPressed: () => Get.back(),
                        fullWidth: false,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        icon: Icons.arrow_back,
                        iconRight: false,
                      ),

                      const SizedBox(width: 160),

                      // Sign up button
                      CustomElevatedButton(
                        text: "Sign Up",
                        onPressed: () {
                            Get.toNamed('/requests');
                        },
                        fullWidth: false,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        icon: Icons.check,
                        iconRight: true,
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

  Widget _buildUploadField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label *",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "No file chosen",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  // TODO: Implement file picker
                },
                icon: const Icon(Icons.attach_file, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
