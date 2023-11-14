import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/image/custom_image.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        print("System Back Button Clicked");
        return true;
      },
      child: Dialog(
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: AppColors.colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                vertical: 24, horizontal: 16),
            child: Column(
              children: [
                const CustomImage(
                  imageSrc: AppImages.deleteImage,
                  size: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 16),
                  child: Text(
                    "Are you sure about deleting account",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  "Do you really wish to delete your account. deleting your account will automatically remove all your information after 30 days.",
                  style: GoogleFonts.publicSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.colorBlack_3),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 8),
                  child: Text(
                    "Please type DELETE to confirm",
                    style: GoogleFonts.publicSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorBlack),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 60,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.containerColor),
                  child: TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Type.."),
                    cursorColor: AppColors.hintTextColor,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.publicSans(
                        color: AppColors.hintTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () {},
                          titleText: "Maybe Later",
                          buttonColor: AppColors.colorWhite,
                          titleColor: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          titleText: "Delete",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
