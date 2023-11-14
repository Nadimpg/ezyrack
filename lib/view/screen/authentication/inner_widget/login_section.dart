import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/utils/app_static_strings.dart';
import 'package:ezyrack/view/screen/Authentication/inner_widget/auth_divider.dart';
import 'package:ezyrack/view/screen/authentication/authentication_controller.dart';
import 'package:ezyrack/view/widgets/buttons/custom_button_with_icon.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:ezyrack/view/widgets/textfields/custom_textfield.dart';

class LoginSection extends StatefulWidget {
  const LoginSection({super.key});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthenticationController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  textEditingController: controller.usernameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  prefixIconSrc: AppIcons.emailIcon,
                  hintText: "Email",
                  hintStyle: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
                  fieldBorderColor: AppColors.fieldBorderColor,
                  validator: (value) {
                    if(value!.isEmpty || !value.contains("@") || !controller.emailRegExP.hasMatch(value))
                    {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  textEditingController: controller.passwordController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIconSrc: AppIcons.passwordIcon,
                  isPassword: true,
                  hintText: "Password",
                  hintStyle: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
                  fieldBorderColor: AppColors.fieldBorderColor,
                  validator: (value){
                    if(value!.isEmpty || value.length < 8) {
                      return "Please, use more than 6 characters long password";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => Get.toNamed(AppRoute.forgetPasswordScreen),
                child: Text(
                  "${AppStaticStrings.forgetPassword}?",
                  style: GoogleFonts.publicSans(
                      fontSize: 16,
                      color: AppColors.dangerTextColor,
                      fontWeight: FontWeight.w500
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 32),
          controller.isLoading ? const CustomElevatedLoadingButton() : CustomElevatedButton(
            onPressed: () {
              if(formKey.currentState!.validate()){
                controller.loginUser(controller.usernameController.text.toString(), controller.passwordController.text.toString());
              }
            },
            titleText: "Log In",
            titleColor: AppColors.colorWhite,
            titleSize: 16,
            buttonColor: AppColors.primaryColor,
            titleWeight: FontWeight.w600,
            buttonWidth: MediaQuery.of(context).size.width,
            buttonRadius: 8,
            buttonHeight: 60,
          ),
          const SizedBox(height: 24),
          const AuthDivider(authDividerTitle: "Or Sign In With"),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomElevatedButtonWithIcon(
                  onPressed: () {
                    controller.signInWithApple();
                  },
                  titleText: "Apple ID",
                  iconSrc: AppIcons.appleIcon,
                  buttonColor: AppColors.transparentColor,
                  titleWeight: FontWeight.w500,
                  titleSize: 18,
                  iconSize: 24,
                  titleColor: AppColors.cardTitleColor,
                  iconColor: AppColors.colorBlack,
                  buttonBorderColor: AppColors.socialButtonBorderColor,
                  buttonBorderWidth: 1.0,
                  buttonRadius: 8,
                  buttonHeight: 56,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomElevatedButtonWithIcon(
                  onPressed: () {
                    controller.handleGoogleLogin();
                  },
                  titleText: "Google",
                  iconSrc: AppIcons.googleIcon,
                  buttonColor: AppColors.transparentColor,
                  titleWeight: FontWeight.w500,
                  buttonRadius: 8,
                  buttonHeight: 56,
                  titleSize: 18,
                  iconSize: 24,
                  titleColor: AppColors.colorBlack,
                  buttonBorderColor: AppColors.socialButtonBorderColor,
                  buttonBorderWidth: 1.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
