import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedTextButton extends StatelessWidget {
  const RoundedTextButton(
      {required this.text,
      required this.textStyle,
      required this.color,
      required this.onPress});
  final String text;
  final TextStyle textStyle;
  final Color color;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onPress,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  text,
                  style: textStyle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
