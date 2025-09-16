import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  const BottomNav({super.key, required this.currentIndex});

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed('/home');
        break;
      case 1:
        Get.offAllNamed('/offers');
        break;
      case 2:
        Get.offAllNamed('/search');
        break;
      case 3:
        Get.offAllNamed('/messages');
        break;
      case 4:
        Get.offAllNamed('/setting');
        break;
      default:
        Get.offAllNamed('/home');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.local_offer, 'label': 'Offers'},
      {'icon': Icons.search, 'label': 'Search'},
      {'icon': Icons.message, 'label': 'Messages'},
      {'icon': Icons.settings, 'label': 'Settings'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Transform.translate(
        offset: const Offset(0, -5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [Color(0xFF9A9B5F), Color(0xFF85853F)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, -3),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final selected = currentIndex == index;
                return Expanded(
                  child: InkWell(
                    onTap: () => _onItemTapped(index),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            items[index]['icon'] as IconData,
                            color: selected ? const Color(0xFFcdcc00) : Colors.white,
                            size: selected ? 32 : 28,
                            shadows: selected
                                ? [
                              Shadow(
                                color: Colors.yellow.withOpacity(0.7),
                                blurRadius: 12,
                                offset: const Offset(0, 0),
                              ),
                            ]
                                : [],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
