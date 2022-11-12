import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaiburg_app/ui/components/headerBar.dart';
import 'package:waaiburg_app/ui/navigation/app_route_path.dart';
import 'package:waaiburg_app/ui/trianglePaint.dart';
import 'package:waaiburg_app/app_state.dart';
import 'package:waaiburg_app/data/repositories/loged_in_repository.dart';
import 'package:waaiburg_app/data/models/mijn_gegevens.dart';
import 'package:waaiburg_app/main.dart';

class MijnGegevensView extends StatefulWidget {
  const MijnGegevensView({Key key, this.gegevens}) : super(key: key);

  final MijnGegevens gegevens;

  @override
  _MijnGegevensViewState createState() => _MijnGegevensViewState(gegevens);
}

class _MijnGegevensViewState extends State<MijnGegevensView> {
  final _logedInRepository = LogedInRepository();

  MijnGegevens gegevens;

  bool isConnectedToInternet = true;

  _MijnGegevensViewState(this.gegevens);

  @override
  void initState() {
    super.initState();

    final appState = Provider.of<AppState>(context, listen: false);
    loadMijnGegevensDetails(appState);
  }

  loadMijnGegevensDetails(AppState appState) async {
    var gegevens = await _logedInRepository.getMijnGegevens(appState);

    if (gegevens == null ||
        gegevens.voornaam == null ||
        gegevens.voornaam.isEmpty) {
      setState(
        () {
          isConnectedToInternet = false;
        },
      );
    }
    if (gegevens != null) {
      setState(
        () {
          this.gegevens = gegevens;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return HeaderBar(
        headerName: "Mijn Gegevens",
        menuColor: Theme.of(context).colorScheme.secondary,
        painter: BackgroundPainter1(),
        body: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              if (isConnectedToInternet == false)
                Center(
                  child: Text(WaaiburgApp.NoInternetMessage),
                )
              else if (gegevens == null)
                Center(
                  heightFactor: 5,
                  child: CircularProgressIndicator(),
                )
              else
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
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
                        vertical: size.height * 0.02,
                        horizontal: size.width * 0.05),
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
                            gegevens.voornaam.toUpperCase() +
                                " " +
                                gegevens.achternaam.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        )),
                        Container(
                          margin: EdgeInsets.only(bottom: 30),
                            child: Center(
                          child: Text(
                            gegevens.afdelingen.join(', ').toUpperCase(),
                            style: GoogleFonts.poppins(
                              height: 1 / 2,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(.5),
                            ),
                          ),
                        )),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          margin: EdgeInsets.only(bottom: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "GEBOORTEDATUM: ",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: gegevens.geboorteDatum,
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
                          padding: EdgeInsets.only(top: 10),
                          margin: EdgeInsets.only(bottom: 10),
                          child: RichText(
                            text: TextSpan(
                                text: "ADRES: ",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: gegevens.straat + " " + gegevens.huisNr + ", " + gegevens.postcode + " " + gegevens.woonplaats,
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
                          padding: EdgeInsets.only(top: 10),
                          margin: EdgeInsets.only(bottom: 10),
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
                                    text: gegevens.telNummer,
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
                          padding: EdgeInsets.only(top: 10),
                          margin: EdgeInsets.only(bottom: 10),
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
                                    text: gegevens.email,
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
                  ),
                ),
            ],
          ),
        ));
  }
}
