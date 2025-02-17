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
      String documentUrl =
          'http://10.0.2.2:8080/essentials_api/formulir_ktp.php';

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
      String documentUrl =
          'http://10.0.2.2:8080/essentials_api/formulir_nikah.php';

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

  Future<void> download_AdministrasiAkte(BuildContext context) async {
    try {
      String documentUrl =
          'http://10.0.2.2:8080/essentials_api/get_ad_akte.php';

      Dio dio = Dio();
      Response response = await dio.get(
        documentUrl,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data.isNotEmpty) {
          String nama = data[0]['nama'] ?? 'pengguna';
          String ak_judul = data[0]['ak_judul'] ?? 'surat-pengantar-akte';
          String pdfUrl =
              documentUrl + "?id_akte=" + data[0]['id_akte'].toString();

          String safeNama = nama.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String safeJudul =
              ak_judul.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String fileName = "$safeNama-$safeJudul.pdf";

          Directory? directory = await getExternalStorageDirectory();
          if (directory == null) {
            print("External directory tidak ditemukan");
            return;
          }

          String filePath = "${directory.path}/$fileName";

          Response pdfResponse = await dio.get(
            pdfUrl,
            options: Options(
              responseType: ResponseType.bytes,
            ),
          );

          if (pdfResponse.statusCode == 200) {
            File file = File(filePath);
            await file.writeAsBytes(pdfResponse.data, flush: true);
            print("File berhasil diunduh di: $filePath");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("File Surat Konfirmasi berhasil diunduh!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            print(
                "Gagal mendownload file PDF, status code: ${pdfResponse.statusCode}");
          }
        } else {
          print("Data kosong");
        }
      } else {
        print("Gagal mengambil data, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> download_AdministrasiDomisili(BuildContext context) async {
    try {
      String documentUrl =
          'http://10.0.2.2:8080/essentials_api/get_ad_domisili.php';

      Dio dio = Dio();
      Response response = await dio.get(
        documentUrl,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data.isNotEmpty) {
          String nama = data[0]['nama'] ?? 'pengguna';
          String dom_judul = data[0]['dom_judul'] ?? 'surat-keterangan-domisili';
          String pdfUrl =
              documentUrl + "?id_domisili=" + data[0]['id_domisili'].toString();

          String safeNama = nama.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String safeJudul =
              dom_judul.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String fileName = "$safeNama-$safeJudul.pdf";

          Directory? directory = await getExternalStorageDirectory();
          if (directory == null) {
            print("External directory tidak ditemukan");
            return;
          }

          String filePath = "${directory.path}/$fileName";

          Response pdfResponse = await dio.get(
            pdfUrl,
            options: Options(
              responseType: ResponseType.bytes,
            ),
          );

          if (pdfResponse.statusCode == 200) {
            File file = File(filePath);
            await file.writeAsBytes(pdfResponse.data, flush: true);
            print("File berhasil diunduh di: $filePath");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("File Surat Konfirmasi berhasil diunduh!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            print(
                "Gagal mendownload file PDF, status code: ${pdfResponse.statusCode}");
          }
        } else {
          print("Data kosong");
        }
      } else {
        print("Gagal mengambil data, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> download_AdministrasiKematian(BuildContext context) async {
    try {
      String documentUrl =
          'http://10.0.2.2:8080/essentials_api/get_ad_kematian.php';

      Dio dio = Dio();
      Response response = await dio.get(
        documentUrl,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data.isNotEmpty) {
          String nama = data[0]['nama'] ?? 'pengguna';
          String kem_judul = data[0]['kem_judul'] ?? 'surat-keterangan-kematian';
          String pdfUrl =
              documentUrl + "?id_kematian=" + data[0]['id_kematian'].toString();

          String safeNama = nama.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String safeJudul =
              kem_judul.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String fileName = "$safeNama-$safeJudul.pdf";

          Directory? directory = await getExternalStorageDirectory();
          if (directory == null) {
            print("External directory tidak ditemukan");
            return;
          }

          String filePath = "${directory.path}/$fileName";

          Response pdfResponse = await dio.get(
            pdfUrl,
            options: Options(
              responseType: ResponseType.bytes,
            ),
          );

          if (pdfResponse.statusCode == 200) {
            File file = File(filePath);
            await file.writeAsBytes(pdfResponse.data, flush: true);
            print("File berhasil diunduh di: $filePath");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("File Surat Konfirmasi berhasil diunduh!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            print(
                "Gagal mendownload file PDF, status code: ${pdfResponse.statusCode}");
          }
        } else {
          print("Data kosong");
        }
      } else {
        print("Gagal mengambil data, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> download_AdministrasiKK(BuildContext context) async {
    try {
      String documentUrl =
          'http://10.0.2.2:8080/essentials_api/get_ad_kk.php';

      Dio dio = Dio();
      Response response = await dio.get(
        documentUrl,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data.isNotEmpty) {
          String nama = data[0]['nama'] ?? 'pengguna';
          String kk_judul = data[0]['kk_judul'] ?? 'surat-pengantar-kk';
          String pdfUrl =
              documentUrl + "?id_kk=" + data[0]['id_kk'].toString();

          String safeNama = nama.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String safeJudul =
              kk_judul.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String fileName = "$safeNama-$safeJudul.pdf";

          Directory? directory = await getExternalStorageDirectory();
          if (directory == null) {
            print("External directory tidak ditemukan");
            return;
          }

          String filePath = "${directory.path}/$fileName";

          Response pdfResponse = await dio.get(
            pdfUrl,
            options: Options(
              responseType: ResponseType.bytes,
            ),
          );

          if (pdfResponse.statusCode == 200) {
            File file = File(filePath);
            await file.writeAsBytes(pdfResponse.data, flush: true);
            print("File berhasil diunduh di: $filePath");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("File Surat Konfirmasi berhasil diunduh!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            print(
                "Gagal mendownload file PDF, status code: ${pdfResponse.statusCode}");
          }
        } else {
          print("Data kosong");
        }
      } else {
        print("Gagal mengambil data, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> download_AdministrasiKTP(BuildContext context) async {
    try {
      String documentUrl =
          'http://10.0.2.2:8080/essentials_api/get_ad_ktp.php';

      Dio dio = Dio();
      Response response = await dio.get(
        documentUrl,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data.isNotEmpty) {
          String nama = data[0]['nama'] ?? 'pengguna';
          String kt_judul = data[0]['kt_judul'] ?? 'surat-pengantar-ktp';
          String pdfUrl =
              documentUrl + "?id_ktp=" + data[0]['id_ktp'].toString();

          String safeNama = nama.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String safeJudul =
              kt_judul.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String fileName = "$safeNama-$safeJudul.pdf";

          Directory? directory = await getExternalStorageDirectory();
          if (directory == null) {
            print("External directory tidak ditemukan");
            return;
          }

          String filePath = "${directory.path}/$fileName";

          Response pdfResponse = await dio.get(
            pdfUrl,
            options: Options(
              responseType: ResponseType.bytes,
            ),
          );

          if (pdfResponse.statusCode == 200) {
            File file = File(filePath);
            await file.writeAsBytes(pdfResponse.data, flush: true);
            print("File berhasil diunduh di: $filePath");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("File Surat Konfirmasi berhasil diunduh!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            print(
                "Gagal mendownload file PDF, status code: ${pdfResponse.statusCode}");
          }
        } else {
          print("Data kosong");
        }
      } else {
        print("Gagal mengambil data, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> download_AdministrasiNikah(BuildContext context) async {
    try {
      String documentUrl =
          'http://10.0.2.2:8080/essentials_api/get_ad_nikah.php';

      Dio dio = Dio();
      Response response = await dio.get(
        documentUrl,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data.isNotEmpty) {
          String nama = data[0]['nama'] ?? 'pengguna';
          String ni_judul = data[0]['ni_judul'] ?? 'surat-pengantar-nikah';
          String pdfUrl =
              documentUrl + "?id_nikah=" + data[0]['id_nikah'].toString();

          String safeNama = nama.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String safeJudul =
              ni_judul.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String fileName = "$safeNama-$safeJudul.pdf";

          Directory? directory = await getExternalStorageDirectory();
          if (directory == null) {
            print("External directory tidak ditemukan");
            return;
          }

          String filePath = "${directory.path}/$fileName";

          Response pdfResponse = await dio.get(
            pdfUrl,
            options: Options(
              responseType: ResponseType.bytes,
            ),
          );

          if (pdfResponse.statusCode == 200) {
            File file = File(filePath);
            await file.writeAsBytes(pdfResponse.data, flush: true);
            print("File berhasil diunduh di: $filePath");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("File Surat Konfirmasi berhasil diunduh!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            print(
                "Gagal mendownload file PDF, status code: ${pdfResponse.statusCode}");
          }
        } else {
          print("Data kosong");
        }
      } else {
        print("Gagal mengambil data, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> download_AdministrasiPendudukan(BuildContext context) async {
    try {
      String documentUrl =
          'http://10.0.2.2:8080/essentials_api/get_ad_pendudukan.php';

      Dio dio = Dio();
      Response response = await dio.get(
        documentUrl,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data.isNotEmpty) {
          String nama = data[0]['nama'] ?? 'pengguna';
          String pen_judul = data[0]['pen_judul'] ?? 'surat-kependudukan';
          String pdfUrl =
              documentUrl + "?id_pendudukan=" + data[0]['id_pendudukan'].toString();

          String safeNama = nama.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String safeJudul =
              pen_judul.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String fileName = "$safeNama-$safeJudul.pdf";

          Directory? directory = await getExternalStorageDirectory();
          if (directory == null) {
            print("External directory tidak ditemukan");
            return;
          }

          String filePath = "${directory.path}/$fileName";

          Response pdfResponse = await dio.get(
            pdfUrl,
            options: Options(
              responseType: ResponseType.bytes,
            ),
          );

          if (pdfResponse.statusCode == 200) {
            File file = File(filePath);
            await file.writeAsBytes(pdfResponse.data, flush: true);
            print("File berhasil diunduh di: $filePath");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("File Surat Konfirmasi berhasil diunduh!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            print(
                "Gagal mendownload file PDF, status code: ${pdfResponse.statusCode}");
          }
        } else {
          print("Data kosong");
        }
      } else {
        print("Gagal mengambil data, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> download_AdministrasiPenghasilan(BuildContext context) async {
    try {
      String documentUrl =
          'http://10.0.2.2:8080/essentials_api/get_ad_penghasilan_ortu.php';

      Dio dio = Dio();
      Response response = await dio.get(
        documentUrl,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data.isNotEmpty) {
          String nama = data[0]['nama'] ?? 'pengguna';
          String has_judul = data[0]['has_judul'] ?? 'surat-keterangan-penghasilan-ortu';
          String pdfUrl =
              documentUrl + "?id_penghasilan=" + data[0]['id_penghasilan'].toString();

          String safeNama = nama.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String safeJudul =
              has_judul.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String fileName = "$safeNama-$safeJudul.pdf";

          Directory? directory = await getExternalStorageDirectory();
          if (directory == null) {
            print("External directory tidak ditemukan");
            return;
          }

          String filePath = "${directory.path}/$fileName";

          Response pdfResponse = await dio.get(
            pdfUrl,
            options: Options(
              responseType: ResponseType.bytes,
            ),
          );

          if (pdfResponse.statusCode == 200) {
            File file = File(filePath);
            await file.writeAsBytes(pdfResponse.data, flush: true);
            print("File berhasil diunduh di: $filePath");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("File Surat Konfirmasi berhasil diunduh!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            print(
                "Gagal mendownload file PDF, status code: ${pdfResponse.statusCode}");
          }
        } else {
          print("Data kosong");
        }
      } else {
        print("Gagal mengambil data, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> download_AdministrasiSKTM(BuildContext context) async {
    try {
      String documentUrl =
          'http://10.0.2.2:8080/essentials_api/get_ad_sktm.php';

      Dio dio = Dio();
      Response response = await dio.get(
        documentUrl,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data.isNotEmpty) {
          String nama = data[0]['nama'] ?? 'pengguna';
          String sktm_judul = data[0]['sktm_judul'] ?? 'surat-keterangan-tidak-mampu';
          String pdfUrl =
              documentUrl + "?id_sktm=" + data[0]['id_sktm'].toString();

          String safeNama = nama.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String safeJudul =
              sktm_judul.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String fileName = "$safeNama-$safeJudul.pdf";

          Directory? directory = await getExternalStorageDirectory();
          if (directory == null) {
            print("External directory tidak ditemukan");
            return;
          }

          String filePath = "${directory.path}/$fileName";

          Response pdfResponse = await dio.get(
            pdfUrl,
            options: Options(
              responseType: ResponseType.bytes,
            ),
          );

          if (pdfResponse.statusCode == 200) {
            File file = File(filePath);
            await file.writeAsBytes(pdfResponse.data, flush: true);
            print("File berhasil diunduh di: $filePath");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("File Surat Konfirmasi berhasil diunduh!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            print(
                "Gagal mendownload file PDF, status code: ${pdfResponse.statusCode}");
          }
        } else {
          print("Data kosong");
        }
      } else {
        print("Gagal mengambil data, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> download_AdministrasiTanah(BuildContext context) async {
    try {
      String documentUrl =
          'http://10.0.2.2:8080/essentials_api/get_ad_tanah.php';

      Dio dio = Dio();
      Response response = await dio.get(
        documentUrl,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data.isNotEmpty) {
          String nama = data[0]['nama'] ?? 'pengguna';
          String tan_judul = data[0]['tan_judul'] ?? 'surat-keterangan-harga-tanah';
          String pdfUrl =
              documentUrl + "?id_tanah=" + data[0]['id_tanah'].toString();

          String safeNama = nama.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String safeJudul =
              tan_judul.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String fileName = "$safeNama-$safeJudul.pdf";

          Directory? directory = await getExternalStorageDirectory();
          if (directory == null) {
            print("External directory tidak ditemukan");
            return;
          }

          String filePath = "${directory.path}/$fileName";

          Response pdfResponse = await dio.get(
            pdfUrl,
            options: Options(
              responseType: ResponseType.bytes,
            ),
          );

          if (pdfResponse.statusCode == 200) {
            File file = File(filePath);
            await file.writeAsBytes(pdfResponse.data, flush: true);
            print("File berhasil diunduh di: $filePath");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("File Surat Konfirmasi berhasil diunduh!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            print(
                "Gagal mendownload file PDF, status code: ${pdfResponse.statusCode}");
          }
        } else {
          print("Data kosong");
        }
      } else {
        print("Gagal mengambil data, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> download_AdministrasiUsaha(BuildContext context) async {
    try {
      String documentUrl =
          'http://10.0.2.2:8080/essentials_api/get_ad_usaha.php';

      Dio dio = Dio();
      Response response = await dio.get(
        documentUrl,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        if (data.isNotEmpty) {
          String nama = data[0]['nama'] ?? 'pengguna';
          String us_judul = data[0]['us_judul'] ?? 'surat-keterangan-usaha';
          String pdfUrl =
              documentUrl + "?id_usaha=" + data[0]['id_usaha'].toString();

          String safeNama = nama.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String safeJudul =
              us_judul.replaceAll(RegExp(r'[^a-zA-Z0-9-_]'), '_');
          String fileName = "$safeNama-$safeJudul.pdf";

          Directory? directory = await getExternalStorageDirectory();
          if (directory == null) {
            print("External directory tidak ditemukan");
            return;
          }

          String filePath = "${directory.path}/$fileName";

          Response pdfResponse = await dio.get(
            pdfUrl,
            options: Options(
              responseType: ResponseType.bytes,
            ),
          );

          if (pdfResponse.statusCode == 200) {
            File file = File(filePath);
            await file.writeAsBytes(pdfResponse.data, flush: true);
            print("File berhasil diunduh di: $filePath");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("File Surat Konfirmasi berhasil diunduh!"),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
          } else {
            print(
                "Gagal mendownload file PDF, status code: ${pdfResponse.statusCode}");
          }
        } else {
          print("Data kosong");
        }
      } else {
        print("Gagal mengambil data, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }
}
