import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String titleText;
  final Color titleColor;
  final Color buttonColor;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double? buttonWidth;

   const CustomElevatedButton({
      required this.onPressed,
      required this.titleText,
      this.titleColor = AppColors.colorWhite,
      this.buttonColor = AppColors.primaryColor,
      this.titleSize = 16,
      this.buttonRadius = 12,
      this.titleWeight = FontWeight.w600,
      this.buttonHeight = 60,
      this.buttonWidth,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius),
                side: const BorderSide(color: AppColors.primaryColor, width: 1.0),
              ),
            ),
            elevation: MaterialStateProperty.all(0)),
        child: Text(
          titleText,
          textAlign: TextAlign.center,
          style: GoogleFonts.publicSans(
            color: titleColor, fontSize: titleSize, fontWeight: titleWeight
          ),
        ),
      ),
    );
  }
}
