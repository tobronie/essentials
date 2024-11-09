import 'package:cloud_firestore/cloud_firestore.dart';

class NikahModel {
  final String nama_pria;
  final String foto_ktp_pria;
  final String foto_kk_pria;
  final String foto_formulir_pria;
  final String nama_wanita;
  final String foto_ktp_wanita;
  final String foto_kk_wanita;
  final String foto_formulir_wanita;
  final String nama;
  final String no_hp;
  final String email;
  final String surat_konfirmasi;

  NikahModel({
    required this.nama_pria,
    required this.foto_ktp_pria,
    required this.foto_kk_pria,
    required this.foto_formulir_pria,
    required this.nama_wanita,
    required this.foto_ktp_wanita,
    required this.foto_kk_wanita,
    required this.foto_formulir_wanita,
    required this.nama,
    required this.no_hp,
    required this.email,
    required this.surat_konfirmasi,
  });

  Map<String, dynamic> toJson() {
    return {
      'nama_pria': nama_pria,
      'foto_ktp_pria': foto_ktp_pria,
      'foto_kk_pria': foto_kk_pria,
      'foto_formulir_pria': foto_formulir_pria,
      'nama_wanita': nama_wanita,
      'foto_ktp_wanita': foto_ktp_wanita,
      'foto_kk_wanita': foto_kk_wanita,
      'foto_formulir_wanita': foto_formulir_wanita,
      'nama': nama,
      'no_hp': no_hp,
      'email': email,
      'surat_konfirmasi': surat_konfirmasi,
    };
  }

  factory NikahModel.fromJson(Map<String, dynamic> json) {
    return NikahModel(
      nama_pria: json['nama_pria'],
      foto_ktp_pria: json['foto_ktp_pria'],
      foto_kk_pria: json['foto_kk_pria'],
      foto_formulir_pria: json['foto_formulir_pria'],
      nama_wanita: json['nama_wanita'],
      foto_ktp_wanita: json['foto_ktp_wanita'],
      foto_kk_wanita: json['foto_kk_wanita'],
      foto_formulir_wanita: json['foto_formulir_wanita'],
      nama: json['nama'],
      no_hp: json['no_hp'],
      email: json['email'],
      surat_konfirmasi: json['surat_konfirmasi'],
    );
  }

  factory NikahModel.fromSnapshot(DocumentSnapshot snapshot) {
    return NikahModel(
      nama_pria: snapshot.get('nama_pria'),
      foto_ktp_pria: snapshot.get('foto_ktp_pria'),
      foto_kk_pria: snapshot.get('foto_kk_pria'),
      foto_formulir_pria: snapshot.get('foto_formulir_pria'),
      nama_wanita: snapshot.get('nama_wanita'),
      foto_ktp_wanita: snapshot.get('foto_ktp_wanita'),
      foto_kk_wanita: snapshot.get('foto_kk_wanita'),
      foto_formulir_wanita: snapshot.get('foto_formulir_wanita'),
      nama: snapshot.get('nama'),
      no_hp: snapshot.get('no_hp'),
      email: snapshot.get('email'),
      surat_konfirmasi: snapshot.get('surat_konfirmasi'),
    );
  }
}
