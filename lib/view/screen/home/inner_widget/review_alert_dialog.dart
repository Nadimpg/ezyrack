import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';

class ReviewAlertDialog extends StatelessWidget {

  const ReviewAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          padding: const EdgeInsetsDirectional.only(top: 24, bottom: 24, start: 16, end: 16),
          decoration: BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.circular(16)
          ),
          child: Column(
            children: [
              Text(
                "How was our services?",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: AppColors.colorBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "(Give 1 to 5 stars about our services)",
                textAlign: TextAlign.center,
                style: GoogleFonts.publicSans(
                    color: AppColors.colorBlack_1,
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {
                          Get.back();
                      },
                      titleText: "No",
                      buttonColor: AppColors.transparentColor,
                      titleColor: AppColors.primaryColor,
                      buttonWidth: MediaQuery.of(context).size.width,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () => Get.offAndToNamed(AppRoute.productListScreen),
                      titleText: "Yes",
                      buttonColor: AppColors.primaryColor,
                      titleColor: AppColors.colorWhite,
                      buttonWidth: MediaQuery.of(context).size.width,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
