import 'dart:async';
import 'package:mobileapp/api/info.dart';
import 'package:mobileapp/api/section.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/components/list_buttons.dart';
import 'package:mobileapp/components/header.dart';

class InfoSegments extends StatefulWidget {
  final int sectionId;
  const InfoSegments({required this.sectionId, super.key});

  @override
  State<InfoSegments> createState() => _InfoSegmentsState();
}

class _InfoSegmentsState extends State<InfoSegments> {
  late Future<List<InfoSegment>> futureInfoSegments;
  late Future<List<Section>> futureSection;

  @override
  void initState() {
    super.initState();
    futureInfoSegments = fetchInfoSegments();
    futureSection = fetchSections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Header(
        title: FutureBuilder<List<Section>>(
          future: futureSection,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return Text(snapshot.data!
                  .firstWhere((i) => i.id == widget.sectionId)
                  .name);
            }
            // show a loading spinner
            else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      body: FutureBuilder<List<InfoSegment>>(
        future: futureInfoSegments,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListButtons(
                list: snapshot.data!
                    .where((i) => i.sectionId == widget.sectionId)
                    .toList());
          }
          // show a loading spinnersnapshot.data!.where((i) => i.sectionId == 1).toList());
          else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
