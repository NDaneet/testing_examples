import 'message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageDAO {
 final CollectionReference collection =
      FirebaseFirestore.instance.collection('message');

  void sendMessage(Message message){
    collection.add(message.toJSON());
  }

  Stream<QuerySnapshot> getMessageStream(){
    return collection.snapshots();
  }
}
