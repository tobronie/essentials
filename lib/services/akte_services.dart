import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/akte_model.dart';

CollectionReference akte =
    FirebaseFirestore.instance.collection('akte');

class DbAkte {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection('akte')
        .orderBy('tgl_upload', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getDataBySearch(String option, String query) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('akte');
    Query queryRef = collectionRef;

    if (query.isNotEmpty) {
      queryRef = queryRef
          .where('judul', isGreaterThanOrEqualTo: query)
          .where('judul', isLessThanOrEqualTo: query + '\uf8ff');
    }

    return queryRef.snapshots();
  }

  static Future<void> addData({required AkteModel itemakte}) async {
    await akte.add(itemakte.toJson());
  }

  static Future<void> deleteAkte(String documentId) async {
    try {
      await akte.doc(documentId).delete();
    } catch (e) {
      print("Error deleting pengaduan: $e");
    }
  }
}
