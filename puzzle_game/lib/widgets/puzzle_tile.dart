import 'package:flutter/material.dart';
import '../models/tile_model.dart';

class PuzzleTile extends StatelessWidget {
  final Tile tile;
  final bool shadow;

  PuzzleTile({required this.tile, this.shadow = false});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 1),
            boxShadow: shadow
                ? [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(2, 2),
              )
            ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FittedBox(
              fit: BoxFit.fill,
              child: tile.image,
            ),
          ),
        );
      },
    );
  }
}
