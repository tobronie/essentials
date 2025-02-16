import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class DownloadServices {
  Future<void> downloadKTP(BuildContext context) async {
    try {
      Directory? directory = await getExternalStorageDirectory();
      if (directory == null) {
        print("External directory tidak ditemukan");
        return;
      }

      String filePath = "${directory.path}/formulir-ktp.pdf";
      String documentUrl = 'http://10.0.2.2:8080/essentials_api/formulir_ktp.php';

      Dio dio = Dio();

      Response response = await dio.get(
        documentUrl,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        File file = File(filePath);
        await file.writeAsBytes(response.data, flush: true);
        print("File berhasil didownload di: $filePath");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("File Formulir KTP berhasil diunduh!"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        print("Gagal mendownload file, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> downloadNikah(BuildContext context) async {
    try {
      Directory? directory = await getExternalStorageDirectory();
      if (directory == null) {
        print("External directory tidak ditemukan");
        return;
      }

      String filePath = "${directory.path}/formulir-nikah.pdf";
      String documentUrl = 'http://10.0.2.2:8080/essentials_api/formulir_nikah.php';

      Dio dio = Dio();

      Response response = await dio.get(
        documentUrl,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        File file = File(filePath);
        await file.writeAsBytes(response.data, flush: true);
        print("File berhasil didownload di: $filePath");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("File Formulir Nikah berhasil diunduh!"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        print("Gagal mendownload file, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }
}
