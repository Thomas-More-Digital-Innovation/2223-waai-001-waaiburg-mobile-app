import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waaiburg_app/data/repositories/authentication_repository.dart';
import 'package:waaiburg_app/ui/components/headerbar.dart';
import 'package:waaiburg_app/ui/components/inloggen/rounded_button.dart';
import 'package:waaiburg_app/ui/components/inloggen/rounded_password_field.dart';
import 'package:waaiburg_app/ui/components/inloggen/rounded_input_field.dart';
import 'package:waaiburg_app/ui/navigation/app_route_path.dart';
import 'package:waaiburg_app/ui/trianglePaint.dart';
import 'package:waaiburg_app/app_state.dart';
import 'package:waaiburg_app/ui/view/wachtwoord_vergeten_view.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // waardes worden buiten de build-methode opgeslagen,
  // bij reload van state gaan deze waardes niet verloren

  String email = '';
  String password = '';
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController wachtwoordEditingController = TextEditingController();

  final _emailFormKey = GlobalKey<FormFieldState>();
  final _passwordFormKey = GlobalKey<FormFieldState>();
  final _authenticatieRepository = AuthenticationRepository();

  Widget _loginResponse = SizedBox(height: 40);

  login(appState, email, wachtwoord) async {
    setState(() {
      _loginResponse = _loading();
    });
    var response = await _authenticatieRepository.login(email, wachtwoord);

    setState(() {
      if (response.status == true) {
        appState.login(response.token, response.voornaam);
      } else {
        _loginResponse = _loginFaildMessage(response.message);
      }
    });
  }

  _loading() {
    return SizedBox(
      height: 100,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _loginFaildMessage(message) {
    return SizedBox(
        height: 40,
        child: Center(
            child: Text(
          message,
          style: TextStyle(color: Color(0xFFF3D015), fontSize: 16),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: HeaderBar(
        headerName: "INLOGGEN",
        painter: BackgroundPainter3(),
        menuColor: Colors.white,
        body: Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // testing purposes
                  // Text(emailEditingController.text+"\n"+wachtwoordEditingController.text),
                  RoundedInputField(
                      textFieldKey: _emailFormKey,
                      controller: emailEditingController,
                      onChanged: (value) {
                        _emailFormKey.currentState.validate();
                        email = value;
                      },
                      label: "E-mailadres",
                      hintText: "E-mailadres",
                      keyboardType: TextInputType.emailAddress,
                      icon: FontAwesomeIcons.solidEnvelope,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ('Geen email ingevuld!');
                        }
                        return null;
                      }),
                  RoundedPasswordField(
                    controller: wachtwoordEditingController,
                    passwordKey: _passwordFormKey,
                    onChanged: (value) {
                      _passwordFormKey.currentState.validate();
                      password = value;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, right: 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          if (_emailFormKey.currentState.validate()) {
                            String email = emailEditingController.text;
                            appState.currentAction = PageAction(
                                state: PageState.addWidget,
                                widget: WachtwoordVergetenView(email: email),
                                page: WachtwoordVergetenPageConfig);
                          }
                        },
                        child: Text(
                          'Wachtwoord vergeten?',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: "log in",
                    onPressed: () {
                      String email = emailEditingController.text;
                      String wachtwoord = wachtwoordEditingController.text;

                      if (_formKey.currentState.validate()) {
                        // Process data.
                        login(appState, email, wachtwoord);
                      }
                    },
                  ),
                  Center(child: _loginResponse),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
