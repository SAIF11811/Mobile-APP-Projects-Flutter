import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared_preference.dart';
import '../widgets/traveler_bottom_nav.dart';

class TravelerSettingsController extends GetxController {
  RxString travelerName = 'Ahmed'.obs;
  RxString travelerEmail = 'ahmed@gmail.com'.obs;
  RxString travelerLanguage = 'English'.obs;

  Future<void> logout() async {
    await SharedPreferenceHelper.setTravelerRememberMe(false);
    Get.offAllNamed('/role-selection');
  }

  void updateTravelerName(String newName) {
    if (newName.isNotEmpty) {
      travelerName.value = newName;
    }
  }
}

class TravelerSettingsScreen extends StatelessWidget {
  TravelerSettingsScreen({super.key});

  final TravelerSettingsController controller = Get.put(
    TravelerSettingsController(),
    permanent: true,
  );

  final RxInt currentIndex = 4.obs;

  void _showEditNameDialog(BuildContext context) {
    final nameController = TextEditingController(
      text: controller.travelerName.value,
    );

    Get.defaultDialog(
      title: "Edit Name",
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Traveler Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.updateTravelerName(nameController.text.trim());
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
            // Handle bar
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
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Introduction",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(
                      "Welcome to Shouf Masr! By using this app, you agree to comply with the following terms and conditions.",
                      style: TextStyle(fontSize: 15),
                    ),
                    Divider(height: 30),

                    Text("1. Responsible Usage",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(
                      "Travelers must provide accurate booking details and respect agency rules.",
                      style: TextStyle(fontSize: 15),
                    ),
                    Divider(height: 30),

                    Text("2. Traveler Responsibilities",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(
                      "You must comply with local laws, pay for confirmed bookings, and avoid fraudulent activity.",
                      style: TextStyle(fontSize: 15),
                    ),
                    Divider(height: 30),

                    Text("3. Limitation of Liability",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(
                      "Shouf Masr is a platform and is not responsible for third-party services, cancellations, or disputes between travelers and agencies.",
                      style: TextStyle(fontSize: 15),
                    ),
                    Divider(height: 30),

                    Text("4. Updates to Terms",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(
                      "We may update these terms from time to time. Continued use of the app means you accept the updated terms.",
                      style: TextStyle(fontSize: 15),
                    ),
                    Divider(height: 30),

                    Text("5. Governing Law",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
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
            Center(
              child: ElevatedButton(
                onPressed: () => Get.back(),
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
                    child: Icon(Icons.person, size: 50),
                  ),
                  const SizedBox(height: 12),
                  Obx(() => Text(
                    controller.travelerName.value,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                  Obx(() => Text(
                    controller.travelerEmail.value,
                    style:
                    const TextStyle(fontSize: 16, color: Colors.grey),
                  )),
                ],
              ),
            ),
            const Divider(height: 40),

            // Account Section
            const Text("Account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Name'),
              onTap: () => _showEditNameDialog(context),
            ),
            const Divider(height: 32),

            // Preferences Section
            const Text("Preferences",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: Obx(() => Text(controller.travelerLanguage.value)),
            ),
            const Divider(height: 32),

            // About Section
            const Text("About",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const ListTile(
              leading: Icon(Icons.info),
              title: Text('App Version'),
              subtitle: Text('v3.0.0'),
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Terms of Service'),
              onTap: () => _showTermsDialog(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
      Obx(() => TravelerBottomNav(currentIndex: currentIndex.value)),
    );
  }
}
