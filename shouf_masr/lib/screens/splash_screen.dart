import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shouf_masr/screens/role_selection.dart';
import 'package:shouf_masr/screens/home_screen.dart';
import 'package:shouf_masr/screens/agency_notifications_screen.dart';
import 'package:shouf_masr/shared_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _circleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 60,
      ),
    ]).animate(_scaleController);

    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 5));

    _scaleController.stop();
    _circleController.stop();

    final rememberTraveler = await SharedPreferenceHelper.getTravelerRememberMe();
    final rememberAgency = await SharedPreferenceHelper.getAgencyRememberMe();

    if (rememberAgency) {
      Get.offAll(() => AgencyNotificationsScreen());
    } else if (rememberTraveler) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const RoleSelection());
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcdcc00),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 400,
              child: AnimatedBuilder(
                animation: _circleController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: CirclePainter(_circleController.value),
                  );
                },
              ),
            ),
            ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                'assets/images/minilogo.png',
                width: 280,
                height: 180,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;
  CirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 6.0;
    final radius = size.width / 2 - strokeWidth;
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: 0.0,
        endAngle: 2 * pi,
        colors: [
          Colors.white.withOpacity(0.0),
          Colors.white.withOpacity(0.3),
          Colors.white,
        ],
        stops: const [0.0, 0.7, 1.0],
        transform: GradientRotation(2 * pi * progress),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) => true;
}
