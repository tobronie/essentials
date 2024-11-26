import 'package:cloud_firestore/cloud_firestore.dart';

class UsahaModel {
  final String foto_ktp;
  final String foto_kk;
  final String omset;
  final String tgl_upload;
  final String nama;
  final String no_hp;
  final String email;
  final String surat_konfirmasi;

  UsahaModel({
    required this.foto_ktp,
    required this.foto_kk,
    required this.omset,
    required this.tgl_upload,
    required this.nama,
    required this.no_hp,
    required this.email,
    required this.surat_konfirmasi,
  });

  Map<String, dynamic> toJson() {
    return {
      'foto_ktp': foto_ktp,
      'foto_kk': foto_kk,
      'omset': omset,
      'tgl_upload': tgl_upload,
      'nama': nama,
      'no_hp': no_hp,
      'email': email,
      'surat_konfirmasi': surat_konfirmasi,
    };
  }

  factory UsahaModel.fromJson(Map<String, dynamic> json) {
    return UsahaModel(
      foto_ktp: json['foto_ktp'],
      foto_kk: json['foto_kk'],
      omset: json['omset'],
      tgl_upload: json['tgl_upload'],
      nama: json['nama'],
      no_hp: json['no_hp'],
      email: json['email'],
      surat_konfirmasi: json['surat_konfirmasi'],
    );
  }

  factory UsahaModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UsahaModel(
      foto_ktp: snapshot.get('foto_ktp'),
      foto_kk: snapshot.get('foto_kk'),
      omset: snapshot.get('omset'),
      tgl_upload: snapshot.get('tgl_upload'),
      nama: snapshot.get('nama'),
      no_hp: snapshot.get('no_hp'),
      email: snapshot.get('email'),
      surat_konfirmasi: snapshot.get('surat_konfirmasi'),
    );
  }
}
