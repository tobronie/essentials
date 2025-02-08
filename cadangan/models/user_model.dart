// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   final String name;
//   final String nik;
//   final String kk;
//   final String pekerjaan;
//   final String dusun;
//   final String rt;
//   final String rw;
//   final String no_hp;
//   final String email;
//   final String password;

//   UserModel({
//     required this.name,
//     required this.nik,
//     required this.kk,
//     required this.pekerjaan,
//     required this.dusun,
//     required this.rt,
//     required this.rw,
//     required this.no_hp,
//     required this.email,
//     required this.password,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'nik': nik,
//       'kk': kk,
//       'pekerjaan': pekerjaan,
//       'dusun': dusun,
//       'rt': rt,
//       'rw': rw,
//       'no_hp': no_hp,
//       'email': email,
//       'password': password,
//     };
//   }

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       name: json['name'],
//       nik: json['nik'],
//       kk: json['kk'],
//       pekerjaan: json['pekerjaan'],
//       dusun: json['dusun'],
//       rt: json['rt'],
//       rw: json['rw'],
//       no_hp: json['no_hp'],
//       email: json['email'],
//       password: json['password'],
//     );
//   }

//   factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
//     return UserModel(
//       name: snapshot.get('name'),
//       nik: snapshot.get('nik'),
//       kk: snapshot.get('kk'),
//       pekerjaan: snapshot.get('pekerjaan'),
//       dusun: snapshot.get('dusun'),
//       rt: snapshot.get('rt'),
//       rw: snapshot.get('rw'),
//       no_hp: snapshot.get('no_hp'),
//       email: snapshot.get('email'),
//       password: snapshot.get('password'),
//     );
//   }
// }
