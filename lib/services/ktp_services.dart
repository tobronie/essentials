import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/ktp_model.dart';

CollectionReference ktp =
    FirebaseFirestore.instance.collection('ktp');

class DbKTP {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection('ktp')
        .orderBy('tgl_upload', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getDataBySearch(String option, String query) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('ktp');
    Query queryRef = collectionRef;

    if (query.isNotEmpty) {
      queryRef = queryRef
          .where('judul', isGreaterThanOrEqualTo: query)
          .where('judul', isLessThanOrEqualTo: query + '\uf8ff');
    }

    return queryRef.snapshots();
  }

  static Future<void> addData({required KTPModel itemktp}) async {
    await ktp.add(itemktp.toJson());
  }

  static Future<void> deleteKTP(String documentId) async {
    try {
      await ktp.doc(documentId).delete();
    } catch (e) {
      print("Error deleting pengaduan: $e");
    }
  }
}
