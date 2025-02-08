// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:essentials/models/tanah_model.dart';

// CollectionReference tanah =
//     FirebaseFirestore.instance.collection('tanah');

// class DbTanah {
//   static Stream<QuerySnapshot> getData() {
//     return FirebaseFirestore.instance
//         .collection('tanah')
//         .orderBy('tgl_upload', descending: true)
//         .snapshots();
//   }

//   static Stream<QuerySnapshot> getDataBySearch(String option, String query) {
//     CollectionReference collectionRef =
//         FirebaseFirestore.instance.collection('tanah');
//     Query queryRef = collectionRef;

//     if (query.isNotEmpty) {
//       queryRef = queryRef
//           .where('judul', isGreaterThanOrEqualTo: query)
//           .where('judul', isLessThanOrEqualTo: query + '\uf8ff');
//     }

//     return queryRef.snapshots();
//   }

//   static Future<void> addData({required TanahModel itemtanah}) async {
//     await tanah.add(itemtanah.toJson());
//   }

//   static Future<void> deleteTanah(String documentId) async {
//     try {
//       await tanah.doc(documentId).delete();
//     } catch (e) {
//       print("Error deleting pengaduan: $e");
//     }
//   }
// }
