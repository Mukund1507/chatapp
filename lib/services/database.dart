import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<String>> getMyGroups(String username) async {
    List<String> groups = [];
    var data = await _firebaseFirestore
        .collection('users')
        .doc(username)
        .collection('groups')
        .get();
    var groupsAsMap = data.docs.asMap();
    for (int i = 0; i < data.docs.length; i++) {
      String currentGroup = groupsAsMap[i]?['name'];
      groups.add(currentGroup);
    }
    return groups;
  }

  Future sendMessagee(String groupName, String userName, String message) async {
    await _firebaseFirestore
        .collection('groups')
        .doc(groupName)
        .collection('messages')
        .add({
      'datetime': DateTime.now(),
      'sender': userName,
      'message': message,
    });
  }

  Future<List<String>> usersInAGroup(String groupName) async {
    List<String> members = [];
    var data = await _firebaseFirestore
        .collection('groups')
        .doc(groupName)
        .collection('users')
        .get();
    final mapOfNames = data.docs.asMap();
    for (int i = 0; i < data.docs.length; i++) {
      final currentName = mapOfNames[i]?['name'];
      members.add(currentName);
    }
    return members;
  }

  Future addNewUserToGroup(String groupName, String userName) async {
    await _firebaseFirestore
        .collection('groups')
        .doc(groupName)
        .collection('users')
        .add({'name': userName});
    await _firebaseFirestore
        .collection('users')
        .doc(userName)
        .collection('groups')
        .add({'name': groupName});
  }

  Future addNewGroup(String groupName, String userName) async {
    await _firebaseFirestore
        .collection('groups')
        .doc(groupName)
        .collection('users')
        .add({'name': userName});
    await _firebaseFirestore
        .collection('groups')
        .doc(groupName)
        .collection('messages')
        .add({});
    await _firebaseFirestore
        .collection('users')
        .doc(userName)
        .collection('groups')
        .add({'name': groupName});
  }
}
