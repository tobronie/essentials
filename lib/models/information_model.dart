import 'package:cloud_firestore/cloud_firestore.dart';

class InformationModel {
  final String image;
  final String judul;
  final Timestamp tgl_upload;
  final String kategori;
  final String isi;

  InformationModel({
    required this.image,
    required this.judul,
    required this.tgl_upload,
    required this.kategori,
    required this.isi,
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'judul': judul,
      'tgl_upload': tgl_upload,
      'kategori': kategori,
      'isi': isi,
    };
  }

  factory InformationModel.fromJson(Map<String, dynamic> json) {
    return InformationModel(
      image: json['image'],
      judul: json['judul'],
      tgl_upload: json['tgl_upload'] as Timestamp,
      kategori: json['kategori'],
      isi: json['isi'],
    );
  }

  factory InformationModel.fromSnapshot(DocumentSnapshot snapshot) {
    return InformationModel(
      image: snapshot.get('image'),
      judul: snapshot.get('judul'),
      tgl_upload: snapshot.get('tgl_upload') ?? Timestamp.now(),
      kategori: snapshot.get('kategori'),
      isi: snapshot.get('isi'),
    );
  }
}
