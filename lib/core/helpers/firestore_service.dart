import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? uid,
  }) async {
    if (uid != null) {
      await firestore.collection(path).doc(uid).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  Future<Map<String, dynamic>?> getData({
    required String path,
    String? documentId,
  }) async {
    var doc = await firestore.collection(path).doc(documentId).get();

    return doc.data();
  }
}
