import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List<InfoSegment>> fetchInfoSegments() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/info'));

  if (response.statusCode == 200) {
    Iterable infoSegments = jsonDecode(response.body)["info's"][0];
    List<InfoSegment> infoSegmentsList = List<InfoSegment>.from(
        infoSegments.map((model) => InfoSegment.fromJson(model)));
    infoSegmentsList.sort((a, b) =>
        (a.orderNumber ?? 0).toInt().compareTo((b.orderNumber ?? 0).toInt()));
    return infoSegmentsList;
  } else {
    throw Exception(response.reasonPhrase);
  }
}

class InfoSegment {
  final int id;
  final int sectionId;
  final String title;
  final int? orderNumber;
  final String? createdAt;
  final String? updatedAt;

  const InfoSegment({
    required this.id,
    required this.sectionId,
    required this.title,
    this.orderNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory InfoSegment.fromJson(Map<String, dynamic> json) {
    return InfoSegment(
      id: json['id'],
      sectionId: json['section_id'],
      title: json['title'],
      orderNumber: json['orderNumber'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
