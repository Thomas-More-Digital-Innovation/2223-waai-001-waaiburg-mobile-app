import 'package:http/http.dart' as http;
import 'dart:convert';

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

Future<List<QuestionList>> fetchQuestionList() async {
  final String apiUrl =
      'http://192.168.10.127:8000/api/questionList'; // API URL

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['questionLists'];
      List<QuestionList> questionListsList =
          data.map((model) => QuestionList.fromJson(model)).toList();

      return questionListsList;
    } else {
      print("Request failed with status: ${response.statusCode}");
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print("Request failed with exception: $e");
    throw Exception('Failed to load data');
  }
}
