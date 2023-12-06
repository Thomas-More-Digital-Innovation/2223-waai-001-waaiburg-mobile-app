import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(const TestLottie());

class TestLottie extends StatefulWidget {
  const TestLottie({Key? key}) : super(key: key);

  @override
  State<TestLottie> createState() => _TestLottieState();
}

class _TestLottieState extends State<TestLottie> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _state = 0;

  final treeStates = const {
    1: 'zaadje.json',
    2: 'stam.json',
    3: 'takken.json',
    4: 'bladeren.json',
    5: 'appels.json',
    6: 'vogels.json'
  };

  void _updateTreeState(String direction) {
    setState(() {
      if (direction == "Forward") {
        if (_state < 6) {
          _state += 1;
          // Reset the controller to the beginning after the state update.
          _controller.reset();
        }
      } else if (direction == "Backward") {
        if (_state > 0) {
          _state -= 1;
          // Reset the controller to the beginning after the state update.
          _controller.reset();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            if (_state == 0)
              // Show the initial image when _state is 0.
              Image.asset('assets/tree_of_life/beginScreen.png')
            else
              // Show the Lottie animation when _state is not 0.
              Lottie.asset(
                'assets/tree_of_life/${treeStates[_state]}',
                controller: _controller,
                onLoaded: (composition) {
                  // Configure the AnimationController with the duration of the
                  // Lottie file and start the animation.
                  _controller
                    ..duration = composition.duration
                    ..forward();
                },
              ),
            Row(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    _updateTreeState("Backward");
                  },
                  tooltip: 'Backward',
                  child: const Icon(Icons.arrow_left),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _updateTreeState("Forward");
                  },
                  tooltip: 'Forward',
                  child: const Icon(Icons.arrow_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
