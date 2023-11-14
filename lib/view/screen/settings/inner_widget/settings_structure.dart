import 'package:flutter/material.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';

class SettingStructure extends StatelessWidget {
  const SettingStructure(
      {super.key,
      required this.title,
      this.child,
      this.boxWidth = 100,
      this.paddingRight = 20,
      this.paddingLeft = 20,
      this.paddingTop = 32,
      required this.onTap,
      this.backColor = AppColors.colorWhite,
      this.vertical = 50,
      this.leftPositioned,
      this.rightPositioned});

  final String title;
  final Widget? child;
  final double boxWidth;
  final double vertical;
  final double? leftPositioned;
  final double? rightPositioned;
  final VoidCallback onTap;
  final Color backColor;

  final double paddingRight, paddingLeft, paddingTop;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppBarLeading(
          pressed: onTap,
          title: title,
        ),
        Container(
          height: 30,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
          decoration: BoxDecoration(
            color: AppColors.colorWhite_1,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Positioned(
          top: 160,
          bottom: -50,
          left: leftPositioned,
          right: rightPositioned,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
              left: paddingLeft,
              right: paddingRight,
              top: paddingTop,
            ),
            decoration: BoxDecoration(
              color: backColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
