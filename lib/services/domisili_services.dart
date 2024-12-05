import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/domisili_model.dart';

CollectionReference domisili =
    FirebaseFirestore.instance.collection('domisili');

class DbDomisili {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection('domisili')
        .orderBy('tgl_upload', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getDataBySearch(String option, String query) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('domisili');
    Query queryRef = collectionRef;

    if (query.isNotEmpty) {
      queryRef = queryRef
          .where('judul', isGreaterThanOrEqualTo: query)
          .where('judul', isLessThanOrEqualTo: query + '\uf8ff');
    }

    return queryRef.snapshots();
  }

  static Future<void> addData({required DomisiliModel itemdomisili}) async {
    await domisili.add(itemdomisili.toJson());
  }

  static Future<void> deleteDomisili(String documentId) async {
    try {
      await domisili.doc(documentId).delete();
    } catch (e) {
      print("Error deleting pengaduan: $e");
    }
  }
}
