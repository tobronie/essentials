import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/information_desa_model.dart';

CollectionReference information_desa = FirebaseFirestore.instance.collection('information_desa');

class DbInformation_Desa {
  static Stream<QuerySnapshot> getData() {
    return FirebaseFirestore.instance.collection('information_desa').snapshots();
  }

  static Future<void> addData({required InformationDesaModel iteminformation_desa}) async {
    await information_desa.add(iteminformation_desa.toJson());
  }

  static Future<void> deleteData(DocumentSnapshot<Object?> iteminformation_desa) async {
    await information_desa.doc(iteminformation_desa.id).delete();
  }
}
