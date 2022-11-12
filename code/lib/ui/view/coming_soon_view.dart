import 'package:flutter/material.dart';
import 'package:waaiburg_app/ui/components/headerBar.dart';
import 'package:waaiburg_app/ui/trianglePaint.dart';


class ComingSoonView extends StatelessWidget {
  const ComingSoonView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeaderBar(
      headerName: "Coming Soon",
      menuColor: Theme.of(context).colorScheme.secondary,
      painter: BackgroundPainter1(),
      body: Center(
        child: Text("Coming Soon")
      )     
    );
  }
}