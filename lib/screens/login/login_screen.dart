import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxeloft/screens/auto_screen.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../nav_screen/nav_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final phoneCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    // if(auth.currentUser != null){
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => const NavScreen()),
    //         (Route<dynamic> route) => false,
    //   );
    //   return Scaffold();
    //
    // }else{
      return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 45,
                          child: SvgPicture.asset(
                            'assets/icons/Close.svg',
                            width: 16,
                            height: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/logo at login.svg',
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Text(
                    "Welcome Back!",
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Login to continue",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: phoneCtrl,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Phone Number',
                          prefix: const Text("+91",
                              style: TextStyle(color: Colors.black)),
                          prefixIcon: const Icon(
                            Icons.phone_android_rounded,
                            color: Color(0xFFB3B3B3),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color(0xFFF7F8F8),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFFF7F8F8),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color(0xFFB3B3B3),
                            ),
                          ),
                        ),
                      ),
                      auth.isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () async {
                          // if (phoneController.text.isNotEmpty) {
                          //   try {
                          //      context.read<AuthService>().verifyPhoneNumber(
                          //        phone: "+91${phoneController.text.toString()}",
                          //      );
                          //     Navigator.pushNamed(context, '/otp');
                          //   } catch (e) {
                          //     log(e.toString());
                          //   }
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text("Please enter phone number")),
                          //   );
                          // }

                          if (phoneCtrl.text.isNotEmpty) {
                            try {
                              final msg =
                              await auth.login(phoneCtrl.text.trim());

                              if (msg != null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                    SnackBar(content: Text(msg)));
                              } else {
                                Navigator.pushNamed(
                                    context, "/OtpScreen");
                              }
                            } catch (e) {
                              log(e.toString());
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                  Text("Please enter phone number")),
                            );
                          }
                        },
                        child: Text(
                          "Get OTP",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 92,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 44,
                    children: [
                      Text(
                        "Or Continue With",
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(onTap: () async {
                            try {
                           // UserCredential gUser =
                           await auth.signInWithGoogle();
                           if(auth.currentUser != null){
                             Navigator.pushAndRemoveUntil(
                               context,
                               MaterialPageRoute(builder: (context) => const AutoScreen()),
                                   (Route<dynamic> route) => false,
                             );
                           }

                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                            }

                          },child: SvgPicture.asset('assets/icons/Google Button.svg')),
                          const SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset('assets/icons/Facebook Button.svg'),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6,
                    children: [
                      Text(
                        "Don’t have an account?",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF878787)),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/CreateAccountScreen');
                        },
                        child: Text("SIGN UP",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A9EB7),
                              decoration: TextDecoration.underline,
                              decorationColor: const Color(0xFF1A9EB7),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  // }

  }
}
