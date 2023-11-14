 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/utils/app_static_strings.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/image/custom_image.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
                  pressed: () => Get.offAndToNamed(AppRoute.profileScreen),
                  title: "About us",
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
                      children: [
                        const SizedBox(height: 20),
                        Stack(
                          children: [
                            const Positioned(
                                left: -10,
                                child: CustomImage(
                                    imageSrc: AppImages.aboutTopImage,
                                    imageType: ImageType.svg,
                                    size: 100)),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 20, left: 25, right: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Out Story",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.colorBlack),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      AppStaticStrings.aboutOurStory,
                                      style: GoogleFonts.publicSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.colorBlack_3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            const Positioned(
                              right: -10,top: -10,
                              child: CustomImage(
                                  imageSrc: AppImages.aboutBottomImage,
                                  imageType: ImageType.svg,
                                  size: 100),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 70, left: 25, right: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Why do we exist",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.colorBlack),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12,bottom: 100),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      AppStaticStrings.aboutWhyDo,
                                      style: GoogleFonts.publicSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.colorBlack_3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
