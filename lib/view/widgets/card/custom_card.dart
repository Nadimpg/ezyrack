import 'package:flutter/material.dart';
import 'package:ezyrack/utils/app_colors.dart';

class CustomCard extends StatelessWidget {

  final Color cardBgColor;
  final Color cardBorderColor;
  final double elevation;
  final double borderWidth;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;
  final Widget child;

  const CustomCard({

    this.cardBgColor = AppColors.cardColor,
    this.cardBorderColor = AppColors.cardShadowColor,
    this.elevation = 0,
    this.borderWidth = 1,
    this.borderRadius = 12,
    this.horizontalPadding = 16,
    this.verticalPadding = 16,
    required this.child,

    super.key
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      color: cardBgColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: cardBorderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius)
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        child: child,
      ),
    );
  }
}
