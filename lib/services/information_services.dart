import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/information_model.dart';

CollectionReference information = FirebaseFirestore.instance.collection('information');

class DbInformation {
  static Stream<QuerySnapshot> getData() {
    return information.orderBy('timestamp', descending: true).snapshots();
  }

  static Future<void> addData({required InformationModel iteminformation}) async {
    await information.add(iteminformation.toJson());
  }

  static Future<void> deleteData(DocumentSnapshot<Object?> iteminformation) async {
    await information.doc(iteminformation.id).delete();
  }
}
