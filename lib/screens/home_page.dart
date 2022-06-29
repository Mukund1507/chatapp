import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/screens/new_group_sheet.dart';
import '/screens/chat_page.dart';
import '../services/database.dart';
import '../widgets/roundedtextbutton.dart';
import '../widgets/grouptile.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String Username = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    setThings();
    super.initState();
  }

  List<String> groups = [];
  final Database _database = Database();
  void setThings() async {
    Username = await _firebaseAuth.currentUser?.email as String;
    groups = await _database.getMyGroups(Username);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('welcome'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return NewGroupSheet(
                      userName: Username, setThings: setThings);
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            RoundedTextButton(
              text: 'Your Groups',
              textStyle: const TextStyle(),
              color: Colors.amberAccent,
              onPress: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: groups.length,
                itemBuilder: (ctx, index) {
                  return GroupTile(
                    text: groups[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return ChatPage(
                              groupName: groups[index],
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
