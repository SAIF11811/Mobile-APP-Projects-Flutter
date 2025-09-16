import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _tappedIndex = -1;

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
              padding: const EdgeInsets.all(20),
              child: Column(
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Welcome Section
                          const _SectionTitle(
                            icon: Icons.waving_hand,
                            title: 'Welcome',
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Hello ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: 'Sophia!',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          CustomElevatedButton(
                            text: "Check Your Offers",
                            onPressed: () => Get.toNamed('/my-offers'),
                            fullWidth: true,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            icon: Icons.local_offer,
                            iconRight: true,
                          ),
                          const SizedBox(height: 20),

                          // Articles Section
                          const _SectionTitle(
                            icon: Icons.article,
                            title: 'Articles',
                          ),
                          const SizedBox(height: 12),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.75,
                            children: List.generate(4, (i) => _articleCard(i)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 70), // Extra space for nav bar
                ],
              ),
            ),
          ),

          // Bottom navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: const BottomNav(currentIndex: 0),
          ),
        ],
      ),
    );
  }

  Widget _articleCard(int i) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _tappedIndex = i),
      onTapUp: (_) => setState(() => _tappedIndex = -1),
      onTapCancel: () => setState(() => _tappedIndex = -1),
      onTap: () => Get.toNamed('/article'),
      child: AnimatedScale(
        scale: _tappedIndex == i ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Container(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/44fc690732fc1f3ba960869c7f78e1f5308c058e.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
                child: Column(
                  children: const [
                    Text(
                      "Places you don't know it exists",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'By Eagle Travel',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionTitle({required this.icon, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
