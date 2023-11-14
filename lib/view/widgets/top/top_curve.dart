import 'package:flutter/material.dart';
import 'package:ezyrack/utils/app_colors.dart';

class TopCurve extends StatelessWidget {
  const TopCurve({
    super.key,
    this.bottomCircleColor = AppColors.colorWhite,
    this.aboveCircleColor = AppColors.colorWhite,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.child,
    this.alignment = Alignment.center
  });

  final Color bottomCircleColor;
  final Color aboveCircleColor;
  final double? top, bottom, left, right;
  final Widget? child;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -200,
          left: -110,
          child: Container(
            height: 360,
            width: 360,
            decoration: BoxDecoration(
                color: aboveCircleColor.withOpacity(0.02),
                shape: BoxShape.circle),
          ),
        ),
        Positioned(
          top: -190,
          left: -90,
          child: Container(
            height: 410,
            width: 410,
            decoration: BoxDecoration(
                color: bottomCircleColor.withOpacity(0.02),
                shape: BoxShape.circle),
          ),
        ),
        Positioned(
          top: top,
          bottom: bottom,
          left: left,
          right: right,
          child: Align(alignment: alignment, child: child),
        ),
      ],
    );
  }
}
