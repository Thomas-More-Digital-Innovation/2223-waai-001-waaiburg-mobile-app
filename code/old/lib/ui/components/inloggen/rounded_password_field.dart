import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {

  final ValueChanged<String> onChanged;
  final String Function(String) validator;
  final TextEditingController controller;
  final Key passwordKey;
  RoundedPasswordField(
      {Key key,
      this.onChanged,
      this.validator,
      this.controller,
      this.passwordKey})
      : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  final controller = TextEditingController();

  bool isHidden = true;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(
                left: size.width * 0.05, top: size.height * 0.01),
            child: Text("Wachtwoord",
                style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.white))),
        TextFieldContainer(
          child: TextFormField(
            controller: widget.controller,
            key: widget.passwordKey,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isHidden,
            autofillHints: [AutofillHints.password],
            onEditingComplete: () => TextInput.finishAutofillContext(),
            onChanged: widget.onChanged,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              hintText: "Wachtwoord",
              prefixIcon: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10.0),
                width: 65,
                child: FaIcon(
                  FontAwesomeIcons.key,
                  size: 36,
                  color: Colors.grey[400],
                ),
              ),
              suffixIcon: Container(
                alignment: Alignment.center,
                width: 40,
                child: IconButton(
                  onPressed: togglePasswordVisiblity,
                  icon: isHidden
                      ? FaIcon(
                          FontAwesomeIcons.eye,
                          size: 20,
                          color: Colors.grey[600],
                        )
                      : FaIcon(
                          FontAwesomeIcons.eyeSlash,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                ),
              ),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              contentPadding: EdgeInsets.only(right: 0.0, top: 22, bottom: 22),
              errorStyle: TextStyle(
                color: Color(0xFFf9e98e),
                fontSize: 14,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Geen wachtwoord ingevuld!';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  void togglePasswordVisiblity() => setState(() => isHidden = !isHidden);
}
