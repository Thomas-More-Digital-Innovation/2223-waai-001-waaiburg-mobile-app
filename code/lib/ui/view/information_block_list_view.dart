import 'package:flutter/material.dart';
import 'package:waaiburg_app/data/models/information_segment.dart';
import 'package:waaiburg_app/ui/components/headerbar.dart';
import 'package:waaiburg_app/ui/components/information_blocks/block_list.dart';

import '../trianglePaint.dart';

class InformationBlockListView extends StatelessWidget {
  final InformationSegment segment;

  const InformationBlockListView({Key key, this.segment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeaderBar(
      headerName: segment.titel,
      body: BlockList(segment: segment),
      menuColor: Theme.of(context).colorScheme.secondary,
      painter: BackgroundPainter1(),
    );
  }
}
