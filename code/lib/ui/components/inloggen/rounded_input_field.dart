import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waaiburg_app/ui/components/inloggen/text_field_container.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final Key textFieldKey;
  final IconData icon;
  final String label;
  final ValueChanged<String> onChanged;
  final String Function(String) validator;
  final TextInputType keyboardType;
  final TextEditingController controller;
  RoundedInputField(
      {Key key,
      this.hintText,
      @required this.icon,
      this.label = "",
      this.validator,
      this.keyboardType,
      this.textFieldKey,
      this.controller, this.onChanged})
      : super(key: key);

  @override
  _RoundedInputFieldState createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  final controller = TextEditingController();
  String text = "";

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void changeText(text) {
    setState(() {
      this.text = text;
    });
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
            child: Text(widget.label.toString(),
                style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.white))),
        TextFieldContainer(
          child: TextFormField(
            key: widget.textFieldKey,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            controller: widget.controller,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              hintText: widget.hintText,
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              prefixIcon: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10.0),
                width: 65,
                child: FaIcon(
                  widget.icon,
                  size: 36,
                  color: Colors.grey[400],
                ),
              ),
              contentPadding: EdgeInsets.only(right: 20.0, top: 22, bottom: 22),
              errorStyle: TextStyle(
                color: Color(0xFFf9e98e),
                fontSize: 14,
              ),
            ),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}