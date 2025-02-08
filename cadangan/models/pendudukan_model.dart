// import 'package:cloud_firestore/cloud_firestore.dart';

// class PendudukanModel {
//   final String judul;
//   final String foto_ktp;
//   final String foto_kk;
//   final String foto_nikah_ayah;
//   final String foto_nikah_ibu;
//   final String daerah_asal;
//   final String daerah_tujuan;
//   final Timestamp tgl_upload;
//   final String nama;
//   final String no_hp;
//   final String email;
//   final String surat_konfirmasi;

//   PendudukanModel({
//     required this.judul,
//     required this.foto_ktp,
//     required this.foto_kk,
//     required this.foto_nikah_ayah,
//     required this.foto_nikah_ibu,
//     required this.daerah_asal,
//     required this.daerah_tujuan,
//     required this.tgl_upload,
//     required this.nama,
//     required this.no_hp,
//     required this.email,
//     required this.surat_konfirmasi,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'judul': judul,
//       'foto_ktp': foto_ktp,
//       'foto_kk': foto_kk,
//       'foto_nikah_ayah': foto_nikah_ayah,
//       'foto_nikah_ibu': foto_nikah_ibu,
//       'daerah_asal': daerah_asal,
//       'daerah_tujuan': daerah_tujuan,
//       'tgl_upload': tgl_upload,
//       'nama': nama,
//       'no_hp': no_hp,
//       'email': email,
//       'surat_konfirmasi': surat_konfirmasi,
//     };
//   }

//   factory PendudukanModel.fromJson(Map<String, dynamic> json) {
//     return PendudukanModel(
//       judul: json['judul'],
//       foto_ktp: json['foto_ktp'],
//       foto_kk: json['foto_kk'],
//       foto_nikah_ayah: json['foto_nikah_ayah'],
//       foto_nikah_ibu: json['foto_nikah_ibu'],
//       daerah_asal: json['daerah_asal'],
//       daerah_tujuan: json['daerah_tujuan'],
//       tgl_upload: json['tgl_upload'] as Timestamp,
//       nama: json['nama'],
//       no_hp: json['no_hp'],
//       email: json['email'],
//       surat_konfirmasi: json['surat_konfirmasi'],
//     );
//   }

//   factory PendudukanModel.fromSnapshot(DocumentSnapshot snapshot) {
//     return PendudukanModel(
//       judul: snapshot.get('judul'),
//       foto_ktp: snapshot.get('foto_ktp'),
//       foto_kk: snapshot.get('foto_kk'),
//       foto_nikah_ayah: snapshot.get('foto_nikah_ayah'),
//       foto_nikah_ibu: snapshot.get('foto_nikah_ibu'),
//       daerah_asal: snapshot.get('daerah_asal'),
//       daerah_tujuan: snapshot.get('daerah_tujuan'),
//       tgl_upload: snapshot.get('tgl_upload') ?? Timestamp.now(),
//       nama: snapshot.get('nama'),
//       no_hp: snapshot.get('no_hp'),
//       email: snapshot.get('email'),
//       surat_konfirmasi: snapshot.get('surat_konfirmasi'),
//     );
//   }
// }
