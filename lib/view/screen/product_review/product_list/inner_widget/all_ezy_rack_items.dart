import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/card/custom_card.dart';

class AllEzyRackItems extends StatelessWidget {
  const AllEzyRackItems({super.key});

  @override
  Widget build(BuildContext context) {

    return Positioned(
      top: 180, bottom: -50, left: 0, right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 50),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
              20,
              (index) => CustomCard(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "EzyRack Mesh Shelf",
                                style: GoogleFonts.publicSans(
                                    color: AppColors.cardTitleColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "EZY-2023-006",
                                style: GoogleFonts.publicSans(
                                    color: AppColors.cardContentColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SvgPicture.asset(
                            AppImages.carBoxImage,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomElevatedButton(onPressed: (){
                      Get.offAndToNamed(AppRoute.ezyRackProductReviewScreen);
                    }, titleText: "Review",buttonWidth: double.infinity,buttonHeight: 45)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
