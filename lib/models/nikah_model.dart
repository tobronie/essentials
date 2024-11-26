import 'package:cloud_firestore/cloud_firestore.dart';

class NikahModel {
  final String foto_nikah_ayah_pria;
  final String foto_nikah_ibu_pria;
  final String foto_akte_pria;
  final String foto_ktp_pria;
  final String foto_kk_pria;
  final String foto_formulir_pria;
  final String foto_nikah_ayah_wanita;
  final String foto_nikah_ibu_wanita;
  final String foto_akte_wanita;
  final String foto_ktp_wanita;
  final String foto_kk_wanita;
  final String foto_formulir_wanita;
  final String tgl_upload;
  final String nama;
  final String no_hp;
  final String email;
  final String surat_konfirmasi;

  NikahModel({
    required this.foto_nikah_ayah_pria,
    required this.foto_nikah_ibu_pria,
    required this.foto_ktp_pria,
    required this.foto_akte_pria,
    required this.foto_kk_pria,
    required this.foto_formulir_pria,
    required this.foto_nikah_ayah_wanita,
    required this.foto_nikah_ibu_wanita,
    required this.foto_ktp_wanita,
    required this.foto_akte_wanita,
    required this.foto_kk_wanita,
    required this.foto_formulir_wanita,
    required this.tgl_upload,
    required this.nama,
    required this.no_hp,
    required this.email,
    required this.surat_konfirmasi,
  });

  Map<String, dynamic> toJson() {
    return {
      'foto_nikah_ayah_pria': foto_nikah_ayah_pria,
      'foto_nikah_ibu_pria': foto_nikah_ibu_pria,
      'foto_akte_pria': foto_akte_pria,
      'foto_ktp_pria': foto_ktp_pria,
      'foto_kk_pria': foto_kk_pria,
      'foto_formulir_pria': foto_formulir_pria,
      'foto_nikah_ayah_wanita': foto_nikah_ayah_wanita,
      'foto_ktp_wanita': foto_ktp_wanita,
      'foto_nikah_ibu_wanita': foto_nikah_ibu_wanita,
      'foto_akte_wanita': foto_akte_wanita,
      'foto_kk_wanita': foto_kk_wanita,
      'foto_formulir_wanita': foto_formulir_wanita,
      'tgl_upload': tgl_upload,
      'nama': nama,
      'no_hp': no_hp,
      'email': email,
      'surat_konfirmasi': surat_konfirmasi,
    };
  }

  factory NikahModel.fromJson(Map<String, dynamic> json) {
    return NikahModel(
      foto_nikah_ayah_pria: json['foto_nikah_ayah_pria'],
      foto_nikah_ibu_pria: json['foto_nikah_ibu_pria'],
      foto_akte_pria: json['foto_akte_pria'],
      foto_ktp_pria: json['foto_ktp_pria'],
      foto_kk_pria: json['foto_kk_pria'],
      foto_formulir_pria: json['foto_formulir_pria'],
      foto_nikah_ayah_wanita: json['foto_nikah_ayah_wanita'],
      foto_ktp_wanita: json['foto_ktp_wanita'],
      foto_nikah_ibu_wanita: json['foto_nikah_ibu_wanita'],
      foto_akte_wanita: json['foto_akte_wanita'],
      foto_kk_wanita: json['foto_kk_wanita'],
      foto_formulir_wanita: json['foto_formulir_wanita'],
      tgl_upload: json['tgl_upload'],
      nama: json['nama'],
      no_hp: json['no_hp'],
      email: json['email'],
      surat_konfirmasi: json['surat_konfirmasi'],
    );
  }

  factory NikahModel.fromSnapshot(DocumentSnapshot snapshot) {
    return NikahModel(
      foto_nikah_ayah_pria: snapshot.get('foto_nikah_ayah_pria'),
      foto_nikah_ibu_pria: snapshot.get('foto_nikah_ibu_pria'),
      foto_ktp_pria: snapshot.get('foto_ktp_pria'),
      foto_akte_pria: snapshot.get('foto_akte_pria'),
      foto_kk_pria: snapshot.get('foto_kk_pria'),
      foto_formulir_pria: snapshot.get('foto_formulir_pria'),
      foto_nikah_ayah_wanita: snapshot.get('foto_nikah_ayah_wanita'),
      foto_ktp_wanita: snapshot.get('foto_ktp_wanita'),
      foto_nikah_ibu_wanita: snapshot.get('foto_nikah_ibu_wanita'),
      foto_akte_wanita: snapshot.get('foto_akte_wanita'),
      foto_kk_wanita: snapshot.get('foto_kk_wanita'),
      foto_formulir_wanita: snapshot.get('foto_formulir_wanita'),
      tgl_upload: snapshot.get('tgl_upload'),
      nama: snapshot.get('nama'),
      no_hp: snapshot.get('no_hp'),
      email: snapshot.get('email'),
      surat_konfirmasi: snapshot.get('surat_konfirmasi'),
    );
  }
}
