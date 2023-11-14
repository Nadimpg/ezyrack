import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/utils/app_colors.dart';

class CustomElevatedButtonWithIcon extends StatelessWidget {

  final VoidCallback onPressed;
  final String titleText;
  final Color titleColor;
  final Color buttonColor;
  final Color buttonBorderColor;
  final Color ? iconColor;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double? buttonWidth;
  final double buttonBorderWidth;
  final double iconSize;
  final String iconSrc;

  const CustomElevatedButtonWithIcon({
    required this.onPressed,
    required this.titleText,
    this.titleColor = AppColors.colorWhite,
    this.buttonColor = AppColors.primaryColor,
    this.buttonBorderColor = AppColors.primaryColor,
    this.iconColor ,
    this.titleSize = 16,
    this.buttonRadius = 12,
    this.titleWeight = FontWeight.w600,
    this.buttonHeight = 60,
    this.buttonBorderWidth = 1,
    this.buttonWidth,
    this.iconSize = 24,
     required this.iconSrc,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: BorderSide(
                color: buttonBorderColor,
                width: buttonBorderWidth
              ),
              borderRadius: BorderRadius.circular(buttonRadius)),
            ),
            elevation: MaterialStateProperty.all(0)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(iconSrc, color: iconColor, height: iconSize, width: iconSize),
            const SizedBox(width: 10),
            Text(
              titleText,
              style: GoogleFonts.publicSans(
                color: titleColor,
                fontSize: titleSize,
                fontWeight: titleWeight
              ),
            )
          ],
        ),
      ),
    );
  }
}
