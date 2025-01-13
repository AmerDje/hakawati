import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hakawati/core/errors/firebase_custom_exception.dart';
import 'package:hakawati/core/functions/logger.dart';
import 'package:hakawati/core/services/service_locator.dart';

class FirebaseFireStoreService {
  FirebaseFirestore firestore = sl.get<FirebaseFirestore>();

  Future<void> addData({required String path, required Map<String, dynamic> data, String? documentId}) async {
    try {
      if (documentId != null) {
        firestore.collection(path).doc(documentId).set(data);
      } else {
        await firestore.collection(path).add(data);
      }
    } on FirebaseException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleFirestoreError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: e.toString());
    }
  }

  Future<dynamic> getData({required String path, String? documentId, Map<String, dynamic>? query}) async {
    try {
      if (documentId != null) {
        // to get a single leave
        var data = await firestore.collection(path).doc(documentId).get();
        // return single document
        return data.data();
      } else {
        // to get multiple leaves
        Query<Map<String, dynamic>> data = firestore.collection(path);

        // Check if query map is provided
        if (query != null) {
          // Handle 'user_id' field
          if (query['user_id'] != null && query['user_id'] is String) {
            var userId = query['user_id'] as String;
            data = data.where('employee.uId', isEqualTo: userId);
          }

          // Handle 'user_id' field
          if (query['manager_id'] != null && query['manager_id'] is String) {
            var managerId = query['manager_id'] as String;
            data = data.where('manager.uId', isEqualTo: managerId);
          }
          // Handle 'department' field
          if (query['department'] != null && query['department'] is String) {
            var department = query['department'] as String;
            data = data.where('employee.department', isEqualTo: department);
          }
          // Handle 'manager_department' field
          if (query['manager_department'] != null && query['manager_department'] is String) {
            var department = query['manager_department'] as String;
            data = data.where('department', isEqualTo: department);
          }
          // Handle 'recent' field
          if (query['recent'] != null && query['recent'] is bool) {
            bool isRecent = query['recent'];
            if (isRecent) {
              data = data.where(
                'updated_at',
                isGreaterThanOrEqualTo: Timestamp.fromDate(
                  DateTime.now().subtract(
                    const Duration(days: 3),
                  ),
                ),
                isLessThanOrEqualTo: Timestamp.fromDate(DateTime.now()),
              );
            } else {
              data = data.where(
                'updated_at',
                isLessThanOrEqualTo: Timestamp.fromDate(
                  DateTime.now().subtract(
                    const Duration(days: 3),
                  ),
                ),
              );
            }
          }

          // Handle 'orderBy' field
          if (query['recipient_id'] != null && query['recipient_id'] is String) {
            var recipientId = query['recipient_id'] as String;
            data = data.where('recipient_id', isEqualTo: recipientId);
          }

          // Handle 'orderBy' field
          if (query['orderBy'] != null && query['orderBy'] is String) {
            var orderByField = query['orderBy'] as String;
            var descending = query['descending'] is bool ? query['descending'] as bool : false;
            data = data.orderBy(orderByField, descending: descending);
          }

          // Handle 'limit' field
          if (query['limit'] != null && query['limit'] is int) {
            var limit = query['limit'] as int;
            data = data.limit(limit);
          }
        }

        // return multiple documents
        var result = await data.get();
        return result.docs.map((e) => e.data()).toList();
      }
    } on FirebaseException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleFirestoreError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: e.toString());
    }
  }

  Future<void> updateData(
      {required String path, required String documentId, required Map<String, dynamic> data}) async {
    try {
      await firestore.collection(path).doc(documentId).update(data);
    } on FirebaseException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleFirestoreError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: e.toString());
    }
  }

  Future<void> deleteData({required String path, required String documentId}) async {
    try {
      await firestore.collection(path).doc(documentId).delete();
    } on FirebaseException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleFirestoreError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: e.toString());
    }
  }

  Future<bool> checkIfDataExists({required String path, required String documentId}) async {
    try {
      var data = await firestore.collection(path).doc(documentId).get();
      return data.exists;
    } on FirebaseException catch (e) {
      avoidLog(e);
      throw FirebaseCustomException.handleFirestoreError(e);
    } catch (e) {
      avoidLog(e);
      throw FirebaseCustomException(message: e.toString());
    }
  }
}
