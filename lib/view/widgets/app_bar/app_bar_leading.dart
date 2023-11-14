import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/view/widgets/image/custom_image.dart';

class AppBarLeading extends StatelessWidget {

  final VoidCallback? pressed;
  final Color bgColor;
  final String title;
  final bool fromBottomNav;


  const AppBarLeading({
    this.pressed,
    this.bgColor = AppColors.transparentColor,
    this.title = "Back",
    this.fromBottomNav = false,

    super.key
  });

  @override
  Widget build(BuildContext context) {

    return fromBottomNav ? Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 4),
      color: AppColors.transparentColor,
      child: Text(
        title,
        style: GoogleFonts.publicSans(
            fontSize: 16,
            color: AppColors.colorWhite,
            fontWeight: FontWeight.w500
        ),
      ),
    ) : GestureDetector(
      onTap: pressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 4),
        color: AppColors.transparentColor,
        child: Row(
          children: [
            const CustomImage(imageSrc: AppIcons.leftArrowIcon),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.publicSans(
                  fontSize: 16,
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
      ),
    );
  }
}
