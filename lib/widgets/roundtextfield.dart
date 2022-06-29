import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField(
      {Key? key,
      required this.onChange,
      required this.onSubmit,
      required this.hintText,
      required this.secureText})
      : super(key: key);
  final Function(String) onChange;
  final Function(String) onSubmit;
  final String hintText;
  final bool secureText;
  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: const BorderSide(
        color: Colors.amberAccent,
      ),
    );
    return TextField(
      onChanged: onChange,
      onSubmitted: onSubmit,
      obscureText: secureText,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}
