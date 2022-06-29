import 'package:flutter/material.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: ListTile(
          title: Text(
            text,
            style: const TextStyle(color: Colors.blueAccent, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
