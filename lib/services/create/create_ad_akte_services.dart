import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateAkteService {
  Future<void> akte(
      String ak_judul,
      String ak_foto_surat_kelahiran,
      String ak_foto_kk,
      String ak_foto_ktp_ayah,
      String ak_foto_nikah_ayah,
      String ak_foto_ktp_ibu,
      String ak_foto_nikah_ibu,
      String ak_foto_ktp_saksi_satu,
      String ak_foto_ktp_saksi_dua,
      String? ak_foto_ijasah_bersangkutan,
      String? ak_foto_akte_saudara,
      String ak_surat_konfirmasi,
      String ak_tgl_upload,
      String ak_konfirmasi,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_ad_akte.php';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id_user = prefs.getString('id_user');

    if (id_user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal mengirim laporan: User tidak ditemukan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String base64FotoSuratKelahiran = '';
    String base64FotoKK = '';
    String base64FotoKTPAyah = '';
    String base64FotoNikahAyah = '';
    String base64FotoKTPIbu = '';
    String base64FotoNikahIbu = '';
    String base64FotoKTPSaksiSatu = '';
    String base64FotoKTPSaksiDua = '';
    String base64FotoIjasahBersangkutan = '';
    String base64FotoAkteSaudara = '';

    if (ak_foto_surat_kelahiran.isNotEmpty) {
      try {
        base64FotoSuratKelahiran = base64Encode(File(ak_foto_surat_kelahiran).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Surat Kelahiran: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ak_foto_kk.isNotEmpty) {
      try {
        base64FotoKK = base64Encode(File(ak_foto_kk).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Kartu Keluarga: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ak_foto_ktp_ayah.isNotEmpty) {
      try {
        base64FotoKTPAyah = base64Encode(File(ak_foto_ktp_ayah).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar KTP Ayah: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ak_foto_nikah_ayah.isNotEmpty) {
      try {
        base64FotoNikahAyah = base64Encode(File(ak_foto_nikah_ayah).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Buku Nikah Ayah: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ak_foto_ktp_ibu.isNotEmpty) {
      try {
        base64FotoKTPIbu = base64Encode(File(ak_foto_ktp_ibu).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar KTP Ibu: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ak_foto_nikah_ibu.isNotEmpty) {
      try {
        base64FotoNikahIbu = base64Encode(File(ak_foto_nikah_ibu).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Buku Nikah Ibu: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ak_foto_ktp_saksi_satu.isNotEmpty) {
      try {
        base64FotoKTPSaksiSatu = base64Encode(File(ak_foto_ktp_saksi_satu).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Saksi Satu: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ak_foto_ktp_saksi_dua.isNotEmpty) {
      try {
        base64FotoKTPSaksiDua = base64Encode(File(ak_foto_ktp_saksi_dua).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Saksi Dua: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ak_foto_ijasah_bersangkutan?.isNotEmpty ?? false) {
      try {
        base64FotoIjasahBersangkutan = base64Encode(File(ak_foto_ijasah_bersangkutan!).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Ijasah Bersangkutan: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ak_foto_akte_saudara?.isNotEmpty ?? false) {
      try {
        base64FotoAkteSaudara = base64Encode(File(ak_foto_akte_saudara!).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Kartu Keluarga: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'id_user': id_user,
          'ak_judul': ak_judul,
          'ak_foto_surat_kelahiran': base64FotoSuratKelahiran,
          'ak_foto_kk': base64FotoKK,
          'ak_foto_ktp_ayah': base64FotoKTPAyah,
          'ak_foto_nikah_ayah': base64FotoNikahAyah,
          'ak_foto_ktp_ibu': base64FotoKTPIbu,
          'ak_foto_nikah_ibu': base64FotoNikahIbu,
          'ak_foto_ktp_saksi_satu': base64FotoKTPSaksiSatu,
          'ak_foto_ktp_saksi_dua': base64FotoKTPSaksiDua,
          'ak_foto_ijasah_bersangkutan': base64FotoIjasahBersangkutan.isNotEmpty ? base64FotoIjasahBersangkutan : '',
          'ak_foto_akte_saudara': base64FotoAkteSaudara.isNotEmpty ? base64FotoAkteSaudara : '',
          'ak_tgl_upload': ak_tgl_upload,
          'ak_surat_konfirmasi': ak_surat_konfirmasi,
          'ak_konfirmasi': ak_konfirmasi,
        },
      );
      print("ID User terkirim: $id_user");
      print("Response Body: ${response.body}");

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 'true') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil Pengajuan Surat'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ActivityScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Gagal Pengajuan Surat'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
