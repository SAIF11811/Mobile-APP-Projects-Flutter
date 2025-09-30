import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/traveler_notifications_controller.dart';
import '../widgets/traveler_bottom_nav.dart';

class TravelerNotificationsScreen extends StatelessWidget {
  TravelerNotificationsScreen({super.key});

  final RxInt currentIndex = 3.obs;

  final TravelerNotificationsController controller =
  Get.put(TravelerNotificationsController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.55,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Notifications',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Obx(
                          () => ListView.separated(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: controller.notifications.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final n = controller.notifications[index];
                          return Dismissible(
                            key: Key(n["title"]! + n["time"]!),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.red,
                              child: const Icon(Icons.delete,
                                  color: Colors.white),
                            ),
                            onDismissed: (_) {
                              controller.notifications.removeAt(index);
                            },
                            child: _notificationCard(
                              title: n["title"],
                              message: n["message"],
                              time: n["time"],
                              colorIndex: index,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
            () => TravelerBottomNav(currentIndex: currentIndex.value),
      ),
    );
  }
}

Widget _notificationCard({
  String? title,
  String? message,
  String? time,
  int colorIndex = 0,
}) {
  final colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.teal,
  ];
  final bgColor = colors[colorIndex % colors.length];

  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.all(12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: bgColor,
          child: const Icon(Icons.person, color: Colors.white, size: 26),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              if (message != null)
                Text(
                  message,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
            ],
          ),
        ),
        if (time != null)
          Text(
            time,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
      ],
    ),
  );
}
