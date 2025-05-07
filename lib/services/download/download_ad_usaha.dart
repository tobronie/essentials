import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DownloadServicesUsaha {
  Future<String?> downloadAdministrasiUsaha(
      BuildContext context, String idUsaha) async {
    try {
      print("ID Usaha yang dikirim: $idUsaha");
      String url =
          'https://essentials.my.id/download_ad_usaha.php?id_usaha=$idUsaha';
      print("Mengunduh dari URL: $url");

      Directory? dir = await getExternalStorageDirectory();
      if (dir == null) {
        print("External directory tidak ditemukan");
        return null;
      }

      String filePath = "${dir.path}/$idUsaha-Surat_Konfirmasi_Usaha.pdf";

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
