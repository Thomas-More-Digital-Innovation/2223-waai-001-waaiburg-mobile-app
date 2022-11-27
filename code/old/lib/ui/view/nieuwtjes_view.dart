import 'package:flutter/material.dart';
import 'package:waaiburg_app/ui/components/headerbar.dart';
import 'package:waaiburg_app/ui/components/nieuwtjes/article_list.dart';

import '../trianglePaint.dart';

class NieuwtjesView extends StatelessWidget {
  const NieuwtjesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeaderBar(
      headerName: "NIEUWTJES",
      body: ArticleList(),
      menuColor: Colors.white,
      painter: BackgroundPainter3(),
    );
  }
}
