import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/widgets/image/custom_image.dart';

class ErrorDetails extends StatelessWidget {
  const ErrorDetails(
      {super.key,
      required this.title,
      required this.details,
      this.child,
      this.imageSrc = AppImages.noInternetImage,
      this.subText = ""});

  final String title, details;
  final String subText;
  final Widget? child;
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImage(
            imageSrc: imageSrc,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              subText,
              style: GoogleFonts.publicSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorBlack),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: GoogleFonts.montserrat(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorBlack),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Text(
              textAlign: TextAlign.center,
              details,
              style: GoogleFonts.publicSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.colorBlack_2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: child,
          ),
        ],
      ),
    );
  }
}
