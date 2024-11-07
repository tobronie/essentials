import 'package:essentials/screens/navigation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Timer? _timer;
  int _seconds = 0;
  int _minutes = 1;
  bool _isTimerFinished = false;

  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds == 0) {
          if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else {
            _timer?.cancel();
            _isTimerFinished = true;
          }
        } else {
          _seconds--;
        }
      });
    });
  }

  String _formatTime() {
    String _secondsString = _seconds.toString().padLeft(2, '0');
    String _minutesString = _minutes.toString().padLeft(2, '0');
    return '$_minutesString:$_secondsString';
  }

  void _resendOtp() {
    setState(() {
      _minutes = 1;
      _seconds = 0;
      _isTimerFinished = false;
    });
    _startTimer();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1) {
      if (index < _controllers.length - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: IconButton(
              icon: const Icon(
                PhosphorIconsRegular.question,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
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
                Text.rich(
                  TextSpan(
                    text: 'Masukkan kode OTP yang kami kirim ke no handphone: ',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      height: 1.2,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: '088235744617',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5E28FF),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 76),
                Form(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            _formatTime(),
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              letterSpacing: 0.1,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (!_isTimerFinished)
                            SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00AA13)),
                                value: null,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3.0),
                            child: SizedBox(
                              width: 42,
                              height: 56,
                              child: TextFormField(
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFD9D9D9),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  counterText: '',
                                ),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                onChanged: (value) => _onChanged(value, index),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      if (_isTimerFinished)
                        Center(
                          child: TextButton(
                            onPressed: _resendOtp,
                            child: Text(
                              'Kirim ulang kode OTP',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
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
