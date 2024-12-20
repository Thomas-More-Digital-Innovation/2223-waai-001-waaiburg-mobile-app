import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<dynamic>> fetchQuestionList() async {
  const String apiUrl = 'http://10.0.2.2:8000/api/activeList'; // API URL
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.get('userToken');
  final userId = prefs.get('userId');

  try {
    final response = await http
        .get(Uri.parse(apiUrl), headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      // Fetch the questions
      Iterable questions = jsonDecode(response.body)['questions'][0];
      // Fetch the answers
      Iterable answers = jsonDecode(response.body)['answers'][0];

      List<Question> questionsList =
          questions.map((model) => Question.fromJson(model)).toList();

      List<Answer> answersList = answers
          .map((model) => Answer.fromJson(model))
          .where((answer) => answer.userId == userId)
          .toList();

      return Future.value([questionsList, answersList]);
    } else {
      print("Request failed with status: ${response.statusCode}");
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print("Request failed with exception: $e");
    throw Exception('Failed to load data');
  }
}

class QuestionList {
  final int id;
  final String title;

  QuestionList({
    required this.id,
    required this.title,
  });

  factory QuestionList.fromJson(Map<String, dynamic> json) {
    return QuestionList(
      id: json['id'],
      title: json['title'],
    );
  }
}

class Question {
  final int id;
  final int questionListId;
  final int treePartId;
  final String content;

  const Question({
    required this.id,
    required this.questionListId,
    required this.treePartId,
    required this.content,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionListId: json['question_list_id'],
      treePartId: json['tree_part_id'],
      content: json['content'],
    );
  }
}

class Answer {
  final int id;
  final int userId;
  final int questionId;
  late String answer;

  Answer({
    required this.id,
    required this.userId,
    required this.questionId,
    required this.answer,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      userId: json['user_id'],
      questionId: json['question_id'],
      answer: json['answer'],
    );
  }
}
