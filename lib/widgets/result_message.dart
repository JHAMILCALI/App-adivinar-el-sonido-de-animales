import 'package:flutter/material.dart';

class ResultMessage extends StatelessWidget {
  final String message;
  const ResultMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
