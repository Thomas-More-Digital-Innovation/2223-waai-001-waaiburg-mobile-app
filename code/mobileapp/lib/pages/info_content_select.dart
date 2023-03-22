import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';
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

    final Uri _url = Uri.parse('https://flutter.dev');

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
                  Html(
                    data: snapshot.data!
                            .firstWhere((i) => i.id == arg['infoId'])
                            .url ??
                        '',
                    onLinkTap: (url, _, __, ___) {
                      String url = (snapshot.data!
                              .firstWhere((i) => i.id == arg['infoId'])
                              .url ??
                          '');
                      _launchUrl(url);
                    },
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

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
