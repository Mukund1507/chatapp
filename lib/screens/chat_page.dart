import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/screens/group_members_page.dart';
import '../widgets/message_bubble.dart';
import '../services/database.dart';
import '../models/message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.groupName}) : super(key: key);

  final String groupName;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String message = '';
  final Database _databasee = Database();
  late User _user;
  final TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    _user = firebaseAuth.currentUser as User;
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: const BorderSide(
        color: Colors.blueAccent,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return GroupMembersPage(groupName: widget.groupName);
                  },
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStream(groupName: widget.groupName),
            TextField(
              controller: textEditingController,
              onChanged: (val) {
                message = val;
              },
              decoration: InputDecoration(
                hintText: 'Message',
                enabledBorder: border,
                focusedBorder: border,
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () async {
                    try {
                      await _databasee.sendMessagee(
                          widget.groupName, _user.email as String, message);
                      textEditingController.clear();
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  MessageStream({Key? key, required this.groupName}) : super(key: key);
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final String groupName;

  @override
  Widget build(BuildContext context) {
    String currentUser = _firebaseAuth.currentUser?.email as String;
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore
            .collection('groups')
            .doc(groupName)
            .collection('messages')
            .orderBy('datetime')
            .snapshots(),
        builder: (ctx, snapshot) {
          final messages = snapshot.data?.docs.reversed;
          List<Messagee> groupMessages = [];
          if (messages != null) {
            for (var message in messages) {
              Messagee currentMessage = Messagee(
                  messageText: message['message'],
                  sentBy: message['sender'],
                  timeOfSent: message['datetime']);
              groupMessages.add(currentMessage);
            }
          }
          return Expanded(
              child: ListView(
            children: groupMessages
                .map<Widget>(
                  (mymessage) => MessageBubble(
                      sender: mymessage.sentBy,
                      text: mymessage.messageText,
                      isMe: (currentUser == mymessage.sentBy)),
                )
                .toList()
                .reversed
                .toList(),
          ));
        });
  }
}
