import 'package:cloud_firestore/cloud_firestore.dart';

class KTPModel {
  final String foto_akte;
  final String foto_kk;
  final String nama_anak;
  final String surat;
  final String nama;
  final int no_hp;
  final String email;
  final String surat_konfirmasi;

  KTPModel({
    required this.foto_akte,
    required this.foto_kk,
    required this.nama_anak,
    required this.surat,
    required this.nama,
    required this.no_hp,
    required this.email,
    required this.surat_konfirmasi,
  });

  Map<String, dynamic> toJson() {
    return {
      'foto_akte': foto_akte,
      'foto_kk': foto_kk,
      'nama_anak': nama_anak,
      'surat': surat,
      'nama': nama,
      'no_hp': no_hp,
      'email': email,
      'surat_konfirmasi': surat_konfirmasi,
    };
  }

  factory KTPModel.fromJson(Map<String, dynamic> json) {
    return KTPModel(
      foto_akte: json['foto_akte'],
      foto_kk: json['foto_kk'],
      nama_anak: json['nama_anak'],
      surat: json['surat'],
      nama: json['nama'],
      no_hp: json['no_hp'],
      email: json['email'],
      surat_konfirmasi: json['surat_konfirmasi'],
    );
  }

  factory KTPModel.fromSnapshot(DocumentSnapshot snapshot) {
    return KTPModel(
      foto_akte: snapshot.get('foto_akte'),
      foto_kk: snapshot.get('foto_kk'),
      nama_anak: snapshot.get('nama_anak'),
      surat: snapshot.get('surat'),
      nama: snapshot.get('nama'),
      no_hp: snapshot.get('no_hp'),
      email: snapshot.get('email'),
      surat_konfirmasi: snapshot.get('surat_konfirmasi'),
    );
  }
}
