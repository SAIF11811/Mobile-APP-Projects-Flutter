import 'dart:io';
import 'dart:math';
import '../models/tile_model.dart';
import '../utils/image_utils.dart';

class PuzzleData {
  final List<Tile> tiles;
  final int gridSize;
  final bool shuffle;

  PuzzleData({required this.tiles, required this.gridSize, this.shuffle = false});
}

Future<List<Tile>> generateTiles(Map<String, dynamic> params) async {
  File imageFile = params['imageFile'];
  int gridSize = params['gridSize'];
  bool shuffle = params['shuffle'];

  List<Tile> tiles = await ImageUtils.splitImage(imageFile, gridSize);

  if (shuffle) {
    tiles.shuffle(Random());
    for (int i = 0; i < tiles.length; i++) {
      tiles[i].currentRow = i ~/ gridSize;
      tiles[i].currentCol = i % gridSize;
    }
  }

  return tiles;
}
