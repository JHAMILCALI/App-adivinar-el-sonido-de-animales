import 'package:flutter/material.dart';

class AnimalImage extends StatelessWidget {
  final String imagePath;

  const AnimalImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath, height: 200);
  }
}
