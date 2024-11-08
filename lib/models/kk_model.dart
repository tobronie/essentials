import 'package:cloud_firestore/cloud_firestore.dart';

class KKModel {
  final String foto_ktp;
  final String nama_wali;
  final int jumlah;
  final String foto_pendukung;
  final String surat;
  final String nama;
  final int no_hp;
  final String email;
  final String surat_konfirmasi;

  KKModel({
    required this.foto_ktp,
    required this.nama_wali,
    required this.jumlah,
    required this.foto_pendukung,
    required this.surat,
    required this.nama,
    required this.no_hp,
    required this.email,
    required this.surat_konfirmasi,
  });

  Map<String, dynamic> toJson() {
    return {
      'foto_ktp': foto_ktp,
      'nama_wali': nama_wali,
      'jumlah': jumlah,
      'foto_pendukung': foto_pendukung,
      'surat': surat,
      'nama': nama,
      'no_hp': no_hp,
      'email': email,
      'surat_konfirmasi': surat_konfirmasi,
    };
  }

  factory KKModel.fromJson(Map<String, dynamic> json) {
    return KKModel(
      foto_ktp: json['foto_ktp'],
      nama_wali: json['nama_wali'],
      jumlah: json['jumlah'],
      foto_pendukung: json['foto_pendukung'],
      surat: json['surat'],
      nama: json['nama'],
      no_hp: json['no_hp'],
      email: json['email'],
      surat_konfirmasi: json['surat_konfirmasi'],
    );
  }

  factory KKModel.fromSnapshot(DocumentSnapshot snapshot) {
    return KKModel(
      foto_ktp: snapshot.get('foto_ktp'),
      nama_wali: snapshot.get('nama_wali'),
      jumlah: snapshot.get('jumlah'),
      foto_pendukung: snapshot.get('foto_pendukung'),
      surat: snapshot.get('surat'),
      nama: snapshot.get('nama'),
      no_hp: snapshot.get('no_hp'),
      email: snapshot.get('email'),
      surat_konfirmasi: snapshot.get('surat_konfirmasi'),
    );
  }
}
