import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Either<Failure, void>> addData({
    required String path,
    required Map<String, dynamic> data,
    String? uid,
  }) async {
    try {
      if (uid != null) {
        await firestore.collection(path).doc(uid).set(data);
      } else {
        await firestore.collection(path).add(data);
      }
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getData({
    required String path,
    required String documentId,
  }) async {
    try {
      var doc = await firestore.collection(path).doc(documentId).get();
      if (!doc.exists) return Left(ServerFailure('Document not found'));
      return Right(doc.data()!);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getListData({
    required String path,
    required String documentId,
    required String listField,
  }) async {
    try {
      var doc = await firestore.collection(path).doc(documentId).get();
      if (!doc.exists) return Left(ServerFailure('Document not found'));
      final List list = doc.data()![listField] ?? [];
      return Right(list.map((e) => Map<String, dynamic>.from(e)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  Future<Either<Failure, List<Map<String, dynamic>>>> getCollection({
    required String path,
  }) async {
    try {
      final snapshot = await firestore.collection(path).get();
      return Right(
        snapshot.docs
            .map((doc) => {'id': doc.id, ...doc.data()})
            .toList(),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}