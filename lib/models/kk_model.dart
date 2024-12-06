import 'package:cloud_firestore/cloud_firestore.dart';

class KKModel {
  final String judul;
  final String foto_kk;
  final String foto_nikah_ayah;
  final String foto_nikah_ibu;
  final String foto_ijasah_keluarga;
  final String foto_akte_keluarga;
  final Timestamp tgl_upload;
  final String nama;
  final String no_hp;
  final String email;
  final String surat_konfirmasi;

  KKModel({
    required this.judul,
    required this.foto_kk,
    required this.foto_nikah_ayah,
    required this.foto_nikah_ibu,
    required this.foto_ijasah_keluarga,
    required this.foto_akte_keluarga,
    required this.tgl_upload,
    required this.nama,
    required this.no_hp,
    required this.email,
    required this.surat_konfirmasi,
  });

  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'foto_kk': foto_kk,
      'foto_nikah_ayah': foto_nikah_ayah,
      'foto_nikah_ibu': foto_nikah_ibu,
      'foto_ijasah_keluarga': foto_ijasah_keluarga,
      'foto_akte_keluarga': foto_akte_keluarga,
      'tgl_upload': tgl_upload,
      'nama': nama,
      'no_hp': no_hp,
      'email': email,
      'surat_konfirmasi': surat_konfirmasi,
    };
  }

  factory KKModel.fromJson(Map<String, dynamic> json) {
    return KKModel(
      judul: json['judul'],
      foto_kk: json['foto_kk'],
      foto_nikah_ayah: json['foto_nikah_ayah'],
      foto_nikah_ibu: json['foto_nikah_ibu'],
      foto_ijasah_keluarga: json['foto_ijasah_keluarga'],
      foto_akte_keluarga: json['foto_akte_keluarga'],
      tgl_upload: json['tgl_upload'] as Timestamp,
      nama: json['nama'],
      no_hp: json['no_hp'],
      email: json['email'],
      surat_konfirmasi: json['surat_konfirmasi'],
    );
  }

  factory KKModel.fromSnapshot(DocumentSnapshot snapshot) {
    return KKModel(
      judul: snapshot.get('judul'),
      foto_kk: snapshot.get('foto_kk'),
      foto_nikah_ayah: snapshot.get('foto_nikah_ayah'),
      foto_nikah_ibu: snapshot.get('foto_nikah_ibu'),
      foto_ijasah_keluarga: snapshot.get('foto_ijasah_keluarga'),
      foto_akte_keluarga: snapshot.get('foto_akte_keluarga'),
      tgl_upload: snapshot.get('tgl_upload') ?? Timestamp.now(),
      nama: snapshot.get('nama'),
      no_hp: snapshot.get('no_hp'),
      email: snapshot.get('email'),
      surat_konfirmasi: snapshot.get('surat_konfirmasi'),
    );
  }
}
