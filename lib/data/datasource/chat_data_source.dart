import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDataSource {
  final FirebaseFirestore _firestore;

  ChatDataSource(this._firestore);

  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(String userId) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots();
  }
}
