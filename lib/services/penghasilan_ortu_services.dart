import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/penghasilan_ortu_model.dart';

CollectionReference penghasilanortu =
    FirebaseFirestore.instance.collection('penghasilan_ortu');

class DbPenghasilanOrtu {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection('penghasilan_ortu')
        .orderBy('tgl_upload', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getDataBySearch(String option, String query) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('penghasilan_ortu');
    Query queryRef = collectionRef;

    if (query.isNotEmpty) {
      queryRef = queryRef
          .where('judul', isGreaterThanOrEqualTo: query)
          .where('judul', isLessThanOrEqualTo: query + '\uf8ff');
    }

    return queryRef.snapshots();
  }

  static Future<void> addData({required PenghasilanOrtuModel itempenghasilanortu}) async {
    await penghasilanortu.add(itempenghasilanortu.toJson());
  }

  static Future<void> deletePenghasilanOrtu(String documentId) async {
    try {
      await penghasilanortu.doc(documentId).delete();
    } catch (e) {
      print("Error deleting pengaduan: $e");
    }
  }
}
