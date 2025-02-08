import 'package:cloud_firestore/cloud_firestore.dart';

class PelaporanModel {
  final String foto_lapor;
  final String judul_lapor;
  final Timestamp waktu_lapor;
  final String lokasi_lapor;
  final String isi_lapor;
  final Timestamp tgl_upload_lapor;

  PelaporanModel({
    required this.foto_lapor,
    required this.judul_lapor,
    required this.waktu_lapor,
    required this.lokasi_lapor,
    required this.isi_lapor,
    required this.tgl_upload_lapor,
  });

  Map<String, dynamic> toJson() {
    return {
      'foto_lapor': foto_lapor,
      'judul_lapor': judul_lapor,
      'waktu_lapor': waktu_lapor,
      'lokasi_lapor': lokasi_lapor,
      'isi_lapor': isi_lapor,
      'tgl_upload_lapor': tgl_upload_lapor,
    };
  }

  factory PelaporanModel.fromJson(Map<String, dynamic> json) {
    return PelaporanModel(
      // nama: json['nama'],
      foto_lapor: json['foto_lapor'],
      judul_lapor: json['judul_lapor'],
      waktu_lapor: json['waktu_lapor'] as Timestamp,
      lokasi_lapor: json['lokasi_lapor'],
      isi_lapor: json['isi_lapor'],
      tgl_upload_lapor: json['tgl_upload_lapor'] as Timestamp,
    );
  }

  factory PelaporanModel.fromSnapshot(DocumentSnapshot snapshot) {
    return PelaporanModel(
      // nama: snapshot.get('nama'),
      foto_lapor: snapshot.get('foto_lapor'),
      judul_lapor: snapshot.get('judul_lapor'),
      waktu_lapor: snapshot.get('waktu_lapor') ?? Timestamp,
      lokasi_lapor: snapshot.get('lokasi_lapor'),
      isi_lapor: snapshot.get('isi_lapor'),
      tgl_upload_lapor: snapshot.get('tgl_upload_lapor') ?? Timestamp.now(),
    );
  }
}
