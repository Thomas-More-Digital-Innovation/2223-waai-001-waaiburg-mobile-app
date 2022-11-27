import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:waaiburg_app/ui/components/headerBar.dart';
import 'package:waaiburg_app/ui/navigation/app_route_path.dart';
import 'package:waaiburg_app/ui/trianglePaint.dart';
import 'package:waaiburg_app/app_state.dart';
import 'package:waaiburg_app/ui/components/inloggen/rounded_button.dart';

class IngelogdMenuView extends StatelessWidget {
  const IngelogdMenuView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return HeaderBar(
      headerName: appState.voornaam,
      menuColor: Theme.of(context).colorScheme.secondary,
      painter: BackgroundPainter1(),
      body: Container(
        child:Stack(
          children: [
            ListView(
              children: [
                _ingelogdMenuItem("Mijn Doelenboom", ComingSoonPageConfig, context, appState),
                _ingelogdMenuItem("Begeleiders", BegeleidersPageConfig, context, appState),
                _ingelogdMenuItem("Mijn gegevens", MijnGegevensPageConfig, context, appState),
              ]
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: RoundedButton(
                  text: "Uitloggen",
                  onPressed: () => appState.logout(),
                  textColor: Theme.of(context).primaryColor,
                  color: Theme.of(context).primaryColorDark,
                )
              )
            ),
          ]
        )
      )      
    );
  }

  _ingelogdMenuItem(naam, pageConfig, context, appState) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => appState.currentAction = PageAction(state: PageState.addPage, page: pageConfig),
      child: Container(
        margin: EdgeInsets.only(top: 0), //size.height * 0.04
        width: size.width * 0.4,
        height: (size.height * 0.03) + 70, // padding + height textbox
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size.width * 0.1),
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 18.0),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.022),
                height: 120.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width * 0.10),
                    color: Color(0xFAFAFBFD),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10.0,
                          offset: Offset(0.0, 5.0),
                          spreadRadius: -2.5,
                          color: Theme.of(context).shadowColor)
                    ]
                  ),
                child: Center(
                  child: Text(
                    naam.toUpperCase(),
                    style: TextStyle(
                        fontSize: 26,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}