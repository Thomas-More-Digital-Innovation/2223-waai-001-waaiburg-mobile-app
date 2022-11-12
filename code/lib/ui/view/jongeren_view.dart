import 'package:flutter/material.dart';
import 'package:waaiburg_app/data/repositories/information_segment_repository.dart';
import 'package:waaiburg_app/ui/components/headerbar.dart';
import 'package:waaiburg_app/ui/components/information_segments/segment_list.dart';

import '../trianglePaint.dart';

class JongerenView extends StatelessWidget {
  const JongerenView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeaderBar(
      headerName: "Jongeren",
	    menuColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: SegmentList(jongerenOfVolwassenen: JongerenOfVolwassenen.Jongeren,),
      ),
      painter: BackgroundPainter1(),
    );
  }
}
