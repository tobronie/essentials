import 'package:cloud_firestore/cloud_firestore.dart';

class InformationModel {
  final String foto_info;
  final String judul_info;
  final Timestamp tgl_upload_info;
  final String kategori_info;
  final String isi_info;

  InformationModel({
    required this.foto_info,
    required this.judul_info,
    required this.tgl_upload_info,
    required this.kategori_info,
    required this.isi_info,
  });

  Map<String, dynamic> toJson() {
    return {
      'foto_info': foto_info,
      'judul_info': judul_info,
      'tgl_upload_info': tgl_upload_info,
      'kategori_info': kategori_info,
      'isi_info': isi_info,
    };
  }

  factory InformationModel.fromJson(Map<String, dynamic> json) {
    return InformationModel(
      foto_info: json['foto_info'],
      judul_info: json['judul_info'],
      tgl_upload_info: json['tgl_upload_info'] as Timestamp,
      kategori_info: json['kategori_info'],
      isi_info: json['isi_info'],
    );
  }

  factory InformationModel.fromSnapshot(DocumentSnapshot snapshot) {
    return InformationModel(
      foto_info: snapshot.get('foto_info'),
      judul_info: snapshot.get('judul_info'),
      tgl_upload_info: snapshot.get('tgl_upload_info') ?? Timestamp.now(),
      kategori_info: snapshot.get('kategori_info'),
      isi_info: snapshot.get('isi_info'),
    );
  }
}
