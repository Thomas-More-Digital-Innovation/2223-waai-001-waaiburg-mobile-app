import 'dart:async';
import 'package:mobileapp/api/info_content.dart';
import 'package:mobileapp/api/info.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/components/list_buttons.dart';
import 'package:mobileapp/components/header.dart';

class InfoContents extends StatefulWidget {
  final int infoId;
  const InfoContents({required this.infoId, super.key});

  @override
  State<InfoContents> createState() => _InfoContentsState();
}

class _InfoContentsState extends State<InfoContents> {
  late Future<List<InfoContent>> futureInfoContents;
  late Future<List<InfoSegment>> futureInfoSegments;

  @override
  void initState() {
    super.initState();
    futureInfoContents = fetchInfoContents();
    futureInfoSegments = fetchInfoSegments();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adult info segments',
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Header(
          title: FutureBuilder<List<InfoSegment>>(
            future: futureInfoSegments,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return Text(snapshot.data!
                    .firstWhere((i) => i.id == widget.infoId)
                    .title);
              }
              // show a loading spinner
              else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
        body: FutureBuilder<List<InfoContent>>(
          future: futureInfoContents,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return ListButtons(
                  list: snapshot.data!
                      .where((i) => i.infoId == widget.infoId)
                      .toList());
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
}
