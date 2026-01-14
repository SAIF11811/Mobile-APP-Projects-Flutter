import 'package:flutter/material.dart';

class Tile {
  final int correctRow;
  final int correctCol;
  int currentRow;
  int currentCol;
  final Image image;

  Tile({
    required this.correctRow,
    required this.correctCol,
    required this.currentRow,
    required this.currentCol,
    required this.image,
  });

  bool get isCorrect => correctRow == currentRow && correctCol == currentCol;
}
