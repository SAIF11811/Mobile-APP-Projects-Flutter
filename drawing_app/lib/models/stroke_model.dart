import 'dart:convert';
import 'package:flutter/material.dart';

class Stroke {
  final List<Offset> points; // stroke points
  final double width;        // stroke width
  final int color;           // ARGB color value
  final String mode;         // "pen", "highlighter", "eraser" (future)

  Stroke({
    required this.points,
    required this.width,
    required this.color,
    required this.mode,
  });

  Map<String, dynamic> toMap() => {
    'points': points
        .map((p) => {'x': p.dx, 'y': p.dy})
        .toList(),
    'width': width,
    'color': color,
    'mode': mode,
  };

  factory Stroke.fromMap(Map<String, dynamic> map) {
    return Stroke(
      points: (map['points'] as List)
          .map((p) => Offset(
        (p['x'] as num).toDouble(),
        (p['y'] as num).toDouble(),
      ))
          .toList(),
      width: (map['width'] as num).toDouble(),
      color: map['color'] as int,
      mode: map['mode'] as String,
    );
  }

  static String encodeList(List<Stroke> strokes) =>
      jsonEncode(strokes.map((s) => s.toMap()).toList());

  static List<Stroke> decodeList(String jsonStr) {
    final List<dynamic> data = jsonDecode(jsonStr);
    return data.map((m) => Stroke.fromMap(m)).toList();
  }
}
