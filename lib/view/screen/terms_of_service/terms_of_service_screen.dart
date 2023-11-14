import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.colorBlack,
        body: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              const TopCurve(),
              Positioned(
                top: 64,
                left: 20, right: 0,
                child: AppBarLeading(
                  pressed: () => Get.offAndToNamed(AppRoute.settingScreen),
                  title: "Terms of service",
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 135),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(16))
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 30, horizontal: 20),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 48),
                          child: Text(
                            "Every good creation begins with a passion, and EzyRack was born of Ken's passionate dislike of clutter. Unable to find the things he needed and running out of space, Ken was done with his chaotic home. Using tools he found in his garage, he created a shelving system to organise his stuff but it wasn't enough. Ken needed an agile and reliable storage product",
                            style: GoogleFonts.publicSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.colorBlack),
                          ),
                        ),
                        Text(
                          "Review Terms & Conditions",
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.colorBlack),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 70),
                          child: Text(
                            "We believe your environment impacts your daily outlook. A serviceable space helps you feel in charge and clutter drags you down. Everyone should have the ability to shape the space they live in. EzyRack exists to ensure your lifestyle is not limited by inflexible storage.",
                            style: GoogleFonts.publicSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.colorBlack),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}