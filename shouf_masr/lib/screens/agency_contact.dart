import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/components.dart';
import 'role_selection.dart';

class AgencyContact extends StatefulWidget {
  const AgencyContact({super.key});

  @override
  State<AgencyContact> createState() => _AgencyContactState();
}

class _AgencyContactState extends State<AgencyContact> {
  final _formKey = GlobalKey<FormState>();

  final contactName = TextEditingController();
  final password = TextEditingController();
  final position = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _tradeLicense;
  File? _companyLogo;
  File? _samplePackage;

  Future<void> _pickImage(Function(File) onPicked) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) onPicked(File(pickedFile.path));
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void _signup() {
    if (_formKey.currentState!.validate()) {
      Get.toNamed('/wait');
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
                    "Contact Details",
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
                        _buildTextField(contactName, "Contact Person Name", "Enter contact name", Icons.person),
                        SizedBox(height: size.height * 0.02),
                        _buildTextField(password, "Password", "Enter password", Icons.lock, isPassword: true),
                        SizedBox(height: size.height * 0.02),
                        _buildTextField(position, "Position/Role", "Enter position", Icons.work),
                        SizedBox(height: size.height * 0.02),
                        _buildTextField(phone, "Phone Number", "Enter phone number", Icons.phone, keyboardType: TextInputType.phone),
                        SizedBox(height: size.height * 0.02),
                        _buildTextField(address, "Company Address", "Enter address", Icons.location_on),
                        SizedBox(height: size.height * 0.03),

                        _buildUploadField(size, "Trade License", _tradeLicense, (file) => setState(() => _tradeLicense = file)),
                        SizedBox(height: size.height * 0.02),
                        _buildUploadField(size, "Company Logo", _companyLogo, (file) => setState(() => _companyLogo = file)),
                        SizedBox(height: size.height * 0.02),
                        _buildUploadField(size, "Sample Package PDF", _samplePackage, (file) => setState(() => _samplePackage = file)),
                        SizedBox(height: size.height * 0.04),

                        Row(
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                text: "Back",
                                onPressed: () => Get.back(),
                                fullWidth: true,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                icon: Icons.arrow_back,
                                iconRight: false,
                              ),
                            ),
                            SizedBox(width: size.width * 0.05),
                            Expanded(
                              child: CustomElevatedButton(
                                text: "Sign Up",
                                onPressed: _signup,
                                fullWidth: true,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                icon: Icons.check,
                                iconRight: true,
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

  Widget _buildTextField(TextEditingController controller, String label, String hint, IconData icon,
      {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return CustomTextField(
      controller: controller,
      label: label,
      hintText: hint,
      prefixIcon: icon,
      isPassword: isPassword,
      keyboardType: keyboardType,
      validator: (val) => val == null || val.isEmpty ? "Enter $label" : null,
    );
  }

  Widget _buildUploadField(Size size, String label, File? selectedFile, Function(File) onPicked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label *", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
        SizedBox(height: size.height * 0.01),
        Container(
          height: size.height * 0.07,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Text(selectedFile != null ? "File selected" : "No file chosen",
                    style: const TextStyle(color: Colors.black54, fontSize: 16)),
              ),
              Row(
                children: [
                  if (selectedFile != null)
                    SizedBox(
                      height: size.height * 0.06,
                      width: size.height * 0.06,
                      child: Image.file(selectedFile, fit: BoxFit.cover),
                    ),
                  IconButton(
                    onPressed: () => _pickImage(onPicked),
                    icon: const Icon(Icons.attach_file, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
