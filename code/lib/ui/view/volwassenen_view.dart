import 'package:flutter/material.dart';
import 'package:waaiburg_app/data/repositories/information_segment_repository.dart';
import 'package:waaiburg_app/ui/components/headerbar.dart';
import 'package:waaiburg_app/ui/components/information_segments/segment_list.dart';
import 'package:waaiburg_app/ui/trianglePaint.dart';

class VolwassenenView extends StatelessWidget {
  const VolwassenenView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeaderBar(
      headerName: "VOLWASSENEN",
      menuColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: SegmentList(
          jongerenOfVolwassenen: JongerenOfVolwassenen.Volwassenen,
        ),
      ),
      painter: BackgroundPainter1(),
    );
  }
}
