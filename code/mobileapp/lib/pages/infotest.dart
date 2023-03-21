import 'package:flutter/material.dart';

class InfoTest extends StatelessWidget {
  const InfoTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      color: Colors.blue,
      strokeWidth: 2,
      child: Container(
        color: Colors.blue,
        height: 100,
        width: 100,
        child: const Text('Info'),
      ),
    );
  }
}
