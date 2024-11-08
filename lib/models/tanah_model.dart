import 'package:cloud_firestore/cloud_firestore.dart';

class TanahModel {
  final String foto_ktp;
  final String foto_kk;
  final String foto_sertifikat;
  final String foto_pbb;
  final String surat;
  final String nama;
  final int no_hp;
  final String email;
  final String surat_konfirmasi;

  TanahModel({
    required this.foto_ktp,
    required this.foto_kk,
    required this.foto_sertifikat,
    required this.foto_pbb,
    required this.surat,
    required this.nama,
    required this.no_hp,
    required this.email,
    required this.surat_konfirmasi,
  });

  Map<String, dynamic> toJson() {
    return {
      'foto_ktp': foto_ktp,
      'foto_kk': foto_kk,
      'foto_sertifikat': foto_sertifikat,
      'foto_pbb': foto_pbb,
      'surat': surat,
      'nama': nama,
      'no_hp': no_hp,
      'email': email,
      'surat_konfirmasi': surat_konfirmasi,
    };
  }

  factory TanahModel.fromJson(Map<String, dynamic> json) {
    return TanahModel(
      foto_ktp: json['foto_ktp'],
      foto_kk: json['foto_kk'],
      foto_sertifikat: json['foto_sertifikat'],
      foto_pbb: json['foto_pbb'],
      surat: json['surat'],
      nama: json['nama'],
      no_hp: json['no_hp'],
      email: json['email'],
      surat_konfirmasi: json['surat_konfirmasi'],
    );
  }

  factory TanahModel.fromSnapshot(DocumentSnapshot snapshot) {
    return TanahModel(
      foto_ktp: snapshot.get('foto_ktp'),
      foto_kk: snapshot.get('foto_kk'),
      foto_sertifikat: snapshot.get('foto_sertifikat'),
      foto_pbb: snapshot.get('foto_pbb'),
      surat: snapshot.get('surat'),
      nama: snapshot.get('nama'),
      no_hp: snapshot.get('no_hp'),
      email: snapshot.get('email'),
      surat_konfirmasi: snapshot.get('surat_konfirmasi'),
    );
  }
}
