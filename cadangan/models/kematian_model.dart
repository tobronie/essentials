// import 'package:cloud_firestore/cloud_firestore.dart';

// class KematianModel {
//   final String judul;
//   final String nama_almarhum;
//   final String foto_ktp_almarhum;
//   final String foto_ktp_saksi;
//   final String foto_kk;
//   final String foto_bukti;
//   final Timestamp tgl_upload;
//   final String nama;
//   final String no_hp;
//   final String email;
//   final String surat_konfirmasi;

//   KematianModel({
//     required this.judul,
//     required this.nama_almarhum,
//     required this.foto_ktp_almarhum,
//     required this.foto_ktp_saksi,
//     required this.foto_kk,
//     required this.foto_bukti,
//     required this.tgl_upload,
//     required this.nama,
//     required this.no_hp,
//     required this.email,
//     required this.surat_konfirmasi,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'judul': judul,
//       'nama_almarhum': nama_almarhum,
//       'foto_ktp_almarhum': foto_ktp_almarhum,
//       'foto_ktp_saksi': foto_ktp_saksi,
//       'foto_kk': foto_kk,
//       'foto_bukti': foto_bukti,
//       'tgl_upload': tgl_upload,
//       'nama': nama,
//       'no_hp': no_hp,
//       'email': email,
//       'surat_konfirmasi': surat_konfirmasi,
//     };
//   }

//   factory KematianModel.fromJson(Map<String, dynamic> json) {
//     return KematianModel(
//       judul: json['judul'],
//       nama_almarhum: json['nama_almarhum'],
//       foto_ktp_almarhum: json['foto_ktp_almarhum'],
//       foto_ktp_saksi: json['foto_ktp_saksi'],
//       foto_kk: json['foto_kk'],
//       foto_bukti: json['foto_bukti'],
//       tgl_upload: json['tgl_upload'] as Timestamp,
//       nama: json['nama'],
//       no_hp: json['no_hp'],
//       email: json['email'],
//       surat_konfirmasi: json['surat_konfirmasi'],
//     );
//   }

//   factory KematianModel.fromSnapshot(DocumentSnapshot snapshot) {
//     return KematianModel(
//       judul: snapshot.get('judul'),
//       nama_almarhum: snapshot.get('nama_almarhum'),
//       foto_ktp_almarhum: snapshot.get('foto_ktp_almarhum'),
//       foto_ktp_saksi: snapshot.get('foto_ktp_saksi'),
//       foto_kk: snapshot.get('foto_kk'),
//       foto_bukti: snapshot.get('foto_bukti'),
//       tgl_upload: snapshot.get('tgl_upload') ?? Timestamp.now(),
//       nama: snapshot.get('nama'),
//       no_hp: snapshot.get('no_hp'),
//       email: snapshot.get('email'),
//       surat_konfirmasi: snapshot.get('surat_konfirmasi'),
//     );
//   }
// }
