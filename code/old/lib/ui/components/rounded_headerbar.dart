import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:waaiburg_app/main.dart';

class RoundedHeaderBar extends StatelessWidget {
  const RoundedHeaderBar(
      {Key key,
      this.headerName,
      this.body,
      this.menuColor = Colors.black,
      this.painter})
      : super(key: key);

  final String headerName;
  final Widget body;
  final Color menuColor;
  final CustomPainter painter;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(top: size.height * .18), // static value: 120.0
            child: body,
          ),
          Container(
            height: size.height * .20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              gradient: LinearGradient(colors: [
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColorLight,
              ], begin: Alignment.topLeft),
            ),
          ),
          Positioned(
            top: size.height * 0.005, // static value: 10.0
            left: 0.0,
            right: 0.0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              child: AppBar(
                elevation: 0,
                toolbarHeight: size.height * 0.12, // static value: 80
                backgroundColor: Colors.transparent,
                foregroundColor: menuColor,
                automaticallyImplyLeading: false, //pijltje
                leading: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.chevronLeft,
                  ),
                  iconSize: 40,
                  onPressed: () => Navigator.of(context).pop(),
                  //padding: EdgeInsets.all(30),
                ),
                title: Container(
                  padding: EdgeInsets.only(right: 45.0),
                  width: size.width * 0.8,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    headerName.stringFix.toUpperCase(),
                    maxLines: (headerName.wordCount() == 1) ? 1 : 2,
                    softWrap: false,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                centerTitle: true,
                titleSpacing: 10,
                actions: <Widget>[],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
