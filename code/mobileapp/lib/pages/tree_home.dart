import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobileapp/api/question_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class TreeHome extends StatefulWidget {
  const TreeHome({Key? key}) : super(key: key);

  @override
  State<TreeHome> createState() => _TreeHomeState();
}

class _TreeHomeState extends State<TreeHome> with TickerProviderStateMixin {
  late Future<List<dynamic>> futureQuestionAnswerList;

  List<Question>? questionsList;
  List<Answer>? answersList;
  int currentQuestionIndex = 0;
  int currentTreePartIndex = 0;
  bool isInputVisible = false;
  Answer? answer;
  bool treeStateChanged = false;
  final GlobalKey _speechBubbleKey = GlobalKey();
  double _answerTopPosition = 0;
  bool isKeyboardVisible = false;
  bool allQuestionsFilledIn = false;

  int _state = 0;

  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
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

    //go to the last filled in question because nicer user experience
    if (indexOfFirstUnansweredQuestion > 0) {
      indexOfFirstUnansweredQuestion -= 1;
    }

    // Set currentQuestionIndex to the found index, or 0 if no unanswered questions are found
    setState(() {
      currentQuestionIndex = indexOfFirstUnansweredQuestion >= 0
          ? indexOfFirstUnansweredQuestion
          : questionsList!.length - 1;
    });

