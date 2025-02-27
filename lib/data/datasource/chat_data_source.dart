import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/data/model/message_model.dart';

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

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String chatRoomId) {
    return _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('sentTime', descending: true)
        .snapshots();
  }

  Future<void> sendMessage(
      String chatRoomId, String senderId, String content) async {
    final timestamp = Timestamp.now();
    final message = MessageModel(
      id: '',
      senderId: senderId,
      content: content,
      sentTime: timestamp,
    );

    final chatDoc = _firestore.collection('chats').doc(chatRoomId);
    final messageDoc = chatDoc.collection('messages').doc();
    final batch = _firestore.batch();

    batch.set(messageDoc, message.toJson());
    batch.update(chatDoc, {
      'lastMessage': content,
      'lastMessageSender': senderId,
      'lastMessageTime': timestamp,
      'unreadCount': FieldValue.increment(1),
    });

    batch.commit();
  }
}
