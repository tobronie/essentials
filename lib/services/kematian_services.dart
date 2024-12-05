import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/kematian_model.dart';

CollectionReference kematian =
    FirebaseFirestore.instance.collection('kematian');

class DbKematian {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection('kematian')
        .orderBy('tgl_upload', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getDataBySearch(String option, String query) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('kematian');
    Query queryRef = collectionRef;

    if (query.isNotEmpty) {
      queryRef = queryRef
          .where('judul', isGreaterThanOrEqualTo: query)
          .where('judul', isLessThanOrEqualTo: query + '\uf8ff');
    }

    return queryRef.snapshots();
  }

  static Future<void> addData({required KematianModel itemkematian}) async {
    await kematian.add(itemkematian.toJson());
  }

  static Future<void> deleteKematian(String documentId) async {
    try {
      await kematian.doc(documentId).delete();
    } catch (e) {
      print("Error deleting pengaduan: $e");
    }
  }
}
