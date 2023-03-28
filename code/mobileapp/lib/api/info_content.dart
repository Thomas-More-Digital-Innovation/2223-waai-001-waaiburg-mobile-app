import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List<InfoContent>> fetchInfoContents() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/infoContent'));

  if (response.statusCode == 200) {
    Iterable infoContents = jsonDecode(response.body)["infoContents"][0];
    List<InfoContent> infoContentsList = List<InfoContent>.from(
        infoContents.map((model) => InfoContent.fromJson(model)));
    infoContentsList.sort((a, b) =>
        (a.orderNumber ?? 0).toInt().compareTo((b.orderNumber ?? 0).toInt()));
    return infoContentsList;
  } else {
    throw Exception(response.reasonPhrase);
  }
}

class InfoContent {
  final int id;
  final int infoId;
  final String title;
  final String? titleImage;
  final String? url;
  final String? shortContent;
  final String? content;
  final int? orderNumber;
  final String? createdAt;
  final String? updatedAt;

  const InfoContent({
    required this.id,
    required this.infoId,
    required this.title,
    this.titleImage,
    this.url,
    this.shortContent,
    this.content,
    this.orderNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory InfoContent.fromJson(Map<String, dynamic> json) {
    return InfoContent(
      id: json['id'],
      infoId: json['info_id'],
      title: json['title'],
      titleImage: json['titleImage'],
      url: json['url'],
      shortContent: json['shortContent'],
      content: json['content'],
      orderNumber: json['orderNumber'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
