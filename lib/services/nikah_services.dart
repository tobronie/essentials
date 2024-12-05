import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/nikah_model.dart';

CollectionReference nikah =
    FirebaseFirestore.instance.collection('nikah');

class DbNikah {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection('nikah')
        .orderBy('tgl_upload', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getDataBySearch(String option, String query) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('nikah');
    Query queryRef = collectionRef;

    if (query.isNotEmpty) {
      queryRef = queryRef
          .where('judul', isGreaterThanOrEqualTo: query)
          .where('judul', isLessThanOrEqualTo: query + '\uf8ff');
    }

    return queryRef.snapshots();
  }

  static Future<void> addData({required NikahModel itemnikah}) async {
    await nikah.add(itemnikah.toJson());
  }

  static Future<void> deleteNikah(String documentId) async {
    try {
      await nikah.doc(documentId).delete();
    } catch (e) {
      print("Error deleting pengaduan: $e");
    }
  }
}
