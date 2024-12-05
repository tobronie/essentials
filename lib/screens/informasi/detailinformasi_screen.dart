import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';

class InformasiDetailScreen extends StatefulWidget {
  final Map<String, dynamic> information;

  const InformasiDetailScreen({required this.information});

  @override
  _InformasiDetailScreenState createState() => _InformasiDetailScreenState();
}

class _InformasiDetailScreenState extends State<InformasiDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final information = widget.information;
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: IconButton(
              icon: const Icon(
                PhosphorIconsRegular.arrowBendUpRight,
                color: Colors.black,
              ),
              onPressed: () {
                final String shareContent =
                    '${information['image']}\n${information['judul']}\n\nInformasi Selengkapnya di Aplikasi "Essentials" Masyarakat Ds. Kedungmulyo, Kec. Bangilan, Kab. Tuban';
                Share.share(shareContent);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: IconButton(
              icon: const Icon(
                PhosphorIconsRegular.bookmarkSimple,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: const Color(0xffF9F9F9),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(information['image'] ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, top: 8, bottom: 24),
                margin: const EdgeInsets.only(top: 216),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 3,
                      width: 40,
                      color: const Color(0xff00AA13),
                    ),
                    const SizedBox(height: 32),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        information['judul'] ?? '',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          height: 1.2,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Container(
                        height: 2,
                        width: 118,
                        color: const Color(0xffD9D9D9),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          information['kategori'] ?? '',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            height: 1.2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '-',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            height: 1.2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          information['tgl_upload'] != null
                              ? DateFormat('dd MMM yyyy').format(
                                  (information['tgl_upload'] as Timestamp)
                                      .toDate(),
                                )
                              : 'Tanggal tidak tersedia',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            height: 1.2,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        information['isi'] ?? '',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          height: 1.2,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
