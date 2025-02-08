// import 'package:cloud_firestore/cloud_firestore.dart';

// class AkteModel {
//   final String judul;
//   final String surat_kelahiran;
//   final String foto_ktp_ayah;
//   final String foto_ktp_ibu;
//   final String foto_nikah_ayah;
//   final String foto_nikah_ibu;
//   final String foto_kk;
//   final String foto_ktp_saksi_satu;
//   final String foto_ktp_saksi_dua;
//   final String foto_akte_saudara;
//   final String foto_ijasah_bersangkutan;
//   final Timestamp tgl_upload;
//   final String nama;
//   final String no_hp;
//   final String email;
//   final String surat_konfirmasi;

//   AkteModel({
//     required this.judul,
//     required this.surat_kelahiran,
//     required this.foto_ktp_ayah,
//     required this.foto_ktp_ibu,
//     required this.foto_nikah_ayah,
//     required this.foto_nikah_ibu,
//     required this.foto_ktp_saksi_satu,
//     required this.foto_ktp_saksi_dua,
//     required this.foto_akte_saudara,
//     required this.foto_ijasah_bersangkutan,
//     required this.foto_kk,
//     required this.tgl_upload,
//     required this.nama,
//     required this.no_hp,
//     required this.email,
//     required this.surat_konfirmasi,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'judul': judul,
//       'surat_kelahiran': surat_kelahiran,
//       'foto_ktp_ayah': foto_ktp_ayah,
//       'foto_ktp_ibu': foto_ktp_ibu,
//       'foto_nikah_ayah': foto_nikah_ayah,
//       'foto_nikah_ibu': foto_nikah_ibu,
//       'foto_ktp_saksi_satu': foto_ktp_saksi_satu,
//       'foto_ktp_saksi_dua': foto_ktp_saksi_dua,
//       'foto_akte_saudara': foto_akte_saudara,
//       'foto_ijasah_bersangkutan': foto_ijasah_bersangkutan,
//       'foto_kk': foto_kk,
//       'tgl_upload': tgl_upload,
//       'nama': nama,
//       'no_hp': no_hp,
//       'email': email,
//       'surat_konfirmasi': surat_konfirmasi,
//     };
//   }

//   factory AkteModel.fromJson(Map<String, dynamic> json) {
//     return AkteModel(
//       judul: json['judul'],
//       surat_kelahiran: json['surat_kelahiran'],
//       foto_ktp_ayah: json['foto_ktp_ayah'],
//       foto_ktp_ibu: json['foto_ktp_ibu'],
//       foto_nikah_ayah: json['foto_nikah_ayah'],
//       foto_nikah_ibu: json['foto_nikah_ibu'],
//       foto_akte_saudara: json['foto_akte_saudara'],
//       foto_ijasah_bersangkutan: json['foto_ijasah_bersangkutan'],
//       foto_ktp_saksi_satu: json['foto_ktp_saksi_satu'],
//       foto_ktp_saksi_dua: json['foto_ktp_saksi_dua'],
//       foto_kk: json['foto_kk'],
//       tgl_upload: json['tgl_upload'] as Timestamp,
//       nama: json['nama'],
//       no_hp: json['no_hp'],
//       email: json['email'],
//       surat_konfirmasi: json['surat_konfirmasi'],
//     );
//   }

//   factory AkteModel.fromSnapshot(DocumentSnapshot snapshot) {
//     return AkteModel(
//       judul: snapshot.get('judul'),
//       surat_kelahiran: snapshot.get('surat_kelahiran'),
//       foto_ktp_ayah: snapshot.get('foto_ktp_ayah'),
//       foto_ktp_ibu: snapshot.get('foto_ktp_ibu'),
//       foto_nikah_ibu: snapshot.get('foto_nikah_ibu'),
//       foto_nikah_ayah: snapshot.get('foto_nikah_ayah'),
//       foto_akte_saudara: snapshot.get('foto_akte_saudara'),
//       foto_ijasah_bersangkutan: snapshot.get('foto_ijasah_bersangkutan'),
//       foto_ktp_saksi_satu: snapshot.get('foto_ktp_saksi_satu'),
//       foto_ktp_saksi_dua: snapshot.get('foto_ktp_saksi_dua'),
//       foto_kk: snapshot.get('foto_kk'),
//       tgl_upload: snapshot.get('tgl_upload') ?? Timestamp.now(),
//       nama: snapshot.get('nama'),
//       no_hp: snapshot.get('no_hp'),
//       email: snapshot.get('email'),
//       surat_konfirmasi: snapshot.get('surat_konfirmasi'),
//     );
//   }
// }
