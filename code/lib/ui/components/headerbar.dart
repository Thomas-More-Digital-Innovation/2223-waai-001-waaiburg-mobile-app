import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:waaiburg_app/main.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar(
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
      body: CustomPaint(
        painter: painter,
        child: Stack(
          children: <Widget>[
            Container(
              margin:
                  EdgeInsets.only(top: size.height * .18), //static value: 150.0
              child: body,
            ),
            Positioned(
              top: (size.height * (.18 - .12) - 50) / 2, // static value: 0
              left: 0.0,
              right: 0.0,
              child: AppBar(
                elevation: 0,
                toolbarHeight: size.height * .12, //static value: 80
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
                  padding: EdgeInsets.only(right: 50.0),
                  width: size.width * 0.8,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    headerName.stringFix.toUpperCase(),
                    maxLines: (headerName.wordCount() == 1)
                        ? 1
                        : 2, //controle op hoeveel woorden er in de headernaam zijn.
                    //Als dit 1 woord is, zal de AutoSizeText-widget deze niet
                    //proberen op te splitsen in meerdere lijnen
                    softWrap: false,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
                centerTitle: true,
                titleSpacing: 10,
                actions: <Widget>[],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
