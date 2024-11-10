import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/information_model.dart';

CollectionReference information =
    FirebaseFirestore.instance.collection('information');

class DbInformation {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance
        .collection('information')
        .orderBy('tgl_upload', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> getDataByCategoryAndSearch(
      String category, String searchQuery) {
    Query query = FirebaseFirestore.instance.collection('information');

    if (category != 'Semua') {
      query = query.where('kategori', isEqualTo: category);
    }

    if (searchQuery.isNotEmpty) {
      query = query
          .where('judul', isGreaterThanOrEqualTo: searchQuery)
          .where('judul', isLessThanOrEqualTo: searchQuery + '\uf8ff');
    }

    return query.snapshots();
  }

  static Future<void> addData(
      {required InformationModel iteminformation}) async {
    try {
      await information.add({
        'judul': iteminformation.judul,
        'kategori': iteminformation.kategori,
        'tgl_upload': iteminformation.tgl_upload,
        'image': iteminformation.image,
      });
    } catch (e) {
      rethrow;
    }
  }
}
