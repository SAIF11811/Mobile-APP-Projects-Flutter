import 'package:flutter/material.dart';
import 'package:shouf_masr/screens/role_selection.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen>
    with TickerProviderStateMixin {
  late AnimationController _dotController;

  @override
  void initState() {
    super.initState();

    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcdcc00),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(), // keeps top empty
            // Center content (text + bouncing dots)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Waiting For Approval',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    return AnimatedBuilder(
                      animation: _dotController,
                      builder: (context, child) {
                        double value =
                            (_dotController.value + (i * 0.2)) % 1.0;

                        double dy;
                        if (value < 0.5) {
                          dy = -20 *
                              Curves.easeOut.transform(value / 0.5);
                        } else {
                          dy = -20 *
                              (1 -
                                  Curves.bounceOut
                                      .transform((value - 0.5) / 0.5));
                        }

                        return Container(
                          margin:
                          const EdgeInsets.symmetric(horizontal: 6),
                          child: Transform.translate(
                            offset: Offset(0, dy),
                            child: const Dot(),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
            // Home button at bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: IconButton(
                icon: const Icon(Icons.home,
                    color: Colors.white, size: 50),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RoleSelection()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
