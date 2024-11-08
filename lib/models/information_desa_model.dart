import 'package:cloud_firestore/cloud_firestore.dart';

class InformationDesaModel {
  final String image;
  final String judul;
  final String isi;

  InformationDesaModel({
    required this.image,
    required this.judul,
    required this.isi,
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'judul': judul,
      'isi': isi,
    };
  }

  factory InformationDesaModel.fromJson(Map<String, dynamic> json) {
    return InformationDesaModel(
      image: json['image'],
      judul: json['judul'],
      isi: json['isi'],
    );
  }

  factory InformationDesaModel.fromSnapshot(DocumentSnapshot snapshot) {
    return InformationDesaModel(
      image: snapshot.get('image'),
      judul: snapshot.get('judul'),
      isi: snapshot.get('isi'),
    );
  }
}
