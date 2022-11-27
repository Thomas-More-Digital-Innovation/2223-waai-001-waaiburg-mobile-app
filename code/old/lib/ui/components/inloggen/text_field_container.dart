import 'package:flutter/material.dart';

class TextFieldContainer extends StatefulWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _TextFieldContainerState createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  @override
  
    Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin:
          EdgeInsets.only(top: size.height * 0.01, bottom: size.height * 0.03),
      child: widget.child,
    );
  
  }
}