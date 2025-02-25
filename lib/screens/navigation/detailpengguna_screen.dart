import 'dart:convert';
import 'package:essentials/screens/navigation/profile_screen.dart';
import 'package:essentials/services/update/update_user_services.dart';
import 'package:essentials/services/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DetailPenggunaScreen extends StatefulWidget {
  const DetailPenggunaScreen({super.key});

  @override
  _DetailPenggunaScreenState createState() => _DetailPenggunaScreenState();
}

class _DetailPenggunaScreenState extends State<DetailPenggunaScreen> {
  final UpdateUserService _UpdateUserService = UpdateUserService();
  final TextEditingController _noKKController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  String selectedDusun = "Belum Memilih";
  String selectedRt = "Belum Memilih";
  String selectedRw = "Belum Memilih";
  Map<String, dynamic>? userData;
  String id_user = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userSession = Provider.of<UserSession>(context, listen: false);
      id_user = userSession.id_user ?? "";

      Map<String, dynamic>? data = await getUser(id_user);
      if (data != null) {
        setState(() {
          userData = data;
          selectedDusun = data["dusun"]?.toString().trim() ?? "Belum Memilih";
          selectedRt = data["rt"]?.toString().trim() ?? "Belum Memilih";
          selectedRw = data["rw"]?.toString().trim() ?? "Belum Memilih";
        });
      }
    });
  }

  Future<Map<String, dynamic>?> getUser(String id_user) async {
    String url =
        'http://10.0.2.2:8080/essentials_api/get_user.php?id_user=$id_user';

    try {
      var response = await http.get(Uri.parse(url));
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data is List && data.isNotEmpty
            ? data[0]
            : (data is Map<String, dynamic> ? data : null);
      } else {
        throw Exception('Gagal mengambil data');
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<void> updateUser() async {
    if (_noKKController.text.isEmpty) {
      _showSnackbar('No KK tidak boleh kosong');
      return;
    }
    if (_noKKController.text.length != 16) {
      _showSnackbar('No KK harus 16 karakter');
      return;
    }
    if (selectedDusun == 'Belum Memilih') {
      _showSnackbar('Dusun tidak boleh kosong');
      return;
    }
    if (selectedRt == 'Belum Memilih') {
      _showSnackbar('RT tidak boleh kosong');
      return;
    }
    if (selectedRw == 'Belum Memilih') {
      _showSnackbar('RW tidak boleh kosong');
      return;
    }
    if (_pekerjaanController.text.isEmpty) {
      _showSnackbar('Pekerjaan tidak boleh kosong');
      return;
    }

    await _UpdateUserService.user(
      _noKKController.text,
      selectedDusun,
      selectedRt,
      selectedRw,
      _pekerjaanController.text,
      context,
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            height: 1.2,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
        title: Text(
          'Detail Pengguna',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xffF9F9F9),
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xffF9F9F9),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _text(),
                const SizedBox(height: 24),
                _data(),
                const SizedBox(height: 42),
                _saveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _text() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lengkapi data diri Anda, sebelum mengakses layanan Pelaporan atau Admnistrasi',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            height: 1.2,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Column _data() {
    String nama = userData?["nama"] ?? "Nama Pengguna";
    String nik = userData?["nama"] ?? "NIK Pengguna";
    String kk = userData?["kk"]?.toString() ?? "";
    String dusun = userData?["dusun"]?.toString() ?? "";
    String rt = userData?["rt"]?.toString() ?? "";
    String rw = userData?["rw"]?.toString() ?? "";
    String pekerjaan = userData?["pekerjaan"]?.toString() ?? "";
    String noHp = userData?["no_hp"]?.toString() ?? "No Handphone Pengguna";
    String email = userData?["email"]?.toString() ?? "Email Pengguna";
    String password = userData?["password"]?.toString() ?? "Password Pengguna";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoField('Nama sesuai KTP', nama),
        const SizedBox(height: 12),
        _buildInfoField('NIK', nik),
        const SizedBox(height: 12),
        kk.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'No KK',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '*',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 42,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffD9D9D9),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _noKKController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "16 Digit angka No KK ...",
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 11),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(16),
                      ],
                    ),
                  ),
                ],
              )
            : _buildInfoField('No KK', kk),
        const SizedBox(height: 12),
        dusun.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Dusun',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '*',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    child: Container(
                      height: 42,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xffD9D9D9),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _getSelectedDusun(),
                          items: <String>[
                            'Belum Memilih',
                            'Pereng',
                            'Kedungsari',
                            'Jatimulyo',
                            'Geneng'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null && newValue != selectedDusun) {
                              setState(() {
                                selectedDusun = newValue;
                              });
                            }
                          },
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.black),
                          dropdownColor: const Color(0xffF9F9F9),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : _buildInfoField('Dusun', dusun),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: rt.isEmpty
                  ? _buildDropdownField('RT', _getSelectedRt(),
                      (String? newValue) {
                      if (newValue != null && newValue != selectedRt) {
                        setState(() {
                          selectedRt = newValue;
                        });
                      }
                    })
                  : _buildInfoField('RT', rt),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: rw.isEmpty
                  ? _buildDropdownField('RW', _getSelectedRw(),
                      (String? newValue) {
                      if (newValue != null && newValue != selectedRw) {
                        setState(() {
                          selectedRw = newValue;
                        });
                      }
                    })
                  : _buildInfoField('RW', rw),
            ),
          ],
        ),
        const SizedBox(height: 12),
        pekerjaan.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Pekerjaan',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '*',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 42,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffD9D9D9),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _pekerjaanController,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "Pekerjaan utama Anda ...",
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 11),
                      ),
                    ),
                  ),
                ],
              )
            : _buildInfoField('Pekerjaan', pekerjaan),
        const SizedBox(height: 12),
        _buildInfoField('No Handphone', noHp),
        const SizedBox(height: 12),
        _buildInfoField('Email', email),
        const SizedBox(height: 12),
        _buildInfoField('Password', password),
      ],
    );
  }

  String _getSelectedDusun() {
    List<String> validDusun = [
      'Belum Memilih',
      'Pereng',
      'Kedungsari',
      'Jatimulyo',
      'Geneng'
    ];
    return validDusun.contains(selectedDusun) ? selectedDusun : 'Belum Memilih';
  }

  String _getSelectedRt() {
    List<String> validRt = ['Belum memilih', '001', '002', '003', '004', '005'];
    return validRt.contains(selectedRt) ? selectedRt : 'Belum memilih';
  }

  String _getSelectedRw() {
    List<String> validRw = ['Belum memilih', '001', '002', '003', '004', '005'];
    return validRw.contains(selectedRw) ? selectedRw : 'Belum memilih';
  }

  Widget _buildDropdownField(
      String label, String selectedValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '*',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        GestureDetector(
          child: Container(
            height: 42,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xffD9D9D9),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                items: <String>[
                  'Belum memilih',
                  '001',
                  '002',
                  '003',
                  '004',
                  '005'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                dropdownColor: const Color(0xffF9F9F9),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoField(String label, value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 42,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xffD9D9D9),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget _saveButton() {
    String nama = userData?["nama"] ?? "";
    String nik = userData?["nik"] ?? "";
    String kk = userData?["kk"]?.toString() ?? "";
    String dusun = userData?["dusun"]?.toString() ?? "";
    String rt = userData?["rt"]?.toString() ?? "";
    String rw = userData?["rw"]?.toString() ?? "";
    String pekerjaan = userData?["pekerjaan"]?.toString() ?? "";
    String noHp = userData?["no_hp"]?.toString() ?? "";
    String email = userData?["email"]?.toString() ?? "";
    String password = userData?["password"]?.toString() ?? "";

    bool isAnyFieldEmpty = [
      nama,
      nik,
      kk,
      dusun,
      rt,
      rw,
      pekerjaan,
      noHp,
      email,
      password
    ].any((element) => element.isEmpty);

    if (!isAnyFieldEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00AA13),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: () {
          updateUser();
        },
        child: Text(
          'Simpan',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
