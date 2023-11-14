import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/utils/app_colors.dart';

class AuthDivider extends StatelessWidget {

  final String authDividerTitle;
  const AuthDivider({required this.authDividerTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.fieldFillColor,
            thickness: 2.0,
            height: 20,
            endIndent: 10,
            indent: 15,
          ),
        ),
        Text(
          authDividerTitle,
          style: GoogleFonts.publicSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.colorBlack
          )
        ),
        const Expanded(
          child: Divider(
            color: AppColors.fieldFillColor,
            thickness: 2.0,
            height: 5,
            endIndent: 15,
            indent: 10,
          ),
        ),
      ],
    );
  }
}
