import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img_pkg;
import '../models/tile_model.dart';

class ImageUtils {
  static Future<List<Tile>> splitImage(File file, int gridSize) async {
    final bytes = await file.readAsBytes();
    final decodedImage = img_pkg.decodeImage(bytes)!;
    final tiles = <Tile>[];

    int tileWidth = (decodedImage.width / gridSize).floor();
    int tileHeight = (decodedImage.height / gridSize).floor();

    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        final tileImage = img_pkg.copyCrop(
          decodedImage,
          x: col * tileWidth,
          y: row * tileHeight,
          width: tileWidth,
          height: tileHeight,
        );

        final png = img_pkg.encodePng(tileImage);
        final uiImage = Image.memory(
          Uint8List.fromList(png),
          fit: BoxFit.cover,
        );

        tiles.add(Tile(
          correctRow: row,
          correctCol: col,
          currentRow: row,
          currentCol: col,
          image: uiImage,
        ));
      }
    }

    return tiles;
  }
}
