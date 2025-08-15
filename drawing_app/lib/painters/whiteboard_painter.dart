import 'package:flutter/material.dart';
import '../models/stroke_model.dart';

class WhiteboardPainter extends CustomPainter {
  final List<Stroke> strokes;
  final Stroke? preview;

  WhiteboardPainter(this.strokes, this.preview);

  @override
  void paint(Canvas canvas, Size size) {
    for (final s in strokes) _paintStroke(canvas, s);
    if (preview != null) _paintStroke(canvas, preview!);
  }

  void _paintStroke(Canvas canvas, Stroke s) {
    final paint = Paint()
      ..strokeWidth = s.width
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Color(s.color).withOpacity(s.mode == "highlighter" ? 0.35 : 1.0)
      ..blendMode = s.mode == "erase" ? BlendMode.clear : BlendMode.srcOver;

    final path = Path()..moveTo(s.points.first.dx, s.points.first.dy);
    for (int i = 1; i < s.points.length; i++) {
      final p0 = s.points[i - 1];
      final p1 = s.points[i];
      final mid = Offset((p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);
      path.quadraticBezierTo(p0.dx, p0.dy, mid.dx, mid.dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
