import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/information_desa_model.dart';

CollectionReference informationDesa = FirebaseFirestore.instance.collection('information_desa');

class DbInformationDesa {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance.collection('information_desa').orderBy('judul', descending: true).snapshots();
  }

  static Future<void> addData({required InformationDesaModel iteminformationDesa}) async {
    await informationDesa.add(iteminformationDesa.toJson());
  }

  static Future<void> deleteData(DocumentSnapshot<Object?> iteminformationDesa) async {
    await informationDesa.doc(iteminformationDesa.id).delete();
  }
}
