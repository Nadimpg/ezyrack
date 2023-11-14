import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/view/widgets/image/custom_image.dart';

class ProfileCard extends StatelessWidget {

  final String imageSrc;
  final String title;
  final String subTitle;
  final VoidCallback onPressed;

  const ProfileCard({

    required this.imageSrc,
    required this.title,
    required this.subTitle,
    required this.onPressed,

    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: const EdgeInsetsDirectional.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
            color: AppColors.profileCardBgColor,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomImage(imageSrc: imageSrc, imageType: ImageType.svg, size: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.publicSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorBlack
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subTitle,
                    style: GoogleFonts.publicSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.hintTextColor
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
