import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
    Message({
    required this.text,
    required this.timeStamp,
    this.email,
    this.reference,
  });

  final String text;
  final DateTime timeStamp;
  final String? email;
  DocumentReference? reference;


  factory Message.fromJSON(Map<String, dynamic> json) {
    return Message(
        text: json['text'] as String,
        timeStamp: DateTime.parse(json['timeStamp'] as String),
        email: json['email'] as String?);
  }

  Map<String, dynamic> toJSON() =>
      {'text': text, 'timeStamp': timeStamp.toString(), 'email': email};

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    final message = Message.fromJSON(snapshot.data() as Map<String, dynamic>);
    //message.reference = snapshot.reference;
    return message;
  }
}
