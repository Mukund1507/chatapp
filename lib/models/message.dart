import 'package:cloud_firestore/cloud_firestore.dart';

class Messagee {
  String messageText;
  String sentBy;
  Timestamp timeOfSent;
  Messagee(
      {required this.messageText,
      required this.sentBy,
      required this.timeOfSent});
}
