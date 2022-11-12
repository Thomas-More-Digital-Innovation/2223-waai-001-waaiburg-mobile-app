import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:waaiburg_app/data/models/information_block.dart';
import 'package:waaiburg_app/data/models/information_segment.dart';
import 'package:provider/provider.dart';
import 'package:waaiburg_app/data/repositories/information_block_repository.dart';
import 'package:waaiburg_app/main.dart';

import 'package:waaiburg_app/app_state.dart';
import 'package:waaiburg_app/ui/navigation/app_route_path.dart';
import 'package:waaiburg_app/ui/view/information_block_detail_view.dart';
import 'package:waaiburg_app/ui/view/information_block_list_view.dart';

class SegmentCard extends StatelessWidget {
  final InformationSegment segment;

  const SegmentCard({Key key, @required this.segment}) : super(key: key);

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
        onTap: () async {
          List<InformationBlock> blockList = await InformationBlockRepository()
              .getInfoBlocks(segment, fromCache: false);
          if (blockList.length == 1) {
            appState.currentAction = PageAction(
                state: PageState.addWidget,
                widget: InformationBlockDetailView(block: blockList[0]),
                page: InformationBlockDetailPageConfig);
          } else {
            appState.currentAction = PageAction(
                state: PageState.addWidget,
                widget: InformationBlockListView(segment: segment),
                page: InformationBlockListPageConfig);
          }
        },
        child: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 18.0),
              padding: EdgeInsets.symmetric(horizontal: width * 0.022),
              height: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.10),
                  color: buttonColors[segment.volgordeNr % buttonColors.length],
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10.0,
                        offset: Offset(0.0, 5.0),
                        spreadRadius: -2.5,
                        color: Theme.of(context).shadowColor)
                  ]),
              child: Center(
                child: Text(
                  segment.titel.stringFix.toUpperCase(),
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // inside shadow
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
