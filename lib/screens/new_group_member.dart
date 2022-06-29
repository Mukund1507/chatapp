import 'package:flutter/material.dart';

import '../services/database.dart';

class NewGroupMember extends StatelessWidget {
  NewGroupMember({Key? key, required this.groupName, required this.setThings})
      : super(key: key);
  String groupName;
  String newUserName = '';
  VoidCallback setThings;
  final Database _database = Database();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      height: double.infinity,
      child: TextField(
        onChanged: (val) {
          newUserName = val;
        },
        onSubmitted: (val) async {
          await _database.addNewUserToGroup(
              groupName, '$newUserName@gmail.com');
          Navigator.pop(context);
        },
        decoration: const InputDecoration(hintText: 'enter username'),
      ),
    );
  }
}
