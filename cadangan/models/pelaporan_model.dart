// import 'package:cloud_firestore/cloud_firestore.dart';

// class PelaporanModel {
//   // final String nama;
//   final String image;
//   final String judul;
//   final Timestamp waktu;
//   final String lokasi;
//   final String isi;
//   final Timestamp tgl_upload;

//   PelaporanModel({
//     // required this.nama,
//     required this.image,
//     required this.judul,
//     required this.waktu,
//     required this.lokasi,
//     required this.isi,
//     required this.tgl_upload,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       // 'nama': nama,
//       'image': image,
//       'judul': judul,
//       'waktu': waktu,
//       'lokasi': lokasi,
//       'isi': isi,
//       'tgl_upload': tgl_upload,
//     };
//   }

//   factory PelaporanModel.fromJson(Map<String, dynamic> json) {
//     return PelaporanModel(
//       // nama: json['nama'],
//       image: json['image'],
//       judul: json['judul'],
//       waktu: json['waktu'] as Timestamp,
//       lokasi: json['lokasi'],
//       isi: json['isi'],
//       tgl_upload: json['tgl_upload'] as Timestamp,
//     );
//   }

//   factory PelaporanModel.fromSnapshot(DocumentSnapshot snapshot) {
//     return PelaporanModel(
//       // nama: snapshot.get('nama'),
//       image: snapshot.get('image'),
//       judul: snapshot.get('judul'),
//       waktu: snapshot.get('waktu') ?? Timestamp,
//       lokasi: snapshot.get('lokasi'),
//       isi: snapshot.get('isi'),
//       tgl_upload: snapshot.get('tgl_upload') ?? Timestamp.now(),
//     );
//   }
// }
