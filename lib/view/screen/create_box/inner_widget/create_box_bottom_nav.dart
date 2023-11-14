import 'package:flutter/material.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_loading_button.dart';

class CreateBoxBottomNav extends StatelessWidget {

  final VoidCallback onPress;
  final bool isSubmitLoading;

  const CreateBoxBottomNav({
    required this.onPress,
    required this.isSubmitLoading,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: const BorderRadiusDirectional.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorBlack.withOpacity(0.1),
              blurStyle: BlurStyle.outer,
              blurRadius: 22,
              offset: const Offset(0, 4)
            )
          ]
        ),
        child: isSubmitLoading ? const CustomElevatedLoadingButton() : CustomElevatedButton(
          onPressed: onPress,
          titleText: "EZYRack Box Confirm"
        ),
      ),
    );
  }
}
