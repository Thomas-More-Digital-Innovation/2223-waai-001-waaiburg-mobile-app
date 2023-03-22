import 'dart:async';
import 'package:flutter_html/flutter_html.dart';
import 'package:mobileapp/api/info_content.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/components/header.dart';
import 'package:url_launcher/url_launcher.dart';

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
      extendBodyBehindAppBar: false,
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Html(
                    data: snapshot.data!
                            .firstWhere((i) => i.id == arg['infoId'])
                            .content ??
                        '<h1>No content</h1>',
                  ),
                  Row(
                    children: [
                      const Text('Meer Info: '),
                      InkWell(
                        child: Text(
                            '${snapshot.data!.firstWhere((i) => i.id == arg['infoId']).url}',
                            style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline)),
                        onTap: () => launchUrl(Uri.parse(snapshot.data!
                                .firstWhere((i) => i.id == arg['infoId'])
                                .url ??
                            '')),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          // show a loading spinner
          else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
