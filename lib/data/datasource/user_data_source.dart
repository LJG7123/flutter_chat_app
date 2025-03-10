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

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getUsersWithFilter(
      DateTime? min, DateTime? max, Set<String> genders) async {
    final ref = _firestore.collection('users');

    var filtered = min != null
        ? ref.where('dob', isGreaterThanOrEqualTo: Timestamp.fromDate(min))
        : ref;
    filtered = max != null
        ? filtered.where('dob', isLessThanOrEqualTo: Timestamp.fromDate(max))
        : filtered;
    filtered = genders.isNotEmpty
        ? filtered.where('gender', whereIn: genders)
        : filtered;

    final snapshot = await filtered.get();
    return snapshot.docs;
  }

  Future<void> createUser(String userId, String email, String name,
      DateTime dob, String gender) async {
    return _firestore.collection('users').doc(userId).set({
      'email': email,
      'name': name,
      'dob': Timestamp.fromDate(dob),
      'gender': gender,
      'isReceptionAllowed': true,
    });
  }

  Future<AggregateQuerySnapshot> getEmailCount(String email) {
    return _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .count()
        .get();
  }

  Future<void> updateToken(String userId, String? token) {
    return _firestore
        .collection('users')
        .doc(userId)
        .update({'fcmToken': token});
  }

  Future<void> updateReceptionAllowed(String userId, bool value) {
    return _firestore
        .collection('users')
        .doc(userId)
        .update({'isReceptionAllowed': value});
  }
}
