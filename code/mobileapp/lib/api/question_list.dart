import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<QuestionList>> fetchQuestionList() async {
  const String apiUrl = 'https://dewaaiburgapp.eu/api/activeList'; // API URL

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.get('userToken');

  print('Token');
  print(token);
  try {
    final response = await http
        .get(Uri.parse(apiUrl), headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['questionLists'][0];
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
