import 'package:flutter/material.dart';

import 'package:waaiburg_app/ui/components/headerBar.dart';
import 'package:waaiburg_app/ui/trianglePaint.dart';
import 'package:waaiburg_app/data/repositories/authentication_repository.dart';

class WachtwoordVergetenView extends StatefulWidget {
  final String email;

  const WachtwoordVergetenView({Key key, this.email}) : super(key: key);

  @override
  _WachtwoordVergetenViewState createState() => _WachtwoordVergetenViewState();
}

class _WachtwoordVergetenViewState extends State<WachtwoordVergetenView> {
  final _authenticatieRepository = AuthenticationRepository();
  bool _isLoading = true;
  Widget _response;

  wachtwoordVergeten() async {
    var response =
        await _authenticatieRepository.wachtwoordVergeten(widget.email);

    setState(() {
      _isLoading = false;
      if (response.status == true) {
        _response = _linkIsVerzonden();
      } else {
        _response = _errorMessage(response.message);
      }
    });
  }

  void initState() {
    super.initState();

    wachtwoordVergeten();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderBar(
      headerName: "WACHTWOORD",
      menuColor: Theme.of(context).colorScheme.secondary,
      painter: BackgroundPainter1(),
      body: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: (_isLoading ? CircularProgressIndicator() : _response))),
    );
  }

  _linkIsVerzonden() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Een link is verzonden naar:",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            widget.email,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 25),
          Text(
            "Heb je de link na 5 min nog niet aangekregen. Kijk dan eens in je spam folder of probeer opnieuw.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 25),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondary),
            ),
            child: FractionallySizedBox(
              // widthFactor: 0.5,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "Terug naar login",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  softWrap: false,
                ),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ]);
  }

  _errorMessage(message) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 25),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondary),
            ),
            child: FractionallySizedBox(
              // widthFactor: 0.5,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "Terug naar login",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  softWrap: false,
                ),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ]);
  }
}
