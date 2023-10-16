import 'package:flutter/material.dart';
import 'package:mobileapp/api/question.dart';

class TreeHome extends StatefulWidget {
  const TreeHome({Key? key}) : super(key: key);

  @override
  State<TreeHome> createState() => _TreeHomeState();
}

class _TreeHomeState extends State<TreeHome> {
  late Future<List<Question>> futureQuestions;

  @override
  void initState() {
    super.initState();
    futureQuestions = fetchQuestion();
    print(futureQuestions);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image (tree)
          Image.asset(
            'assets/tree.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Character image (smaller and in front)
          Positioned(
            bottom: 0, // Adjust the position as needed
            right: -80, // Adjust the position as needed
            child: Image.asset(
              'assets/character.png',
              width: 400, // Adjust the size as needed
              height: 500, // Adjust the size as needed
            ),
          ),
          // Speech Bubble
          Positioned(
            bottom: 60, // Adjust the position as needed
            right: 20, // Adjust the position as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    'Hello!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 0,
                  height: 0,
                  child: CustomPaint(
                    size: const Size(20, 20), // Size of the arrow
                    painter: TriangleArrowPainter(Colors.white),
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

class TriangleArrowPainter extends CustomPainter {
  final Color color;

  TriangleArrowPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
