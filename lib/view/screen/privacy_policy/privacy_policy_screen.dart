import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                  title: "Privacy policy",
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
                        Text(
                          "Privacy policy",
                          style: GoogleFonts.montserrat(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: AppColors.colorBlack),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 48),
                          child: Text(
                            '''If your interested our story from a cluttered corner in my own home to your hands, Ezyrack's journey began with a few pieces of leftover strut in my chaotic shed. After two years, navigating through five countries, a pandemic, and numerous challenges, Ezyrack emerged—a testament to passion and resilience. More than just storage, Ezyrack understands that every space tells a unique story. We've simplified assembly, requiring minimal tools and uniform bolt sizes. With us, you’re not just organizing; you're curating a lifestyle. Your pictures showcasing our products? That’s our success story.
                              — Ken, Founder of Ezyrack''',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.publicSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.colorBlack,
                              height: 1.5
                            ),
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