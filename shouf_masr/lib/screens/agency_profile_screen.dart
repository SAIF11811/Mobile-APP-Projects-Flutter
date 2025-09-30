import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared_preference.dart';
import '../widgets/agency_bottom_nav.dart';

class AgencyProfileController extends GetxController {
  RxString agencyName = 'EgyTrips Agency'.obs;
  RxString agencyEmail = 'egytrips@gmail.com'.obs;

  Future<void> logout() async {
    await SharedPreferenceHelper.setAgencyRememberMe(false);
    Get.offAllNamed('/role-selection');
  }

  void updateAgencyName(String newName) {
    if (newName.isNotEmpty) {
      agencyName.value = newName;
    }
  }
}

class AgencyProfileScreen extends StatelessWidget {
  AgencyProfileScreen({super.key});

  final AgencyProfileController controller = Get.put(
    AgencyProfileController(),
    permanent: true,
  );

  final RxInt currentIndex = 2.obs;

  void _showEditNameDialog(BuildContext context) {
    final nameController = TextEditingController(
      text: controller.agencyName.value,
    );

    Get.defaultDialog(
      title: "Edit Name",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Agency Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.updateAgencyName(nameController.text.trim());
              Get.back();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Text(
              "Terms of Service",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Introduction",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Welcome to Shouf Masr! By using this app, you agree to comply with the following terms and conditions.",
                      style: TextStyle(fontSize: 15),
                    ),
                    Divider(height: 30),

                    Text(
                      "1. Responsible Usage",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "You agree to use the app responsibly and provide accurate information at all times.",
                      style: TextStyle(fontSize: 15),
                    ),
                    Divider(height: 30),

                    Text(
                      "2. Agency Responsibilities",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Agencies must provide accurate trip details, prices, and schedules. Misleading information is strictly prohibited.",
                      style: TextStyle(fontSize: 15),
                    ),
                    Divider(height: 30),

                    Text(
                      "3. Limitation of Liability",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Shouf Masr is a platform and is not responsible for third-party services, cancellations, or disputes between travelers and agencies.",
                      style: TextStyle(fontSize: 15),
                    ),
                    Divider(height: 30),

                    Text(
                      "4. Updates to Terms",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "We may update these terms from time to time. Continued use of the app means you accept the updated terms.",
                      style: TextStyle(fontSize: 15),
                    ),
                    Divider(height: 30),

                    Text(
                      "5. Governing Law",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "These terms are governed by and construed in accordance with Egyptian law.",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Accept Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Accept"),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.defaultDialog(
                title: 'Log out',
                middleText: 'Are you sure you want to log out?',
                textCancel: 'Cancel',
                textConfirm: 'Log out',
                confirmTextColor: Colors.white,
                cancelTextColor: Colors.black,
                backgroundColor: Colors.white,
                onCancel: () => Get.back(),
                onConfirm: () async {
                  await controller.logout();
                  Get.back();
                },
              );
            },
            tooltip: 'Log out',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.business, size: 50),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                        () => Text(
                      controller.agencyName.value,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                        () => Text(
                      controller.agencyEmail.value,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 40),

            // Account Section
            const Text(
              'Account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Name'),
              onTap: () => _showEditNameDialog(context),
            ),
            const Divider(height: 32),

            // Preferences Section
            const Text(
              'Preferences',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: const Text('English'),
            ),
            const Divider(height: 32),

            // About Section
            const Text(
              'About',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('App Version'),
              subtitle: const Text('v3.0.0'),
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Terms of Service'),
              onTap: () => _showTermsDialog(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
            () => AgencyBottomNav(currentIndex: currentIndex.value),
      ),
    );
  }
}
