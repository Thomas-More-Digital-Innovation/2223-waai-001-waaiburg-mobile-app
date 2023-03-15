import 'package:flutter/material.dart';
import 'package:mobileapp/components/list_buttons.dart';
import 'package:mobileapp/components/header.dart';

class InfoSegments extends StatefulWidget {
  const InfoSegments({super.key});

  @override
  State<InfoSegments> createState() => _InfoSegmentsState();
}

class _InfoSegmentsState extends State<InfoSegments> {
  List<String> volwassenen = [
    "Afdelingen",
    "Je dossier",
    "Verzekeringen",
    "Klachten",
    "Nuttige informatie",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info segments',
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: const Header(title: "Volwassenen"),
          body: ListButtons(list: volwassenen)),
    );
  }
}
