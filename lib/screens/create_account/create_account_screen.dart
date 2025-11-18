import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 68,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// from login start
                    const SizedBox(
                      height: 45,
                    ),
                    Text(
                      "Create Account",
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 40),

                    /// from login end
                    // const SizedBox(height: 40),
                    //
                    // /// TITLE
                    // const Text(
                    //   "Create Account",
                    //   style: TextStyle(
                    //     fontSize: 26,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    //
                    // const SizedBox(height: 8),
                    //
                    // /// SUBTITLE
                    // const Text(
                    //   "Sign Up",
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     color: Colors.black54,
                    //   ),
                    // ),
                    //
                    // const SizedBox(height: 40),

                    /// Email Field
                    _buildInputField(
                      hint: "Email",
                      icon: Icons.email_outlined,
                      obscure: false,
                      trailingIcon: false,
                    ),
                    const SizedBox(height: 16),

                    /// Password with special characters
                    _buildInputField(
                      hint: "Special Characters",
                      icon: Icons.lock_outline,
                      obscure: true,
                      trailingIcon: true,
                    ),
                    const SizedBox(height: 16),

                    /// Repeat Password
                    _buildInputField(
                      hint: "Repeat Password",
                      icon: Icons.lock_outline,
                      obscure: true,
                      trailingIcon: true,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      // controller: phoneController,
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
                  ],
                ),

                // const Spacer(),

                /// NEXT BUTTON
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1CA6C0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(40), // pill shape
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "NEXT",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Text(
                      "Or Continue With",
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 5,
                        children: [
                          SvgPicture.asset('assets/icons/Apple Button.svg'),
                          SvgPicture.asset('assets/icons/Google Button.svg'),
                          SvgPicture.asset('assets/icons/Facebook Button.svg'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// -----------------------------------------
  /// REUSABLE INPUT FIELD WIDGET
  /// -----------------------------------------
  Widget _buildInputField({
    required String hint,
    required IconData icon,
    required bool obscure,
    required bool trailingIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Colors.grey),
          suffixIcon: trailingIcon
              ? const Icon(Icons.visibility_off, color: Colors.grey)
              : obscure
                  ? const Icon(Icons.visibility, color: Colors.grey)
                  : null,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
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
    );
  }
}
