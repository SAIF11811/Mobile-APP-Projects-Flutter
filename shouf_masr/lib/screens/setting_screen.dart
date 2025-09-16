import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_nav.dart';

class SettingsController extends GetxController {
  RxBool isDarkMode = false.obs;
  RxBool notificationsEnabled = true.obs;
  RxString selectedLanguage = 'English'.obs;
  RxBool backupEnabled = false.obs;
  RxBool locationAccess = true.obs;

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  void changeLanguage(String language) {
    selectedLanguage.value = language;
  }

  void toggleBackup(bool value) {
    backupEnabled.value = value;
  }

  void toggleLocation(bool value) {
    locationAccess.value = value;
  }

  void logout() {
    Get.offAllNamed('/role-selection');
  }
}

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController controller = Get.put(SettingsController());

  final RxInt currentIndex = 4.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFFcdcc00),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.defaultDialog(
                title: 'Logout',
                middleText: 'Are you sure you want to logout?',
                textCancel: 'Cancel',
                textConfirm: 'Logout',
                confirmTextColor: Colors.white,
                cancelTextColor: Colors.black,
                backgroundColor: Colors.white,
                onCancel: () {
                  Get.back();
                },
                onConfirm: () {
                  controller.logout();
                  Get.back();
                },
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            const Text('Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: const Text('Sophia Johnson'),
              subtitle: const Text('sophia@example.com'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Navigate to profile edit screen
                },
              ),
            ),
            const Divider(height: 32),

            // Preferences Section
            const Text('Preferences', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Obx(() => SwitchListTile(
              title: const Text('Enable Notifications'),
              value: controller.notificationsEnabled.value,
              onChanged: controller.toggleNotifications,
              secondary: const Icon(Icons.notifications),
            )),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              trailing: Obx(() => Text(controller.selectedLanguage.value)),
              onTap: () {
                Get.defaultDialog(
                  title: 'Select Language',
                  content: Column(
                    children: [
                      ListTile(
                        title: const Text('English'),
                        onTap: () {
                          controller.changeLanguage('English');
                          Get.back();
                        },
                      ),
                      ListTile(
                        title: const Text('Arabic'),
                        onTap: () {
                          controller.changeLanguage('Arabic');
                          Get.back();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(height: 32),

            // Security Section
            const Text('Security', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              onTap: () {
                // Navigate to change password screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy & Security'),
              onTap: () {
                // Navigate to privacy screen
              },
            ),
            Obx(() => SwitchListTile(
              title: const Text('Location Access'),
              value: controller.locationAccess.value,
              onChanged: controller.toggleLocation,
              secondary: const Icon(Icons.location_on),
            )),
            const Divider(height: 32),

            // Backup & Sync Section
            const Text('Backup & Sync', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Obx(() => SwitchListTile(
              title: const Text('Enable Backup'),
              value: controller.backupEnabled.value,
              onChanged: controller.toggleBackup,
              secondary: const Icon(Icons.cloud),
            )),
            const Divider(height: 32),

            // Support Section
            const Text('Support', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & FAQ'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.contact_support),
              title: const Text('Contact Support'),
              onTap: () {},
            ),
            const Divider(height: 32),

            // About Section
            const Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('App Version'),
              subtitle: const Text('v1.0.0'),
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Terms of Service'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy Policy'),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNav(currentIndex: currentIndex.value)),
    );
  }
}
