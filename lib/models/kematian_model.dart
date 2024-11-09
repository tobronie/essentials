import 'package:cloud_firestore/cloud_firestore.dart';

class KematianModel {
  final String nama_almarhum;
  final String foto_ktp;
  final String foto_kk;
  final String foto_bukti;
  final String surat;
  final String nama;
  final String no_hp;
  final String email;
  final String surat_konfirmasi;

  KematianModel({
    required this.nama_almarhum,
    required this.foto_ktp,
    required this.foto_kk,
    required this.foto_bukti,
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
      'foto_bukti': foto_bukti,
      'surat': surat,
      'nama': nama,
      'no_hp': no_hp,
      'email': email,
      'surat_konfirmasi': surat_konfirmasi,
    };
  }

  factory KematianModel.fromJson(Map<String, dynamic> json) {
    return KematianModel(
      nama_almarhum: json['nama_almarhum'],
      foto_ktp: json['foto_ktp'],
      foto_kk: json['foto_kk'],
      foto_bukti: json['foto_bukti'],
      surat: json['surat'],
      nama: json['nama'],
      no_hp: json['no_hp'],
      email: json['email'],
      surat_konfirmasi: json['surat_konfirmasi'],
    );
  }

  factory KematianModel.fromSnapshot(DocumentSnapshot snapshot) {
    return KematianModel(
      nama_almarhum: snapshot.get('nama_almarhum'),
      foto_ktp: snapshot.get('foto_ktp'),
      foto_kk: snapshot.get('foto_kk'),
      foto_bukti: snapshot.get('foto_bukti'),
      surat: snapshot.get('surat'),
      nama: snapshot.get('nama'),
      no_hp: snapshot.get('no_hp'),
      email: snapshot.get('email'),
      surat_konfirmasi: snapshot.get('surat_konfirmasi'),
    );
  }
}
