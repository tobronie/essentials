import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/pelaporan_model.dart';

CollectionReference pelaporan =
    FirebaseFirestore.instance.collection('pelaporan');

class DbPelaporan {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection('pelaporan')
        .orderBy('tgl_upload', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getDataBySearch(String option, String query) {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('pelaporan');
    Query queryRef = collectionRef;

    if (query.isNotEmpty) {
      queryRef = queryRef
          .where('judul', isGreaterThanOrEqualTo: query)
          .where('judul', isLessThanOrEqualTo: query + '\uf8ff');
    }

    return queryRef.snapshots();
  }

  static Future<void> addData({required PelaporanModel itempelaporan}) async {
    try {
      await pelaporan.add({
        'judul': itempelaporan.judul,
        'waktu': itempelaporan.waktu,
        'lokasi': itempelaporan.lokasi,
        'tgl_upload': Timestamp.now(),
        'image': itempelaporan.image,
        'isi': itempelaporan.isi,
      });
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deletePelaporan(String documentId) async {
    try {
      await pelaporan.doc(documentId).delete();
    } catch (e) {
      print("Error deleting pengaduan: $e");
    }
  }
}
