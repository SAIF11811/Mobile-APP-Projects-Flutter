import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/stroke_model.dart';
import '../painters/whiteboard_painter.dart';

class WhiteboardScreen extends StatefulWidget {
  const WhiteboardScreen({super.key});

  @override
  State<WhiteboardScreen> createState() => _WhiteboardScreenState();
}

class _WhiteboardScreenState extends State<WhiteboardScreen> {
  final GlobalKey _whiteboardKey = GlobalKey();
  List<Stroke> _strokes = [];
  List<Stroke> _redoStack = [];
  Stroke? _currentStroke;

  double _penWidth = 4.0;
  int _penColor = Colors.black.value;
  double _highlighterWidth = 10.0;
  int _highlighterColor = Colors.yellow.value;
  double _eraserWidth = 20.0;

  String _mode = "pen";
  int _color = Colors.black.value;
  double _width = 4.0;

  // ------------------- Drawing Logic -------------------
  void _startStroke(Offset position) {
    setState(() {
      _currentStroke = Stroke(
        points: [position],
        color: _color,
        width: _width,
        mode: _mode,
      );
    });
  }

  void _updateStroke(Offset position) {
    setState(() {
      _currentStroke?.points.add(position);
    });
  }

  void _endStroke() {
    setState(() {
      if (_currentStroke != null) _strokes.add(_currentStroke!);
      _currentStroke = null;
    });
  }

  void _undo() {
    if (_strokes.isNotEmpty) {
      setState(() {
        _redoStack.add(_strokes.removeLast());
      });
    }
  }

  void _redo() {
    if (_redoStack.isNotEmpty) {
      setState(() {
        _strokes.add(_redoStack.removeLast());
      });
    }
  }

  void _clear() {
    setState(() {
      _strokes.clear();
      _redoStack.clear();
    });
  }

