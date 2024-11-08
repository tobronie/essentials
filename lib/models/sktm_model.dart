import 'package:cloud_firestore/cloud_firestore.dart';

class SKTMModel {
  final String foto_ktp;
  final String foto_kk;
  final String nama_wali;
  final String nominal;
  final String rincian;
  final String surat;
  final String nama;
  final int no_hp;
  final String email;
  final String surat_konfirmasi;

  SKTMModel({
    required this.foto_ktp,
    required this.foto_kk,
    required this.nama_wali,
    required this.nominal,
    required this.rincian,
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
      'nama_wali': nama_wali,
      'nominal': nominal,
      'rincian': rincian,
      'surat': surat,
      'nama': nama,
      'no_hp': no_hp,
      'email': email,
      'surat_konfirmasi': surat_konfirmasi,
    };
  }

  factory SKTMModel.fromJson(Map<String, dynamic> json) {
    return SKTMModel(
      foto_ktp: json['foto_ktp'],
      foto_kk: json['foto_kk'],
      nama_wali: json['nama_wali'],
      nominal: json['nominal'],
      rincian: json['rincian'],
      surat: json['surat'],
      nama: json['nama'],
      no_hp: json['no_hp'],
      email: json['email'],
      surat_konfirmasi: json['surat_konfirmasi'],
    );
  }

  factory SKTMModel.fromSnapshot(DocumentSnapshot snapshot) {
    return SKTMModel(
      foto_ktp: snapshot.get('foto_ktp'),
      foto_kk: snapshot.get('foto_kk'),
      nama_wali: snapshot.get('nama_wali'),
      nominal: snapshot.get('nominal'),
      rincian: snapshot.get('rincian'),
      surat: snapshot.get('surat'),
      nama: snapshot.get('nama'),
      no_hp: snapshot.get('no_hp'),
      email: snapshot.get('email'),
      surat_konfirmasi: snapshot.get('surat_konfirmasi'),
    );
  }
}
