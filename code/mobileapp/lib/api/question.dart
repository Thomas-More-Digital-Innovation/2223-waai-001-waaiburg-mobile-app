import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List<Question>> fetchQuestion() async {
  try {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/questions'));

    if (response.statusCode == 200) {
      Iterable questions = jsonDecode(response.body)["questions"][0];
      List<Question> questionsList = List<Question>.from(
          questions.map((model) => Question.fromJson(model)));
      return questionsList;
    } else {
      throw Exception(response.reasonPhrase);
    }
  } catch (e) {
    print("This is the error message");
    throw Exception(e);
  }
}

class Question {
  final int id;
  final int treePartId;
  final String content;

  const Question({
    required this.id,
    required this.treePartId,
    required this.content,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      treePartId: json['section_id'],
      content: json['content'],
    );
  }
}
