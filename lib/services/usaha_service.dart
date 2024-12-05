import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/usaha_model.dart';

CollectionReference usaha =
    FirebaseFirestore.instance.collection('usaha');

class DbUsaha {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection('usaha')
        .orderBy('tgl_upload', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getDataBySearch(String option, String query) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('usaha');
    Query queryRef = collectionRef;

    if (query.isNotEmpty) {
      queryRef = queryRef
          .where('judul', isGreaterThanOrEqualTo: query)
          .where('judul', isLessThanOrEqualTo: query + '\uf8ff');
    }

    return queryRef.snapshots();
  }

  static Future<void> addData({required UsahaModel itemusaha}) async {
    await usaha.add(itemusaha.toJson());
  }

  static Future<void> deleteUsaha(String documentId) async {
    try {
      await usaha.doc(documentId).delete();
    } catch (e) {
      print("Error deleting pengaduan: $e");
    }
  }
}
