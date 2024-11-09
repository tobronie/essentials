import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/user_model.dart';

CollectionReference user = FirebaseFirestore.instance.collection('user');

class DbUser {
  static Stream<QuerySnapshot> getData() {
    return user.snapshots();
  }

  static Future<void> addData({required UserModel itemuser}) async {
    await user.add(itemuser.toJson());
  }

  static Future<void> updateData(
      {required DocumentSnapshot snapshot, required UserModel itemuser}) async {
    await user.doc(snapshot.id).update(itemuser.toJson());
  }

  static Future<List<QueryDocumentSnapshot<Object?>>> getUserByphoneNumber(
      String phoneNumber) {
    return user
        .where('no_hp', isEqualTo: phoneNumber)
        .get()
        .then((value) => value.docs);
  }

  static Future<void> deleteData(DocumentSnapshot<Object?> itemuser) async {
    await user.doc(itemuser.id).delete();
  }
}