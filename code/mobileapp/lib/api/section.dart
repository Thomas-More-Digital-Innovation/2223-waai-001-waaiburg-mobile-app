
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List<Section>> fetchSections() async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/section'));
    
  if (response.statusCode == 200) {
    Iterable sections = jsonDecode(response.body)["sections"][0];
    List<Section> sectionsList = List<Section>.from(
        sections.map((model) => Section.fromJson(model)));
    return sectionsList;
  } else {
    throw Exception(response.reasonPhrase);
  }
}

class Section {
  final int id;
  final String name;
  final String? createdAt;
  final String? updatedAt;

  const Section({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}