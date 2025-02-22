import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class DownloadServices {
  Future<String?> downloadAdministrasiAkte(
      BuildContext context, String fileUrl) async {
    try {
      if (!fileUrl.startsWith("http")) {
        print("URL file tidak valid: $fileUrl");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("URL file tidak valid"),
            backgroundColor: Colors.red,
          ),
        );
        return null;
      }

      String fileName = fileUrl.split('/').last;
      Directory directory = await getApplicationDocumentsDirectory();
      String savePath = "${directory.path}/$fileName";

      File file = File(savePath);
      if (await file.exists()) {
        print("File sudah ada: $savePath");
        return savePath;
      }

      Dio dio = Dio();
      Response fileResponse = await dio.download(fileUrl, savePath);

      if (fileResponse.statusCode == 200) {
        print("File berhasil diunduh: $savePath");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("File berhasil diunduh!"),
            backgroundColor: Colors.green,
          ),
        );
        return savePath;
      } else {
        print("Gagal mengunduh file, status code: ${fileResponse.statusCode}");
        return null;
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
      return null;
    }
  }
}
