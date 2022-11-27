import 'package:flutter/material.dart';
import 'package:waaiburg_app/ui/components/headerbar.dart';
import 'package:waaiburg_app/ui/trianglePaint.dart';


class OptiesView extends StatefulWidget {
  OptiesView({Key key}) : super(key: key);

  @override
  _OptiesViewState createState() => _OptiesViewState();
}

class _OptiesViewState extends State<OptiesView> {

  @override
  Widget build(BuildContext context) {

    return HeaderBar(
      headerName: "INSTELLINGEN",
      painter: BackgroundPainter4(),
      menuColor: Colors.white,
      body: Container(
        child: Center(
          child: Text("Settings"),
        ),
      ),
    );
  }
}
