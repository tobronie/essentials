import 'package:cloud_firestore/cloud_firestore.dart';

class PendudukanModel {
  final String foto_ktp;
  final String foto_kk;
  final String daerah_asal;
  final String daerah_tujuan;
  final String surat;
  final String nama;
  final String no_hp;
  final String email;
  final String surat_konfirmasi;

  PendudukanModel({
    required this.foto_ktp,
    required this.foto_kk,
    required this.daerah_asal,
    required this.daerah_tujuan,
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
      'daerah_asal': daerah_asal,
      'daerah_tujuan': daerah_tujuan,
      'surat': surat,
      'nama': nama,
      'no_hp': no_hp,
      'email': email,
      'surat_konfirmasi': surat_konfirmasi,
    };
  }

  factory PendudukanModel.fromJson(Map<String, dynamic> json) {
    return PendudukanModel(
      foto_ktp: json['foto_ktp'],
      foto_kk: json['foto_kk'],
      daerah_asal: json['daerah_asal'],
      daerah_tujuan: json['daerah_tujuan'],
      surat: json['surat'],
      nama: json['nama'],
      no_hp: json['no_hp'],
      email: json['email'],
      surat_konfirmasi: json['surat_konfirmasi'],
    );
  }

  factory PendudukanModel.fromSnapshot(DocumentSnapshot snapshot) {
    return PendudukanModel(
      foto_ktp: snapshot.get('foto_ktp'),
      foto_kk: snapshot.get('foto_kk'),
      daerah_asal: snapshot.get('daerah_asal'),
      daerah_tujuan: snapshot.get('daerah_tujuan'),
      surat: snapshot.get('surat'),
      nama: snapshot.get('nama'),
      no_hp: snapshot.get('no_hp'),
      email: snapshot.get('email'),
      surat_konfirmasi: snapshot.get('surat_konfirmasi'),
    );
  }
}
