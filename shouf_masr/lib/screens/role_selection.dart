import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/components.dart';

class RoleSelection extends StatelessWidget {
  const RoleSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcdcc00),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.network(
              'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/248cd0554d0da56d81aece5474bbcdfb9f21ec3a.png',
              width: 220,
              height: 70,
            ),
            const SizedBox(height: 60),

            // Title
            const Text(
              'Choose your role',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),

            // Role Buttons using CustomElevatedButton
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  text: "Traveler",
                  onPressed: () => Get.toNamed('/traveler-auth'),
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fullWidth: false,
                  icon: Icons.person,
                  iconRight: false,
                ),
                const SizedBox(width: 20),
                CustomElevatedButton(
                  text: "Agency",
                  onPressed: () => Get.toNamed('/agency-signup'),
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  fullWidth: false,
                  icon: Icons.business,
                  iconRight: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
