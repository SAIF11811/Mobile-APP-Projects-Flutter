import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import '../models/puzzle_data.dart';
import '../models/tile_model.dart';
import '../widgets/puzzle_tile.dart';

class PuzzleScreen extends StatefulWidget {
  final File imageFile;
  final int gridSize;
  final bool shuffle;

  PuzzleScreen({
    required this.imageFile,
    required this.gridSize,
    this.shuffle = false,
  });

  @override
  _PuzzleScreenState createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  List<Tile> tiles = [];
  bool _showOriginal = false;
  double? gridWidth;
  double? gridHeight;
  double? tileWidth;
  double? tileHeight;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _preparePuzzle();
  }

  Future<void> _preparePuzzle() async {
    setState(() => _isLoading = true);

    final bytes = await widget.imageFile.readAsBytes();
    final decodedImage = img.decodeImage(bytes)!;
    final aspectRatio = decodedImage.width / decodedImage.height;

    List<Tile> generatedTiles = await compute(generateTiles, {
      'imageFile': widget.imageFile,
      'gridSize': widget.gridSize,
      'shuffle': widget.shuffle,
    });

    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    double maxGridWidth = screenWidth * 0.9;
    double maxGridHeight = screenHeight * 0.6;

    double w = maxGridWidth;
    double h = w / aspectRatio;
    if (h > maxGridHeight) {
      h = maxGridHeight;
      w = h * aspectRatio;
    }

    int n = widget.gridSize;
    double tW = (w - (n - 1) * 4) / n;
    double tH = (h - (n - 1) * 4) / n;

    setState(() {
      tiles = generatedTiles;
      gridWidth = w;
      gridHeight = h;
      tileWidth = tW;
      tileHeight = tH;
      _isLoading = false;
    });
  }
  void _swapTiles(int index1, int index2) {
    setState(() {
      var tempRow = tiles[index1].currentRow;
      var tempCol = tiles[index1].currentCol;
      tiles[index1].currentRow = tiles[index2].currentRow;
      tiles[index1].currentCol = tiles[index2].currentCol;
      tiles[index2].currentRow = tempRow;
      tiles[index2].currentCol = tempCol;

      var tempTile = tiles[index1];
      tiles[index1] = tiles[index2];
      tiles[index2] = tempTile;
    });
  }

  bool get _isCompleted => tiles.every((tile) => tile.isCorrect);

  void _showVictoryDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade200, Colors.deepPurple.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.emoji_events, size: 60, color: Colors.amber.shade900),
              SizedBox(height: 10),
              Text(
                'Congratulations!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade800),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'You completed the puzzle!',
                style: TextStyle(fontSize: 18, color: Colors.deepPurple.shade700),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade900,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text('Continue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Puzzle Game',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.07,
            ),
          ),
          backgroundColor: Colors.amber.shade900,
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Puzzle Round',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.07,
          ),
        ),
        backgroundColor: Colors.amber.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTapDown: (_) => setState(() => _showOriginal = true),
            onTapUp: (_) => setState(() => _showOriginal = false),
            onTapCancel: () => setState(() => _showOriginal = false),
            child: Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06,
                  vertical: MediaQuery.of(context).size.height * 0.015),
              decoration: BoxDecoration(
                  color: Colors.amber.shade900,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))]),
              child: Text(
                'Hold to Preview',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: gridWidth,
                  height: gridHeight,
                  padding: EdgeInsets.all(8),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tiles.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.gridSize,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: tileWidth! / tileHeight!,
                    ),
                    itemBuilder: (context, index) {
                      return DragTarget<int>(
                        builder: (context, candidateData, rejectedData) {
                          return Draggable<int>(
                            data: index,
                            feedback: Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                width: tileWidth,
                                height: tileHeight,
                                child: PuzzleTile(tile: tiles[index], shadow: true),
                              ),
                            ),
                            childWhenDragging: Container(
                              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                            ),
                            child: PuzzleTile(tile: tiles[index]),
                          );
                        },
                        onWillAccept: (fromIndex) => fromIndex != index,
                        onAccept: (fromIndex) {
                          _swapTiles(fromIndex!, index);
                          if (_isCompleted) _showVictoryDialog();
                        },
                      );
                    },
                  ),
                ),
                if (_showOriginal)
                  Container(
                    width: gridWidth,
                    height: gridHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(widget.imageFile, fit: BoxFit.cover),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