  // ------------------- PDF Save -------------------
  Future<void> _saveWhiteboard() async {
    String fileName = "whiteboard_${DateTime.now().millisecondsSinceEpoch}";

    final TextEditingController controller = TextEditingController(text: fileName);
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Enter file name"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "File name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    fileName = controller.text.trim();
    if (fileName.isEmpty) fileName = "whiteboard_${DateTime.now().millisecondsSinceEpoch}";

    try {
      RenderRepaintBoundary boundary =
      _whiteboardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      double pixelRatio = MediaQuery.of(context).devicePixelRatio;
      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final pdf = pw.Document();
      final pdfImage = pw.MemoryImage(pngBytes);
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return pw.Center(child: pw.Image(pdfImage));
          },
        ),
      );

      Directory? externalDir = await getExternalStorageDirectory();
      if (externalDir == null) throw "Cannot access storage";

      String downloadsPath = "${externalDir.path.split("Android")[0]}Download";
      final dir = Directory(downloadsPath);
      if (!await dir.exists()) await dir.create(recursive: true);

      final file = File('${dir.path}/$fileName.pdf');
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("PDF Saved!"), backgroundColor: Colors.green),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving PDF: $e")),
      );
    }
  }

  // ------------------- Pen / Highlighter Settings -------------------
  void _openPenSettings(String mode) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        Color tempColor = mode == "pen" ? Color(_penColor) : Color(_highlighterColor);
        double tempWidth = mode == "pen" ? _penWidth : _highlighterWidth;
        final List<Color> standardColors = [
          Colors.black, Colors.red, Colors.orange, Colors.yellow,
          Colors.green, Colors.blueAccent, Colors.purple, Colors.brown, Colors.pink
        ];

        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.95), Colors.grey[200]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: StatefulBuilder(
              builder: (context, setModalState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      mode == "pen" ? "✏️ Pen Settings" : "🖌 Highlighter Settings",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: standardColors.map((c) {
                        return GestureDetector(
                          onTap: () => setModalState(() => tempColor = c),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: tempColor == c ? Border.all(color: Colors.blue, width: 3) : null,
                            ),
                            child: CircleAvatar(
                              backgroundColor: c,
                              radius: tempColor == c ? 22 : 18,
                              child: tempColor == c ? const Icon(Icons.check, color: Colors.white) : null,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text("Width:"),
                        Expanded(
                          child: Slider(
                            min: 1,
                            max: 30,
                            value: tempWidth,
                            onChanged: (v) => setModalState(() => tempWidth = v),
                          ),
                        ),
                        Text("${tempWidth.toStringAsFixed(1)} px"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.check),
                      label: const Text("Apply"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        minimumSize: const Size.fromHeight(45),
                      ),
                      onPressed: () {
                        setState(() {
                          if (mode == "pen") {
                            _penColor = tempColor.value;
                            _penWidth = tempWidth;
                          } else {
                            _highlighterColor = tempColor.value;
                            _highlighterWidth = tempWidth;
                          }
                          _color = tempColor.value;
                          _width = tempWidth;
                          _mode = mode;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  // ------------------- Eraser Settings -------------------
  void _openEraserSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        double tempWidth = _eraserWidth;
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: StatefulBuilder(
              builder: (context, setModalState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("🧽 Eraser Size", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Slider(
                      min: 5,
                      max: 50,
                      value: tempWidth,
                      onChanged: (v) => setModalState(() => tempWidth = v),
                    ),
                    Text("${tempWidth.toStringAsFixed(1)} px"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _eraserWidth = tempWidth;
                          _width = _eraserWidth;
                          _color = Colors.white.value;
                          _mode = "eraser";
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("Apply"),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  // ------------------- Toolbar Button -------------------
  Widget _toolButton(IconData icon, String mode, VoidCallback onTap,
      {bool selectable = true, Color? colorIndicator, Color? iconColor}) {
    bool isSelected = selectable && _mode == mode;
    return Tooltip(
      message: mode,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        splashColor: Colors.blue.withOpacity(0.2),
        child: AnimatedScale(
          scale: isSelected ? 1.25 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isSelected ? (Colors.blue).withOpacity(0.15) : null,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  size: 26,
                  color: iconColor ?? (isSelected ? Colors.blue : Colors.black87),
                ),
              ),
              if (colorIndicator != null)
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: colorIndicator,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------- Build -------------------
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: (details) => _startStroke(details.localPosition),
            onPanUpdate: (details) => _updateStroke(details.localPosition),
            onPanEnd: (_) => _endStroke(),
            child: RepaintBoundary(
              key: _whiteboardKey,
              child: SizedBox(
                width: screenSize.width,
                height: screenSize.height,
                child: CustomPaint(
                  painter: WhiteboardPainter(_strokes, _currentStroke),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.09,
            right: screenSize.width * 0.02,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  children: [
                    _toolButton(Icons.edit, "pen", () {
                      setState(() { _mode = "pen"; _color = _penColor; _width = _penWidth; });
                      _openPenSettings("pen");
                    }, colorIndicator: Color(_penColor), iconColor: Colors.black),
                    SizedBox(height: screenSize.height * 0.02),
                    _toolButton(Icons.brush, "highlighter", () {
                      setState(() { _mode = "highlighter"; _color = _highlighterColor; _width = _highlighterWidth; });
                      _openPenSettings("highlighter");
                    }, colorIndicator: Color(_highlighterColor), iconColor: Colors.deepOrange),
                    SizedBox(height: screenSize.height * 0.02),
                    _toolButton(Icons.cleaning_services, "eraser", _openEraserSettings, iconColor: Colors.blueGrey),
                    SizedBox(height: screenSize.height * 0.02),
                    _toolButton(Icons.undo, "undo", _undo, selectable: false, iconColor: Colors.purple),
                    SizedBox(height: screenSize.height * 0.02),
                    _toolButton(Icons.redo, "redo", _redo, selectable: false, iconColor: Colors.purple),
                    SizedBox(height: screenSize.height * 0.02),
                    _toolButton(Icons.delete, "clear", _clear, selectable: false, iconColor: Colors.red),
                    SizedBox(height: screenSize.height * 0.02),
                    _toolButton(Icons.save, "save", _saveWhiteboard, selectable: false, iconColor: Colors.green),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
