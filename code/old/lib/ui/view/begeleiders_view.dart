import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:waaiburg_app/ui/components/headerBar.dart';
import 'package:waaiburg_app/ui/trianglePaint.dart';
import 'package:waaiburg_app/app_state.dart';

import 'package:waaiburg_app/data/repositories/loged_in_repository.dart';
import 'package:waaiburg_app/data/models/begeleider.dart';
import 'package:waaiburg_app/main.dart';

class BegeleidersView extends StatefulWidget {
  const BegeleidersView({Key key, this.begeleiders}) : super(key: key);

  final List<Begeleider> begeleiders;

  @override
  _BegeleidersViewState createState() => _BegeleidersViewState(begeleiders);
}

class _BegeleidersViewState extends State<BegeleidersView> {
  final _logedInRepository = LogedInRepository();

  List<Begeleider> begeleiders;

  bool isConnectedToInternet = true;

  _BegeleidersViewState(this.begeleiders);

  @override
  void initState() {
    super.initState();

    final appState = Provider.of<AppState>(context, listen: false);
    loadBegeleiders(appState);
  }

  loadBegeleiders(AppState appState) async {
    var begeleiders = await _logedInRepository.getBegeleiders(appState);

    if (begeleiders == null || begeleiders.isEmpty) {
      setState(
        () {
          isConnectedToInternet = false;
        },
      );
    }
    if (begeleiders != null) {
      setState(
        () {
          this.begeleiders = begeleiders;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return HeaderBar(
      headerName: "Begeleiders",
      menuColor: Theme.of(context).colorScheme.secondary,
      painter: BackgroundPainter1(),
      body: Center(
        child: Stack(
          children: [
            if (isConnectedToInternet == false)
              Center(
                child: Text(WaaiburgApp.NoInternetMessage),
              )
            else if (begeleiders == null)
              Center(
                heightFactor: 5,
                child: CircularProgressIndicator(),
              )
            else
              ListView(
                  children: begeleiders
                      .map((Begeleider b) => _begeleiderComponent(b))
                      .toList())
          ],
        ),
      ),
    );
  }

  Widget _begeleiderComponent(Begeleider begeleider) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        //border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 8,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      width: size.width * 0.8,
      margin: EdgeInsets.symmetric(
          vertical: size.height * 0.02, horizontal: size.width * 0.05),
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.03,
          horizontal: size.width * 0.05), // padding + height textbox
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              child: Center(
            child: Text(
              begeleider.voornaam.toUpperCase() +
                  " " +
                  begeleider.achternaam.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          )),
          Container(
              child: Center(
            child: Text(
              begeleider.afdelingen.join(', ').toUpperCase(),
              style: GoogleFonts.poppins(
                height: 1 / 2,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.secondary.withOpacity(.5),
              ),
            ),
          )),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: RichText(
              text: TextSpan(
                  text: "TEL: ",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: begeleider.telnummer,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    )
                  ]),
            ),
          ),
          Container(
            child: RichText(
              text: TextSpan(
                  text: "E-MAIL: ",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: begeleider.email,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
