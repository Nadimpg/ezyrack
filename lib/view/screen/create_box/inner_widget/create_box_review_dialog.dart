import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';

class CreateBoxReviewDialog extends StatefulWidget {

  const CreateBoxReviewDialog({super.key});

  @override
  State<CreateBoxReviewDialog> createState() => _CreateBoxReviewDialogState();
}

class _CreateBoxReviewDialogState extends State<CreateBoxReviewDialog> {

  int selectedIndex = -1;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          padding: const EdgeInsetsDirectional.only(top: 40, bottom: 20),
          decoration: BoxDecoration(
              color: AppColors.colorWhite,
              borderRadius: BorderRadius.circular(16)
          ),
          child: Column(
            children: [
              Text(
                "How was our Services?",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: AppColors.colorBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(height: 9),
              Text(
                "(Give 1 to five stars about our Services)",
                textAlign: TextAlign.center,
                style: GoogleFonts.publicSans(
                    color: AppColors.colorBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(height: 27),
              RatingBar.builder(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: AppColors.statusWarningTextColor,
                ),
                onRatingUpdate: (rating) {},
              ),
              const SizedBox(height: 30),
              SingleChildScrollView(
                padding: const EdgeInsetsDirectional.only(start: 16),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: List.generate(2, (index) => GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      padding: const EdgeInsetsDirectional.all(16),
                      margin: const EdgeInsetsDirectional.only(end: 8),
                      decoration: BoxDecoration(
                          color: AppColors.transparentColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: index == selectedIndex ? AppColors.primaryColor : AppColors.colorBlack.withOpacity(0.3), width: 1)
                      ),
                      child: Text(
                        "Every good creation begins with a passion, & was born of Ken's passionate of clutter.",
                        style: GoogleFonts.publicSans(
                            color: AppColors.colorBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  )),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Checkbox(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            activeColor: AppColors.primaryColor,
                            checkColor: AppColors.colorWhite,
                            value: isChecked,
                            side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                  width: 1.0,
                                  color: isChecked ? AppColors.primaryColor : AppColors.colorBlack_3
                              ),
                            ),
                            onChanged: (value){}
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "I want to customize this review",
                        style: GoogleFonts.publicSans(
                            fontSize: 14,
                            color: AppColors.colorBlack_3,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                child: CustomElevatedButton(
                    buttonWidth: MediaQuery.of(context).size.width,
                    onPressed: () => Get.offAndToNamed(AppRoute.greetingScreen),
                    titleText: "Share Review"
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
