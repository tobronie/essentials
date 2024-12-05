import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/kk_model.dart';

CollectionReference kk =
    FirebaseFirestore.instance.collection('kk');

class DbKK {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection('kk')
        .orderBy('tgl_upload', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getDataBySearch(String option, String query) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('kk');
    Query queryRef = collectionRef;

    if (query.isNotEmpty) {
      queryRef = queryRef
          .where('judul', isGreaterThanOrEqualTo: query)
          .where('judul', isLessThanOrEqualTo: query + '\uf8ff');
    }

    return queryRef.snapshots();
  }

  static Future<void> addData({required KKModel itemkk}) async {
    await kk.add(itemkk.toJson());
  }

  static Future<void> deleteKK(String documentId) async {
    try {
      await kk.doc(documentId).delete();
    } catch (e) {
      print("Error deleting pengaduan: $e");
    }
  }
}