    // set the current tree part index to the found index, or 0 if no unanswered questions are found
    setState(() {
      currentTreePartIndex = questionsList![currentQuestionIndex].treePartId;
    });
    // set the current index to the current tree part index - 1 because the tree part index starts at 1
    setState(() {
      _state = currentTreePartIndex - 1;
    });
    // set the answer to the answer of the current question
    setState((() => answer = _getAnswerValue(currentQuestionIndex)));
  }

  void _goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      if (!allQuestionsFilledIn) {
        setState(() {
          currentQuestionIndex--;
          isInputVisible = false;
          answer = _getAnswerValue(currentQuestionIndex);
        });
      } else {
        setState(() {
          allQuestionsFilledIn = false;
        });
      }
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
    } else if (currentQuestionIndex == questionsList!.length - 1) {
      setState(() {
        allQuestionsFilledIn = true;
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

  Future<void> reloadAllData() async {
    await _initializeData();
    isInputVisible = false;
  }

  final treeStates = const {
    0: 'begin',
    1: 'zaadje',
    2: 'stam',
    3: 'takken',
    4: 'bladeren',
    5: 'appels',
    6: 'vogels',
    7: 'last'
  };

  void _updateTreeState(String direction) async {
    final Completer<void> completer = Completer<void>();

    setState(() {
      if (direction == "Forward") {
        if (_state < 6) {
          _state += 1;
          // Reset the controller to the beginning after the state update.
        }
      } else if (direction == "Backward") {
        if (_state > 0) {
          _state -= 1;
          // Reset the controller to the beginning after the state update.
        }
      }
    });

    if (treeStateChanged) {
      // Load the images asynchronously
      await _loadImages().then((_) {
        completer.complete();
      });

      // Wait until the images are fully loaded before updating the video controller
      await completer.future;

      // Update the current tree part index
      setState(() {
        currentTreePartIndex = questionsList![currentQuestionIndex].treePartId;
      });

      try {
        await _loadVideo();
      } catch (e) {
        print("Error loading video: $e");
      }
      _initializeChewieController();
    }
  }

  Future<void> _loadVideo() async {
    try {
      _videoPlayerController = VideoPlayerController.asset(
        'assets/tree_of_life/${treeStates[_state]}.mp4',
      );

      await _videoPlayerController.initialize();
    } catch (error) {
      print('Error initializing video player: $error');
      // Handle the error as needed
    }
  }

  void _initializeChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: MediaQuery.of(context).size.width /
          MediaQuery.of(context).size.height,
      autoInitialize: true,
      autoPlay: true,
      looping: false,
      allowPlaybackSpeedChanging: false,
      showControlsOnInitialize: false,
      allowFullScreen: true,
      showControls: false,
      showOptions: false,
    );
  }

  Future<void> _loadImages() async {
    final precacheTasks = <Future>[];
    for (var i = 1; i <= 6; i++) {
      precacheTasks.add(
        precacheImage(
          AssetImage('assets/tree_of_life/${treeStates[i]}.png'),
          context,
        ),
      );
    }
    await Future.wait(precacheTasks);
  }

  Widget buildChewieWidget() {
    setState(() {
      treeStateChanged = false;
    });
    return FutureBuilder<void>(
      future: _loadVideo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AbsorbPointer(
            absorbing: true,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          print("Error loading video: ${snapshot.error}");
          return AspectRatio(
            aspectRatio: MediaQuery.of(context).size.width /
                MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/tree_of_life/${treeStates[_state]}.png',
              fit: BoxFit.fill,
            ),
          );
        } else {
          // Loading state, you can return a loading indicator if needed
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  double _calculateAnswerTopPosition() {
    if (questionsList != null && questionsList!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Get the RenderBox for the speech bubble widget using the GlobalKey
        final RenderBox renderBox =
            _speechBubbleKey.currentContext!.findRenderObject() as RenderBox;

        // Calculate the top position by adding the height of the speech bubble
        setState(() {
          _answerTopPosition = renderBox.size.height + 120;
        });
      });

      // Return the last calculated top position
      return _answerTopPosition;
    }
    return 0; // Default top position if questionsList is null or empty
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Background image (tree)
              AspectRatio(
                aspectRatio: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/tree_of_life/${_state > 0 ? treeStates[_state - 1] : treeStates[_state]}.png',
                  fit: BoxFit.fill,
                ),
              ),
              // Show the video player when _state is not 0.

              treeStateChanged
                  ? buildChewieWidget()
                  : AspectRatio(
                      aspectRatio: MediaQuery.of(context).size.width /
                          MediaQuery.of(context).size.height,
                      child: Image.asset(
                        'assets/tree_of_life/${treeStates[_state]}.png',
                        fit: BoxFit.fill,
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
              if (allQuestionsFilledIn)
                const Column(
                  children: [
                    SizedBox(height: 75),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Proficiat!",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3855a2),
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              "Je hebt alle vragen ingevuld,\nje boom is nu volgroeid.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF3855a2),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Scroll gerust terug om te kijken wat je \n antwoorden waren tijdens de groei van je boom",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

              // Speech Bubble
              if (!allQuestionsFilledIn)
                Positioned(
                  key: _speechBubbleKey,
                  top: 100,
                  left: 30,
                  child: questionsList == null
                      ? const CircularProgressIndicator()
                      : questionsList!.isEmpty
                          ? const Text("Geen actieve vragenlijst gevonden!")
                          : ChatBubble(
                              message:
                                  questionsList![currentQuestionIndex].content,
                              horizontalPadding: 40,
                              verticalPadding: 20,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                            ),
                ),
              if (!allQuestionsFilledIn)
                if (answer != null)
                  // Answer Bubble
                  if (questionsList != null && questionsList!.isNotEmpty)
                    Positioned(
                      top: _calculateAnswerTopPosition(),
                      right: 30,
                      child: ChatBubble(
                        message: answer!.answer,
                        horizontalPadding: 40,
                        verticalPadding: 20,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                      ),
                    ),
              // Input bubble
              if (isInputVisible)
                Positioned(
                  bottom: isKeyboardVisible
                      ? 350
                      : 90, // Adjust the position as needed
                  left: MediaQuery.of(context).size.width / 2 - 150,
                  child: InputBubble(
                    answer: answer,
                    questionId: questionsList![currentQuestionIndex].id,
                    reloadData: reloadAllData,
                    updateKeyboardVisibility: (bool isVisible) {
                      setState(() {
                        isKeyboardVisible = isVisible;
                      });
                    },
                  ),
                ),

              // Pijltje Links
              Positioned(
                bottom: 20,
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
                  onPressed: () {
                    _goToPreviousQuestion();
                    if (questionsList != null && questionsList!.isNotEmpty) {
                      if (currentTreePartIndex <
                          questionsList![currentQuestionIndex].treePartId) {
                        setState(() {
                          treeStateChanged = true;
                        });
                        _updateTreeState("Backward");
                      }
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if (!allQuestionsFilledIn)
                // Antwoord
                Positioned(
                  bottom: 30,
                  left: MediaQuery.of(context).size.width / 2 -
                      50, // Center Horizontally
                  right: null,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF3855a2),
                    ),
                    onPressed: () {
                      if (questionsList!.isNotEmpty) {
                        setState(() {
                          if (!isInputVisible) {
                            isInputVisible = true;
                          } else {
                            isInputVisible = false;
                          }
                        });
                      }
                    },
                    child: const Text(
                      'Antwoorden',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const SizedBox(
                width: 5,
              ),
              // Pijltje Rechts
              if (!allQuestionsFilledIn)
                if (answer != null)
                  Positioned(
                    bottom: 20, // Adjust the position as needed
                    right: 10, // Adjust the position as needed
                    child: IconButton(
                      icon: const Icon(
                        Icons.play_arrow_rounded,
                        color: Color(0xFF3855a2),
                        weight: 0.9,
                      ),
                      iconSize: 55,
                      onPressed: () {
                        _goToNextQuestion();
                        if (questionsList != null &&
                            questionsList!.isNotEmpty) {
                          if (currentTreePartIndex <
                              questionsList![currentQuestionIndex].treePartId) {
                            setState(() {
                              treeStateChanged = true;
                            });
                            _updateTreeState("Forward");
                          }
                        }
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

// ... (rest of the code remains unchanged)

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
  final int questionId;
  final Function reloadData;
  final Function(bool) updateKeyboardVisibility;

  InputBubble({
    Key? key,
    this.answer,
    required this.questionId,
    required this.reloadData,
    required this.updateKeyboardVisibility,
  }) : super(key: key);

  @override
  _InputBubbleState createState() => _InputBubbleState();
}

class _InputBubbleState extends State<InputBubble> {
  final TextEditingController _textController = TextEditingController();
  late final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    if (widget.answer != null) {
      _textController.text = widget.answer!.answer;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    widget.updateKeyboardVisibility(_focusNode.hasFocus);
  }

  Future<void> _sendAnswer(String newAnswer) async {
    String apiUrl = 'http://10.0.2.2:8000/api/answer'; // API URL
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('userToken');
    final userId = prefs.get('userId');

    if (widget.answer != null) {
      widget.answer!.answer = newAnswer;
      try {
        final response = await http.put(
          Uri.parse("$apiUrl/${widget.answer!.id}"),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'user_id': userId,
            'question_id': widget.answer!.questionId,
            'answer': widget.answer!.answer,
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
    } else {
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'user_id': userId,
            'question_id': widget.questionId,
            'answer': newAnswer,
          }),
        );

        if (response.statusCode == 200) {
          print('Answer sent successfully');
          widget.reloadData();
        } else {
          print("Request failed with status: ${response.statusCode}");
          throw Exception('Failed to send answer');
        }
      } catch (e) {
        print("Request failed with exception: $e");
        throw Exception('Failed to send answer');
      }
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
                      focusNode: _focusNode,
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
