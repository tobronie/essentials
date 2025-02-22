import 'dart:convert';
import 'dart:io';
import 'package:essentials/screens/navigation/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateNikahService {
  Future<void> nikah(
      String ni_judul,
      String ni_foto_ktp_pria,
      String ni_foto_kk_pria,
      String ni_foto_akte_pria,
      String ni_foto_formulir_pria,
      String ni_foto_nikah_ayah_pria,
      String ni_foto_nikah_ibu_pria,
      String ni_foto_ktp_wanita,
      String ni_foto_kk_wanita,
      String ni_foto_akte_wanita,
      String ni_foto_formulir_wanita,
      String ni_foto_nikah_ayah_wanita,
      String ni_foto_nikah_ibu_wanita,
      String ni_surat_konfirmasi,
      String ni_tgl_upload,
      String ni_konfirmasi,
      BuildContext context) async {
    String url = 'http://10.0.2.2:8080/essentials_api/create_ad_nikah.php';

    String base64FotoKTPpria = '';
    String base64FotoKKpria = '';
    String base64FotoAktepria = '';
    String base64FotoFormulirpria = '';
    String base64FotoNikahAyahpria = '';
    String base64FotoNikahIbupria = '';
    String base64FotoKTPwanita = '';
    String base64FotoKKwanita = '';
    String base64FotoAktewanita = '';
    String base64FotoFormulirwanita = '';
    String base64FotoNikahAyahwanita = '';
    String base64FotoNikahIbuwanita = '';

    if (ni_foto_ktp_pria.isNotEmpty) {
      try {
        base64FotoKTPpria = base64Encode(File(ni_foto_ktp_pria).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar ktp pria: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ni_foto_kk_pria.isNotEmpty) {
      try {
        base64FotoKKpria = base64Encode(File(ni_foto_kk_pria).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar kk pria: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ni_foto_akte_pria.isNotEmpty) {
      try {
        base64FotoAktepria = base64Encode(File(ni_foto_akte_pria).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar akte pria: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ni_foto_formulir_pria.isNotEmpty) {
      try {
        base64FotoFormulirpria = base64Encode(File(ni_foto_formulir_pria).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar formulir pria: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ni_foto_nikah_ayah_pria.isNotEmpty) {
      try {
        base64FotoNikahAyahpria = base64Encode(File(ni_foto_nikah_ayah_pria).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Buku Nikah Ayah pria: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ni_foto_nikah_ibu_pria.isNotEmpty) {
      try {
        base64FotoNikahIbupria = base64Encode(File(ni_foto_nikah_ibu_pria).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Buku Nikah Ibu pria: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ni_foto_ktp_wanita.isNotEmpty) {
      try {
        base64FotoKTPwanita = base64Encode(File(ni_foto_ktp_wanita).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar ktp wanita: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ni_foto_kk_wanita.isNotEmpty) {
      try {
        base64FotoKKwanita = base64Encode(File(ni_foto_kk_wanita).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar kk wanita: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ni_foto_akte_wanita.isNotEmpty) {
      try {
        base64FotoAktewanita = base64Encode(File(ni_foto_akte_wanita).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar akte wanita: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ni_foto_formulir_wanita.isNotEmpty) {
      try {
        base64FotoFormulirwanita = base64Encode(File(ni_foto_formulir_wanita).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar formulir wanita: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ni_foto_nikah_ayah_wanita.isNotEmpty) {
      try {
        base64FotoNikahAyahwanita = base64Encode(File(ni_foto_nikah_ayah_wanita).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Buku Nikah Ayah wanita: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    if (ni_foto_nikah_ibu_wanita.isNotEmpty) {
      try {
        base64FotoNikahIbuwanita = base64Encode(File(ni_foto_nikah_ibu_wanita).readAsBytesSync());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membaca file gambar Buku Nikah Ibu wanita: $e'),
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
          'ni_judul': ni_judul,
          'ni_foto_ktp_pria': base64FotoKTPpria,
          'ni_foto_kk_pria': base64FotoKKpria,
          'ni_foto_akte_pria': base64FotoAktepria,
          'ni_foto_formulir_pria': base64FotoFormulirpria,
          'ni_foto_nikah_ayah_pria': base64FotoNikahAyahpria,
          'ni_foto_nikah_ibu_pria': base64FotoNikahIbupria,
          'ni_foto_ktp_wanita': base64FotoKTPwanita,
          'ni_foto_kk_wanita': base64FotoKKwanita,
          'ni_foto_akte_wanita': base64FotoAktewanita,
          'ni_foto_formulir_wanita': base64FotoFormulirwanita,
          'ni_foto_nikah_ayah_wanita': base64FotoNikahAyahwanita,
          'ni_foto_nikah_ibu_wanita': base64FotoNikahIbuwanita,
          'ni_surat_konfirmasi': ni_surat_konfirmasi,
          'ni_tgl_upload': ni_tgl_upload,
          'ni_konfirmasi': ni_konfirmasi,
        },
      );

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
