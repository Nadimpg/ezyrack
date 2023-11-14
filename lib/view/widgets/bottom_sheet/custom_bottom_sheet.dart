import 'package:flutter/material.dart';
import 'package:ezyrack/utils/app_colors.dart';

class CustomBottomSheet{

  final Widget child;
  bool isNeedMargin;
  CustomBottomSheet({required this.child, this.isNeedMargin = false});

  customBottomSheet(BuildContext context){

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColors.transparentColor,
        context: context,
        builder: (BuildContext context) => SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 50),
            curve: Curves.decelerate,
            child: Container(
              margin: isNeedMargin ? const EdgeInsets.only(left: 15, right: 15, bottom: 15) : EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color:Colors.white,//const Color(0xFFF7F8FC),
                  borderRadius: isNeedMargin ? BorderRadius.circular(15) : const BorderRadius.vertical(top: Radius.circular(15))
              ),
              child: child,
            ),
          ),
        )
    );
  }
}