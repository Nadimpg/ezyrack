import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';

class BoxDetailsBottomNav extends StatelessWidget {

  final String qrCode;

  const BoxDetailsBottomNav({required this.qrCode, super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
            color: AppColors.colorWhite,
            boxShadow: [
              BoxShadow(
                  color: AppColors.colorBlack.withOpacity(0.1),
                  blurStyle: BlurStyle.outer,
                  blurRadius: 22,
                  offset: const Offset(0, 4)
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomElevatedButton(
                onPressed: () => Get.offAndToNamed(AppRoute.homeScreen),
                titleText: "Back to home",
                buttonColor: AppColors.transparentColor,
                buttonWidth: MediaQuery.of(context).size.width,
                titleColor: AppColors.primaryColor,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomElevatedButton(
                onPressed: () => Get.toNamed(AppRoute.editBoxScreen, arguments: qrCode),
                titleText: "Edit your box"
              ),
            )
          ],
        ),
      ),
    );
  }
}
