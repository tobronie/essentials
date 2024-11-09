import 'package:cloud_firestore/cloud_firestore.dart';

class PenghasilanOrtuModel {
  final String foto_ktp;
  final String foto_kk;
  final String pekerjaan_ayah;
  final String pendapatan_ayah;
  final String foto_pendukung_ayah;
  final String pekerjaan_ibu;
  final String pendapatan_ibu;
  final String foto_pendukung_ibu;
  final String nama;
  final String no_hp;
  final String email;
  final String surat_konfirmasi;

  PenghasilanOrtuModel({
    required this.foto_ktp,
    required this.foto_kk,
    required this.pekerjaan_ayah,
    required this.pendapatan_ayah,
    required this.foto_pendukung_ayah,
    required this.pekerjaan_ibu,
    required this.pendapatan_ibu,
    required this.foto_pendukung_ibu,
    required this.nama,
    required this.no_hp,
    required this.email,
    required this.surat_konfirmasi,
  });

  Map<String, dynamic> toJson() {
    return {
      'foto_ktp': foto_ktp,
      'foto_kk': foto_kk,
      'pekerjaan_ayah': pekerjaan_ayah,
      'pendapatan_ayah': pendapatan_ayah,
      'foto_pendukung_ayah': foto_pendukung_ayah,
      'pekerjaan_ibu': pekerjaan_ibu,
      'pendapatan_ibu': pendapatan_ibu,
      'foto_pendukung_ibu': foto_pendukung_ibu,
      'nama': nama,
      'no_hp': no_hp,
      'email': email,
      'surat_konfirmasi': surat_konfirmasi,
    };
  }

  factory PenghasilanOrtuModel.fromJson(Map<String, dynamic> json) {
    return PenghasilanOrtuModel(
      foto_ktp: json['foto_ktp'],
      foto_kk: json['foto_kk'],
      pekerjaan_ayah: json['pekerjaan_ayah'],
      pendapatan_ayah: json['pendapatan_ayah'],
      foto_pendukung_ayah: json['foto_pendukung_ayah'],
      pekerjaan_ibu: json['pekerjaan_ibu'],
      pendapatan_ibu: json['pendapatan_ibu'],
      foto_pendukung_ibu: json['foto_pendukung_ibu'],
      nama: json['nama'],
      no_hp: json['no_hp'],
      email: json['email'],
      surat_konfirmasi: json['surat_konfirmasi'],
    );
  }

  factory PenghasilanOrtuModel.fromSnapshot(DocumentSnapshot snapshot) {
    return PenghasilanOrtuModel(
      foto_ktp: snapshot.get('foto_ktp'),
      foto_kk: snapshot.get('foto_kk'),
      pekerjaan_ayah: snapshot.get('pekerjaan_ayah'),
      pendapatan_ayah: snapshot.get('pendapatan_ayah'),
      foto_pendukung_ayah: snapshot.get('foto_pendukung_ayah'),
      pekerjaan_ibu: snapshot.get('pekerjaan_ibu'),
      pendapatan_ibu: snapshot.get('pendapatan_ibu'),
      foto_pendukung_ibu: snapshot.get('foto_pendukung_ibu'),
      nama: snapshot.get('nama'),
      no_hp: snapshot.get('no_hp'),
      email: snapshot.get('email'),
      surat_konfirmasi: snapshot.get('surat_konfirmasi'),
    );
  }
}
