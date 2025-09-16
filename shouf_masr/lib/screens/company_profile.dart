import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyProfileScreen extends StatelessWidget {
  const CompanyProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Company Profile'), backgroundColor: const Color(0xFFcdcc00)),
      body: const Center(child: Text('Company profile content')),
    );
  }
}
