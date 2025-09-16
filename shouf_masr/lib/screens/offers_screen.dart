import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/components.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> with SingleTickerProviderStateMixin {
  int _tappedIndex = -1;

  final List<Map<String, dynamic>> offers = [
    {'company': 'Eagle Travel', 'dest': 'Luxor - Aswan', 'days': '9-10 days', 'price': '2000 \$', 'rating': 4},
    {'company': 'EgyTrips', 'dest': 'Luxor - Aswan', 'days': '9-10 days', 'price': '3000 \$', 'rating': 4},
    {'company': 'WhiteHorse', 'dest': 'Luxor - Aswan', 'days': '9-10 days', 'price': '3000 \$', 'rating': 3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcdcc00),
      body: Stack(
        children: [
          // Background image
          Opacity(
            opacity: 0.25,
            child: Image.network(
              'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/5320a810acd3f7b9e7bf278b1f459970e6fdb712.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Center(
                    child: Image.network(
                      'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/248cd0554d0da56d81aece5474bbcdfb9f21ec3a.png',
                      width: 160,
                      height: 55,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Center(
                    child: const Text(
                      'Offers',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            blurRadius: 4,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Offers list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: offers.length,
                      itemBuilder: (context, i) {
                        final offer = offers[i];
                        return GestureDetector(
                          child: AnimatedScale(
                            scale: _tappedIndex == i ? 0.95 : 1.0,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeInOut,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                    child: Image.network(
                                      'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/44fc690732fc1f3ba960869c7f78e1f5308c058e.jpg',
                                      width: double.infinity,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          offer['company'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600, fontSize: 14),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Destinations: ${offer['dest']}',
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          'Days/Nights: ${offer['days']}',
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          'Price: ${offer['price']}',
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: List.generate(
                                            5,
                                                (j) => Icon(
                                              j < offer['rating'] ? Icons.star : Icons.star_border,
                                              color: j < offer['rating'] ? Colors.amber : Colors.grey,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CustomElevatedButton(
                                              text: 'Book Now',
                                              onPressed: () => Get.toNamed('/trip-details'),
                                              backgroundColor: const Color(0xFFcdcc00),
                                              textColor: Colors.white,
                                              fullWidth: false,
                                            ),
                                            const SizedBox(width: 8),
                                            CustomElevatedButton(
                                              text: 'Ask',
                                              onPressed: () => Get.toNamed('/chat'),
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              fullWidth: false,
                                            ),
                                            const SizedBox(width: 8),
                                            CustomElevatedButton(
                                              text: 'Profile',
                                              onPressed: () => Get.toNamed('/company-profile'),
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              fullWidth: false,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Nav bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: const BottomNav(currentIndex: 1),
          ),
        ],
      ),
    );
  }
}
