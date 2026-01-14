import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'puzzle_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  int _gridSize = 3;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;

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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create your own puzzle!',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.03),
              ElevatedButton.icon(
                icon: Icon(Icons.photo, color: Colors.white, size: screenWidth * 0.06),
                label: Text(
                  'Pick an Image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade900,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.015,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                ),
                onPressed: _pickImage,
              ),
              SizedBox(height: screenHeight * 0.02),
              if (_image != null)
                Expanded(
                  child: Column(
                    children: [
                      Flexible(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(screenWidth * 0.05),
                          child: Image.file(
                            _image!,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Select grid size:',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          DropdownButton<int>(
                            value: _gridSize,
                            items: [2, 3, 4, 5].map((n) {
                              return DropdownMenuItem(
                                value: n,
                                child: Text(
                                  '$n x $n',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _gridSize = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      ElevatedButton.icon(
                        icon: Icon(Icons.play_arrow, color: Colors.white, size: screenWidth * 0.06),
                        label: Text(
                          'Start Puzzle',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber.shade900,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06,
                            vertical: screenHeight * 0.015,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PuzzleScreen(
                                imageFile: _image!,
                                gridSize: _gridSize,
                                shuffle: true,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
