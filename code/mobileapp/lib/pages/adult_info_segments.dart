import 'package:flutter/material.dart';
import 'package:mobileapp/components/list_buttons.dart';
import 'package:mobileapp/components/header.dart';

class AdultInfoSegments extends StatefulWidget {
  const AdultInfoSegments({super.key});

  @override
  State<AdultInfoSegments> createState() => _AdultInfoSegmentsState();
}

class _AdultInfoSegmentsState extends State<AdultInfoSegments> {
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
      title: 'Adult info segments',
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: const Header(title: "Volwassenen"),
          body: ListButtons(list: volwassenen)),
    );
  }
}
