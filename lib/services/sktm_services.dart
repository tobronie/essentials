import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/sktm_model.dart';

CollectionReference sktm =
    FirebaseFirestore.instance.collection('sktm');

class DbSKTM {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection('sktm')
        .orderBy('tgl_upload', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getDataBySearch(String option, String query) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('sktm');
    Query queryRef = collectionRef;

    if (query.isNotEmpty) {
      queryRef = queryRef
          .where('judul', isGreaterThanOrEqualTo: query)
          .where('judul', isLessThanOrEqualTo: query + '\uf8ff');
    }

    return queryRef.snapshots();
  }

  static Future<void> addData({required SKTMModel itemsktm}) async {
    await sktm.add(itemsktm.toJson());
  }

  static Future<void> deleteSKTM(String documentId) async {
    try {
      await sktm.doc(documentId).delete();
    } catch (e) {
      print("Error deleting pengaduan: $e");
    }
  }
}
