import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobileapp/api/question_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TreeHome extends StatefulWidget {
  const TreeHome({Key? key}) : super(key: key);

  @override
  State<TreeHome> createState() => _TreeHomeState();
}

class _TreeHomeState extends State<TreeHome> {
  late Future<List<dynamic>> futureQuestionAnswerList;

  List<Question>? questionsList;
  List<Answer>? answersList;
  int currentQuestionIndex = 0;
  bool isInputVisible = false;
  Answer? answer;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    futureQuestionAnswerList = fetchQuestionList();

    // Using `await` to wait for the future to complete before accessing its value
    List<dynamic> questionAnswerList = await futureQuestionAnswerList;

    // Now you can access the elements of the list
    questionsList = questionAnswerList[0];
    answersList = questionAnswerList[1];

    // Find the index of the first unanswered question
    int indexOfFirstUnansweredQuestion = questionsList!.indexWhere((question) =>
        answersList!.every((answer) => answer.questionId != question.id));

    // Set currentQuestionIndex to the found index, or 0 if no unanswered questions are found
    setState(() {
      currentQuestionIndex = indexOfFirstUnansweredQuestion >= 0
          ? indexOfFirstUnansweredQuestion
          : 0;
    });
  }

  void _goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        isInputVisible = false;
        answer = _getAnswerValue(currentQuestionIndex);
      });
    }
  }

  void _goToNextQuestion() {
    if (questionsList != null &&
        currentQuestionIndex < questionsList!.length - 1) {
      setState(() {
        currentQuestionIndex++;
        isInputVisible = false;
        answer = _getAnswerValue(currentQuestionIndex);
      });
    }
  }

  Answer? _getAnswerValue(int questionIndex) {
    if (questionIndex >= 0 && questionIndex < questionsList!.length) {
      final currentQuestionId = questionsList![currentQuestionIndex].id;

      try {
        final answer = answersList!.firstWhere(
          (answer) => answer.questionId == currentQuestionId,
        );

        return answer;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image (tree)
          Image.asset(
            'assets/tree.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context)
                .size
                .height, // Adjust the height as needed
          ),
          // Character image (smaller and in front)
          Positioned(
            bottom: 0,
            right: -80,
            child: Image.asset(
              'assets/character.png',
              width: 400,
              height: 500,
            ),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.home_rounded,
                color: Color(0xFF3855a2),
                weight: 0.9,
              ),
              iconSize: 55,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // Speech Bubble
          Positioned(
            top: 100,
            left: 50,
            child: questionsList == null
                ? const CircularProgressIndicator()
                : questionsList!.isEmpty
                    ? const Text("No questions available")
                    : ChatBubble(
                        message: questionsList![currentQuestionIndex].content,
                        horizontalPadding: 40,
                        verticalPadding: 20,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                      ),
          ),
          // Input bubble
          if (isInputVisible)
            Positioned(
              bottom: 80, // Adjust the position as needed
              left: MediaQuery.of(context).size.width / 2 - 150,
              child: InputBubble(
                answer: answer,
              ),
            ),
          // Pijltje Links
          Positioned(
            bottom: -10,
            left: 10,
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
              onPressed: _goToPreviousQuestion,
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
              onPressed: () {
                setState(() {
                  if (!isInputVisible) {
                    isInputVisible = true;
                  } else {
                    isInputVisible = false;
                  }
                });
              },
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
              onPressed: _goToNextQuestion,
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

class InputBubble extends StatefulWidget {
  late Answer? answer;
  InputBubble({Key? key, this.answer}) : super(key: key);

  @override
  _InputBubbleState createState() => _InputBubbleState();
}

class _InputBubbleState extends State<InputBubble> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.answer != null) {
      _textController.text = widget.answer!.answer;
    }
  }

  Future<void> _sendAnswer(String newAnswer) async {
    const String apiUrl = 'https://dewaaiburgapp.eu/api/answer'; // API URL
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('userToken');

    try {
      final answer = Answer(
        answer: newAnswer,
        questionId: widget.answer!.questionId,
        userId: widget.answer!.userId,
        id: widget.answer!.id,
      );
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id' : widget.answer!.userId,
          'question_id': widget.answer!.questionId,
          'answer': answer,
        }),
      );

      if (response.statusCode == 200) {
        print('Answer sent successfully');
      } else {
        print("Request failed with status: ${response.statusCode}");
        throw Exception('Failed to send answer');
      }
    } catch (e) {
      print("Request failed with exception: $e");
      throw Exception('Failed to send answer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: 300,
          height: 50,
          child: ClipPath(
            clipper: BubbleClipper(),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Typ je antwoord...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      // Handle sending the message
                      final newAnswer = _textController.text;
                      print("Sending message: $newAnswer");

                      _sendAnswer(newAnswer);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
