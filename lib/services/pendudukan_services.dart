import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/pendudukan_model.dart';

CollectionReference pendudukan =
    FirebaseFirestore.instance.collection('pendudukan');

class DbPendudukan {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection('pendudukan')
        .orderBy('tgl_upload', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getDataBySearch(String option, String query) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('pendudukan');
    Query queryRef = collectionRef;

    if (query.isNotEmpty) {
      queryRef = queryRef
          .where('judul', isGreaterThanOrEqualTo: query)
          .where('judul', isLessThanOrEqualTo: query + '\uf8ff');
    }

    return queryRef.snapshots();
  }

  static Future<void> addData({required PendudukanModel itempendudukan}) async {
    await pendudukan.add(itempendudukan.toJson());
  }

  static Future<void> deletePendudukan(String documentId) async {
    try {
      await pendudukan.doc(documentId).delete();
    } catch (e) {
      print("Error deleting pengaduan: $e");
    }
  }
}
