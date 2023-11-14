import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/image/custom_image.dart';
import 'package:ezyrack/view/widgets/textfields/custom_textfield.dart';

class ReviewGreetingsDialog extends StatelessWidget {
  const ReviewGreetingsDialog({super.key});

  @override
  Widget build(BuildContext context) {

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: AppColors.colorWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.circular(16)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomImage(
                imageSrc: AppIcons.greetingIcon,
                size: 130,
              ),
              const SizedBox(height: 8),
              Text(
                "Thank You For Review",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorBlack,
                    fontSize: 20
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Your now in the draw for free EZYrack product upgrade drawn Monthly, Watch your notification's to see if your monthly winner",
                textAlign: TextAlign.center,
                style: GoogleFonts.publicSans(
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorBlack_1,
                    fontSize: 14
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "You get extra 5% discount for next EXYRACK products purchases.",
                textAlign: TextAlign.center,
                style: GoogleFonts.publicSans(
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorBlack_1,
                    fontSize: 14
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    flex: 3,
                    child:  CustomTextField(
                      isPrefixIcon: false,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: CustomElevatedButton(
                        onPressed: (){},
                        titleText: "Copy"
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              CustomElevatedButton(
                onPressed: () => Get.offAndToNamed(AppRoute.homeScreen),
                titleText: "Back to home",
                buttonColor: AppColors.transparentColor,
                titleColor: AppColors.primaryColor,
                buttonWidth: MediaQuery.of(context).size.width,
              )
            ],
          ),
        ),
      ),
    );
  }
}
