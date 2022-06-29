import 'package:chatapp/screens/new_group_member.dart';
import 'package:chatapp/services/database.dart';
import 'package:flutter/material.dart';

class GroupMembersPage extends StatefulWidget {
  static const routeName = '/groupMemebersPage';
  const GroupMembersPage({Key? key, required this.groupName}) : super(key: key);
  final String groupName;

  @override
  State<GroupMembersPage> createState() => _GroupMembersPageState();
}

class _GroupMembersPageState extends State<GroupMembersPage> {
  @override
  void initState() {
    setThings();
    super.initState();
  }

  List<String> members = [];

  final Database _database = Database();
  void setThings() async {
    members = await _database.usersInAGroup(widget.groupName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('your friends'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return NewGroupMember(
                      groupName: widget.groupName,
                      setThings: setThings,
                    );
                  },
                );
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: members.length,
          itemBuilder: (ctx, index) {
            return Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  members[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
