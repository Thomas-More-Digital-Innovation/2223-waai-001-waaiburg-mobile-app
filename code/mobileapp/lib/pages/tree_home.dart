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
          const Positioned(
            top: 50, // Adjust the position as needed
            left: 50, // Adjust the position as needed
            child: ChatBubble(
              message:
                  'Hallo ik ben bryan en de waaiburg is hier super blij mee',
              horizontalPadding: 40,
              verticalPadding: 20,
              backgroundColor: Colors.white,
              textColor: Colors.black,
            ),
          ),
          // Pijltje Links
          Positioned(
            bottom: -10, // Adjust the position as needed
            left: 10, // Adjust the position as needed
            child: IconButton(
              icon: Transform.rotate(
                angle: 45,
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Color(0xFF3855a2),
                  weight: 0.9,
                ),
              ),
              iconSize: 55,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          // Antwoord
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width / 2 -
                50, // Center Horizontally
            right: null,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF3855a2),
              ),
              onPressed: (() => {}),
              child: const Text(
                'Antwoorden',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          // Pijltje Rechts
          Positioned(
            bottom: -10, // Adjust the position as needed
            right: 10, // Adjust the position as needed
            child: IconButton(
              icon: const Icon(
                Icons.play_arrow_rounded,
                color: Color(0xFF3855a2),
                weight: 0.9,
              ),
              iconSize: 55,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final double horizontalPadding;
  final double verticalPadding;
  final Color backgroundColor;
  final Color textColor;
  final double maxWidth;

  const ChatBubble({
    Key? key,
    required this.message,
    this.horizontalPadding = 16.0,
    this.verticalPadding = 8.0,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.maxWidth = 200.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BubbleClipper(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              message,
              style: TextStyle(color: textColor),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }
}

class BubbleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);

    path.lineTo(size.width, 20);
    path.quadraticBezierTo(size.width, 0, size.width - 20, 0);

    path.lineTo(10, 0);
    path.quadraticBezierTo(0, 0, 0, 20);

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 10, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
