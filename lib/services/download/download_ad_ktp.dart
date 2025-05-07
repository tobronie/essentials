import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DownloadServicesKTP {
  Future<String?> downloadAdministrasiKTP(
      BuildContext context, String idKTP) async {
    try {
      print("ID KTP yang dikirim: $idKTP");
      String url =
          'https://essentials.my.id/download_ad_ktp.php?id_ktp=$idKTP';
      print("Mengunduh dari URL: $url");

      Directory? dir = await getExternalStorageDirectory();
      if (dir == null) {
        print("External directory tidak ditemukan");
        return null;
      }

      String filePath = "${dir.path}/$idKTP-Surat_Konfirmasi_Kartu_Tanda_Penduduk.pdf";

      Dio dio = Dio();
      Response response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        File file = File(filePath);
        await file.writeAsBytes(response.data, flush: true);
        print("File berhasil disimpan di: $filePath");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("File berhasil diunduh!"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
          ),
        );

        return filePath;
      } else {
        print("Gagal mengunduh file: Status ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error saat mengunduh file: $e");
      return null;
    }
  }
}
