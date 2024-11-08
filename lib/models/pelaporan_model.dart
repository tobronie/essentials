import 'package:cloud_firestore/cloud_firestore.dart';

class PelaporanModel {
  final String nama;
  final String image;
  final String judul;
  final String waktu;
  final String lokasi;
  final String isi;

  PelaporanModel({
    required this.nama,
    required this.image,
    required this.judul,
    required this.waktu,
    required this.lokasi,
    required this.isi,
  });

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'image': image,
      'judul': judul,
      'waktu': waktu,
      'lokasi': lokasi,
      'isi': isi,
    };
  }

  factory PelaporanModel.fromJson(Map<String, dynamic> json) {
    return PelaporanModel(
      nama: json['nama'],
      image: json['image'],
      judul: json['judul'],
      waktu: json['waktu'],
      lokasi: json['lokasi'],
      isi: json['isi'],
    );
  }

  factory PelaporanModel.fromSnapshot(DocumentSnapshot snapshot) {
    return PelaporanModel(
      nama: snapshot.get('nama'),
      image: snapshot.get('image'),
      judul: snapshot.get('judul'),
      waktu: snapshot.get('waktu'),
      lokasi: snapshot.get('lokasi'),
      isi: snapshot.get('isi'),
    );
  }
}
