import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../services/auth_provider.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final otpCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        // leading: SvgPicture.asset("assets/icons/leading_back.svg"),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 45,
                  ),
                  Text(
                    "OTP Verification",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Enter the verification code we just sent on your email address.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8391A1)),
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // TextField(
                      //   // controller: phoneController,
                      //   keyboardType: TextInputType.phone,
                      //   maxLength: 10,
                      //
                      //   decoration: InputDecoration(
                      //     fillColor: Colors.white,
                      //     hintText: 'Phone Number',
                      //     prefix: const Text("+91",
                      //         style: TextStyle(color: Colors.black)),
                      //     prefixIcon: const Icon(
                      //       Icons.phone_android_rounded,
                      //       color: Color(0xFFB3B3B3),
                      //     ),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(20),
                      //       borderSide: const BorderSide(
                      //         color: Color(0xFFF7F8F8),
                      //       ),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(
                      //         color: Color(0xFFF7F8F8),
                      //       ),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(20),
                      //       borderSide: const BorderSide(
                      //         color: Color(0xFFB3B3B3),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      TextField(
                        controller: otpCtrl,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: "Enter OTP"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () async {
                          if (otpCtrl.text.isNotEmpty) {
                            try {
                              final msg =
                                  await auth.verifyOTP(otpCtrl.text.trim());

                              if (msg != null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text(msg)));
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, "/home");
                              }
                            } catch (e) {
                              log(e.toString());
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please enter phone number")),
                            );
                          }
                        },
                        child: Text(
                          "VERIFY",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
