import 'package:flutter/material.dart';
import 'package:ezyrack/utils/app_colors.dart';

class QrCodeBottomNavBar extends StatelessWidget {

  final Widget child;
  final Color backgroundColor;

  const QrCodeBottomNavBar({
    required this.child,
    this.backgroundColor = AppColors.colorWhite,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 88,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsetsDirectional.only(top: 15, start: 15, end: 15, bottom: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorBlack.withOpacity(0.2),
            blurStyle: BlurStyle.outer,
            blurRadius: 22,
            offset: const Offset(0, 4)
          )
        ]
      ),
      child: child,
    );
  }
}
