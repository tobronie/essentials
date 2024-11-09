import 'package:essentials/screens/authentication/otp_screen.dart';
import 'package:essentials/screens/help/listproblem_screen.dart';
import 'package:essentials/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final LoginService _loginService = LoginService();
  final TextEditingController _noHpController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _noHpController.addListener(() {
      if (_noHpController.text.isEmpty ||
          !_noHpController.text.startsWith('+62')) {
        _noHpController.text = '+62';
        _noHpController.selection = TextSelection.fromPosition(
            TextPosition(offset: _noHpController.text.length));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OnboardingScreen()),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: IconButton(
              icon: const Icon(
                PhosphorIconsRegular.question,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListProblemScreen()),
                );
              },
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Color(0xffF9F9F9),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Selamat datang!',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Masuk dan akses akun Anda untuk menikmati semua fitur yang tersedia.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 62),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _noHpController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'No Handphone ',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    letterSpacing: 0.1,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: '*',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        onTap: () {
                          if (_noHpController.text.isEmpty) {
                            _noHpController.text = '+62';
                            _noHpController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _noHpController.text.length));
                          }
                        },
                        onChanged: (value) {
                          if (!value.startsWith('+62')) {
                            _noHpController.text = '+62';
                            _noHpController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _noHpController.text.length));
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(18),
                        ],
                      ),
                      const SizedBox(height: 52),
                      SizedBox(
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
                            if (_noHpController.text.isEmpty ||
                                _noHpController.text == '+62') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'No Handphone tidak boleh kosong',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      height: 1.2,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              );
                              return;
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtpScreen()),
                            );
                          },
                          child: Text(
                            'Kirim kode OTP',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Container(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'from ',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'NIE',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
