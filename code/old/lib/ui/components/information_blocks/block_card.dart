import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:waaiburg_app/data/models/information_block.dart';
import 'package:provider/provider.dart';
import 'package:waaiburg_app/main.dart';

import 'package:waaiburg_app/app_state.dart';
import 'package:waaiburg_app/ui/navigation/app_route_path.dart';
import 'package:waaiburg_app/ui/view/information_block_detail_view.dart';

class BlockCard extends StatelessWidget {
  final InformationBlock block;

  const BlockCard({Key key, @required this.block}) : super(key: key);

  static const List<Color> buttonColors = [
    Color(0xFFF6B651),
    Color(0xFFEB7B5C),
    Color(0xFF319EC2),
    Color(0xFF66B794),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    final double width = MediaQuery.of(context).size.width;

    return SizedBox(
      child: GestureDetector(
        onTap: () => {
          appState.currentAction = PageAction(
              state: PageState.addWidget,
              widget: InformationBlockDetailView(block: block),
              page: InformationBlockDetailPageConfig)
        },
        child: Stack(
          children: [
            Container(
              height: 120.0,
              padding: EdgeInsets.symmetric(horizontal: width * 0.022),
              margin:
                  EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 18.0),
              decoration: BoxDecoration(
                color: (block.blokFotoUrl.isNotEmpty &&
                        block.blokFotoUrl.length >= 5)
                    ? Colors.white
                    : buttonColors[block.volgordeNr % buttonColors.length],
                borderRadius: BorderRadius.circular(width * 0.10),
                boxShadow: [
                  BoxShadow(
                        blurRadius: 10.0,
                        offset: Offset(0.0, 5.0),
                        spreadRadius: -2.5,
                        color: Theme.of(context).shadowColor)
                ],
              ),
              child: Center(
                child: Stack(
                  children: [
                    if (block.blokFotoUrl.isNotEmpty &&
                        block.blokFotoUrl.length >= 5)
                      CachedNetworkImage(
                        imageUrl: block.blokFotoUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                Text(block.titel.stringFix),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    else
                      Center(
                        child: Text(
                          block.titel.stringFix.toUpperCase(),
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Inner-shadow voor knop
            /*Container(
              margin:
                  EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 18.0),
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [.8, 1.0],
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.grey[600].withOpacity(.18)
                  ],
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
