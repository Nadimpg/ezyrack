import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';

class AllItemEmptySection extends StatelessWidget {

  const AllItemEmptySection({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImages.emptyBox),
          const SizedBox(height: 16),
          Text(
            "Do you want to add EzyRack Box?",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: AppColors.colorBlack,
              fontSize: 24,
              fontWeight: FontWeight.w600
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Sorry, the Box you are looking for doesn't exist or has been moved. Try to add EzyRack box.",
            textAlign: TextAlign.center,
            style: GoogleFonts.publicSans(
                color: AppColors.colorBlack.withOpacity(0.5),
                fontSize: 14,
                fontWeight: FontWeight.w400
            ),
          ),
          const SizedBox(height: 40),
          CustomElevatedButton(
            buttonWidth: MediaQuery.of(context).size.width,
            onPressed: () => Get.toNamed(AppRoute.qrScanScreen),
            titleText: "Add EzyRack Box"
          )
        ],
      ),
    );
  }
}
