import 'package:cloud_firestore/cloud_firestore.dart';

class TanahModel {
  final String foto_ktp;
  final String foto_kk;
  final String foto_sppt_shm;
  final Timestamp tgl_upload;
  final String nama;
  final String no_hp;
  final String email;
  final String surat_konfirmasi;

  TanahModel({
    required this.foto_ktp,
    required this.foto_kk,
    required this.foto_sppt_shm,
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
      'foto_sppt_shm': foto_sppt_shm,
      'tgl_upload': tgl_upload,
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
      foto_sppt_shm: json['foto_sppt_shm'],
      tgl_upload: json['tgl_upload'] as Timestamp,
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
      foto_sppt_shm: snapshot.get('foto_sppt_shm'),
      tgl_upload: snapshot.get('tgl_upload') ?? Timestamp.now(),
      nama: snapshot.get('nama'),
      no_hp: snapshot.get('no_hp'),
      email: snapshot.get('email'),
      surat_konfirmasi: snapshot.get('surat_konfirmasi'),
    );
  }
}
