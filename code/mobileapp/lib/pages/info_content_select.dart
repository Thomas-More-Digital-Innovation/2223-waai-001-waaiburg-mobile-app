import 'dart:async';
import 'package:mobileapp/api/info_content.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/components/header.dart';

class InfoContentSelected extends StatefulWidget {
  const InfoContentSelected({super.key});

  @override
  State<InfoContentSelected> createState() => _InfoContentSelectedState();
}

class _InfoContentSelectedState extends State<InfoContentSelected> {
  late Future<List<InfoContent>> futureInfoContents;

  @override
  void initState() {
    super.initState();
    futureInfoContents = fetchInfoContents();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Header(
        title: FutureBuilder<List<InfoContent>>(
          future: futureInfoContents,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return Text(snapshot.data!
                  .firstWhere((i) => i.id == arg['infoId'])
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
              return Text(snapshot.data!
                  .firstWhere((i) => i.id == arg['infoId'])
                  .content ?? 'No content');
            }
            // show a loading spinner
            else {
              return const CircularProgressIndicator();
            }
          },
        ),
    );
  }
}