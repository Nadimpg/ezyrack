import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/utils/app_static_strings.dart';
import 'package:ezyrack/view/screen/product_review/ezyrack_product_review/inner_widget/review_greetings_dialog.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/image/custom_image.dart';
import 'package:ezyrack/view/widgets/textfields/custom_textfield.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';

class EzyRackProductReviewScreen extends StatefulWidget {
  const EzyRackProductReviewScreen({super.key});

  @override
  State<EzyRackProductReviewScreen> createState() => _EzyRackProductReviewScreenState();
}

class _EzyRackProductReviewScreenState extends State<EzyRackProductReviewScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.colorBlack,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => Stack(
            clipBehavior: Clip.none,
            children: [
              const TopCurve(),
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: AppBarLeading(
                  pressed: () => Get.offAndToNamed(AppRoute.productListScreen),
                  title: "Products Review",
                ),
              ),
              Positioned(
                top: 180, bottom: -50, left: 0, right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: AppColors.containerColor,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 100),
                    child: Column(
                      children: [
                        const CustomImage(imageSrc: AppImages.emptyBox, imageType: ImageType.svg),
                        const SizedBox(height: 16),
                        Text(
                          textAlign: TextAlign.center,
                          AppStaticStrings.lorem,
                          style: GoogleFonts.publicSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.hintTextColor),
                        ),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 20),
                        CustomTextField(
                          isPrefixIcon: false,
                          textEditingController: TextEditingController(),
                          hintText: "Type Review Details...",
                          maxLines: 3,
                        ),
                        const SizedBox(height: 24),
                        CustomElevatedButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => const ReviewGreetingsDialog()
                          ),
                          titleText: "Send Review",
                          buttonWidth: double.infinity,buttonHeight: 60,
                        )
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
