import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxeloft/screens/nav_screen/navigation/user_tabs_and_body.dart';
import 'package:luxeloft/widgets/user_tab_bar.dart';

import '../../../widgets/image_slider.dart';

class UserHomeScreenBody extends StatelessWidget {
  const UserHomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Hi, Andrea",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "What are you looking for today?",
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 200, child: ImageSlider()),
              ],
            ),
            // const SizedBox(height: 200, child: ImageSlider()),
            const Column(
              children: [
                SizedBox(
                    height: 600,
                    width: double.infinity,
                    child: UserTabAndBody()),
              ],
            ),
            // const SizedBox.expand(child: UserTabAndBody()),
          ],
        ),
      ),
    );
  }
}
