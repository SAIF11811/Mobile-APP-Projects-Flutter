import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/tile_model.dart';
import '../widgets/puzzle_tile.dart';
import '../utils/image_utils.dart';

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

  @override
  void initState() {
    super.initState();
    _generateTiles();
  }

  Future<void> _generateTiles() async {
    tiles = await ImageUtils.splitImage(widget.imageFile, widget.gridSize);
    if (widget.shuffle) _shuffleTiles();
    setState(() {});
  }

  void _shuffleTiles() {
    tiles.shuffle(Random());
    for (int i = 0; i < tiles.length; i++) {
      tiles[i].currentRow = i ~/ widget.gridSize;
      tiles[i].currentCol = i % widget.gridSize;
    }
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade200,
                Colors.deepPurple.shade50,
              ],
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
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade800),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'You completed the puzzle!',
                style: TextStyle(
                    fontSize: 18, color: Colors.deepPurple.shade700),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
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
    final screenHeight = media.size.height;

    int n = widget.gridSize;
    double tileSize =
        (screenWidth - screenWidth * 0.05 - (4 * (n - 1))) / n;
    double gridHeight = tileSize * n + 10 * (n - 1);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Puzzle Round',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.07),
        ),
        backgroundColor: Colors.amber.shade900,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: tiles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTapDown: (_) => setState(() => _showOriginal = true),
            onTapUp: (_) => setState(() => _showOriginal = false),
            onTapCancel: () => setState(() => _showOriginal = false),
            child: Container(
              margin: EdgeInsets.only(bottom: screenHeight * 0.02),
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.015),
              decoration: BoxDecoration(
                  color: Colors.amber.shade900,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    )
                  ]),
              child: Text(
                'Hold to Preview',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: tileSize * n + 10 * (n - 1),
                  height: gridHeight,
                  padding: EdgeInsets.all(8),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tiles.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: n,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      return DragTarget<int>(
                        builder: (context, candidateData, rejectedData) {
                          return Draggable<int>(
                            data: index,
                            feedback: Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                width: tileSize,
                                height: tileSize,
                                child: PuzzleTile(
                                    tile: tiles[index], shadow: true),
                              ),
                            ),
                            childWhenDragging: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                    width: tileSize * n + 10 * (n - 1),
                    height: gridHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        widget.imageFile,
                        fit: BoxFit.cover,
                      ),
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
