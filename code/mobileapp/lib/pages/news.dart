import 'dart:async';
import 'package:mobileapp/api/info.dart';
import 'package:mobileapp/api/info_content.dart';
import 'package:mobileapp/api/section.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/components/list_buttons.dart';
import 'package:mobileapp/components/header.dart';
import 'package:mobileapp/components/list_cards.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late Future<List<InfoSegment>> futureInfoSegments;
  late Future<List<InfoContent>> futureInfoContent;
  late Future<List<Section>> futureSection;
  late Future<List<dynamic>> futureNews;

  Future<List> fetchNews(sectionId) async {
    List test = await futureInfoSegments;
    List content = await futureInfoContent;
    List nieuwtje = [];
    for (var i in test.where((i) => i.sectionId == sectionId).toList()) {
      for (var j in content.where((j) => j.infoId == i.id).toList()) {
        nieuwtje.add(j);
      }
    }
    return nieuwtje;
  }

  @override
  void initState() {
    super.initState();
    futureInfoSegments = fetchInfoSegments();
    futureSection = fetchSections();
    futureInfoContent = fetchInfoContents();
    futureNews = fetchNews(3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: Header(
        bgcolor: Colors.transparent,
        titleColor: 0xFFFFFFFF,
        title: FutureBuilder<List<Section>>(
          future: futureSection,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return Text(snapshot.data!.firstWhere((i) => i.id == 3).name);
            }
            // show a loading spinner
            else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [Color(0xFFF25B58), Color(0xFFF38E3B)],
          ),
        ),
        child: FutureBuilder<List<dynamic>>(
          future: futureNews,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: snapshot.data!.asMap().entries.map((info) {
                  return ListCard(
                    route: '/infocontentselect',
                    infoId: info.value.id,
                    title: info.value.title.toUpperCase(),
                    subText: info.value.shortContent,
                    date: DateTime.parse(info.value.updatedAt),
                  );
                }).toList(),
              );
            }
            // show a loading spinnersnapshot.data!.where((i) => i.sectionId == 1).toList());
            else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  static const List<Color> buttonColors = [
    Color(0xFFF6B651),
    Color(0xFFEB7B5C),
    Color(0xFF319EC2),
    Color(0xFF66B794),
  ];

  GestureDetector buildButtonColumn(
      Color color, String label, int infoId, String pageRoute) {
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          pageRoute,
          arguments: <String, dynamic>{
            'infoId': infoId,
            'route': pageRoute,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 18.0),
        padding: EdgeInsets.symmetric(horizontal: width * 0.022),
        height: width / 4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.08),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[600]!,
              offset: const Offset(
                0.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: -1.5,
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
