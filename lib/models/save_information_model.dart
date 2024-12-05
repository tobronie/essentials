import 'package:cloud_firestore/cloud_firestore.dart';

class SaveInformation {
  String? id;
  String? image;
  String? judul;
  Timestamp? tgl_upload;
  String? kategori;
  String? isi;

  SaveInformation({
    required this.id,
    required this.image,
    required this.judul,
    required this.tgl_upload,
    required this.kategori,
    required this.isi,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'judul': judul,
      'tgl_upload': tgl_upload,
      'kategori': kategori,
      'isi': isi,
    };
  }
}
