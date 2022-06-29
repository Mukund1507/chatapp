import 'package:flutter/material.dart';

import '../services/database.dart';

class NewGroupSheet extends StatelessWidget {
  NewGroupSheet({Key? key, required this.userName, required this.setThings})
      : super(key: key);
  String groupName = '';
  String userName;
  VoidCallback setThings;
  final Database _database = Database();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(8),
      child: TextField(
        onChanged: (val) {
          groupName = val;
        },
        onSubmitted: (val) async {
          await _database.addNewGroup(
            groupName,
            userName,
          );
          Navigator.pop(context);
        },
        decoration: const InputDecoration(hintText: 'enter group name'),
      ),
    );
  }
}
