import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxeloft/constants/constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => __OnboardingScreenState();
}

class __OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  final List<Onboard> _onboardData = [
    Onboard(
      image: "assets/Illustration/Illustration-0.svg",
      // imageDarkTheme: "assets/Illustration/Illustration_darkTheme_0.png",
      title: "ONLINE PAYMENT",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra quam elementum massa, viverra. Ut turpis consectetur. ",
    ),
    Onboard(
      image: "assets/Illustration/Illustration-1.svg",
      // imageDarkTheme: "assets/Illustration/Illustration_darkTheme_1.png",
      title: "ONLINE SHOPPING",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra quam elementum massa, viverra. Ut turpis consectetur. ",
    ),
    Onboard(
      image: "assets/Illustration/Illustration-2.svg",
      // imageDarkTheme: "assets/Illustration/Illustration_darkTheme_2.png",
      title: "HOME DELIVER SERVICE",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra quam elementum massa, viverra. Ut turpis consectetur. ",
    ),
    // Onboard(
    //   image: "assets/Illustration/Illustration-3.png",
    //   imageDarkTheme: "assets/Illustration/Illustration_darkTheme_3.png",
    //   title: "Package tracking",
    //   description:
    //       "In particular, Shop can pack your orders, and help you seamlessly manage your shipments.",
    // ),
    // Onboard(
    //   image: "assets/Illustration/Illustration-4.png",
    //   imageDarkTheme: "assets/Illustration/Illustration_darkTheme_4.png",
    //   title: "Nearby stores",
    //   description:
    //       "Easily track nearby shops, browse through their items and get information about their products.",
    // ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget nextButton(BuildContext context, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: SvgPicture.asset(
        "assets/icons/next-arrow.svg",
        width: 80,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A9EB7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Stack(children: [
            Column(
              children: [
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {
                //       // Navigator.pushNamed(context, logInScreenRoute);
                //     },
                //     child: Text(
                //       "Skip",
                //       style: TextStyle(
                //           color: Theme.of(context).textTheme.bodyLarge!.color),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _onboardData.length,
                    onPageChanged: (value) {
                      setState(() {
                        _pageIndex = value;
                      });
                    },
                    itemBuilder: (context, index) => _OnboardingContent(
                      title: _onboardData[index].title,
                      description: _onboardData[index].description,
                      image: (Theme.of(context).brightness == Brightness.dark &&
                              _onboardData[index].imageDarkTheme != null)
                          ? _onboardData[index].imageDarkTheme!
                          : _onboardData[index].image,
                      // isTextOnTop: index.isOdd,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ...List.generate(
                                  _onboardData.length,
                                  (index) => Padding(
                                    padding:
                                        const EdgeInsets.only(right: 16 / 4),
                                    child: DotIndicator(
                                        isActive: index == _pageIndex),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, "/LoginScreen");
                            },
                            child: Text(
                              "Skip>>",
                              style: GoogleFonts.poppins(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: const Color(0xFFFF9B01),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                          ),

                          // button with arrow
                          SizedBox(
                              height: 80,
                              width: 80,
                              child: nextButton(context, () {
                                if (_pageIndex < _onboardData.length - 1) {
                                  _pageController.nextPage(
                                      curve: Curves.ease,
                                      duration: defaultDuration);
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, "/LoginScreen");
                                }
                              })),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}

class Onboard {
  final String image, title, description;
  final String? imageDarkTheme;

  Onboard({
    required this.image,
    required this.title,
    this.description = "",
    this.imageDarkTheme,
  });
}

class _OnboardingContent extends StatelessWidget {
  const _OnboardingContent({
    required this.title,
    required this.description,
    required this.image,
  });

  final String title, description, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SvgPicture.asset(
            image,
            height: 250,
          ),
        ),
        Container(
          constraints:
              const BoxConstraints(minWidth: double.infinity, minHeight: 326),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Text(title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: const Color(0xFFFFAF00)))),
              const SizedBox(height: 35),
              Text(description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color(0xFF8B8B8B),
                      )),
            ],
          ),
        )
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.inActiveColor,
    this.activeColor = const Color(0xFFFF9B01),
  });

  final bool isActive;

  final Color? inActiveColor, activeColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: defaultDuration,
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive
            ? activeColor
            : inActiveColor ?? primaryMaterialColor.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}
