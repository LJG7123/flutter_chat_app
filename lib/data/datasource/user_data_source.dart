import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataSource {
  final FirebaseFirestore _firestore;

  UserDataSource(this._firestore);

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getUsers() async {
    final snapshot = await _firestore.collection('users').get();

    return snapshot.docs;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String userId) async {
    return _firestore.collection('users').doc(userId).get();
  }
}