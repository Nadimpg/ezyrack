import 'package:ezyrack/view/screen/forget_password/forget_password_controller/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/utils/app_static_strings.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:ezyrack/view/widgets/textfields/custom_textfield.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';

class ForgetPasswordScreen extends StatefulWidget {

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  @override
  void initState() {

    Get.find<ForgetPasswordController>();
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.cardTitleColor,
        body: GetBuilder<ForgetPasswordController>(
          builder: (controller) {

            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) => Stack(
                children: [
                  const TopCurve(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppBarLeading(pressed: () => Get.toNamed(AppRoute.authenticationScreen)),
                          const SizedBox(height: 44),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(AppImages.appLogo2Image, height: 37, width: 200),
                              const SizedBox(height: 97),
                              Text(
                                AppStaticStrings.accountRecovery,
                                style: GoogleFonts.montserrat(
                                    color: AppColors.splashBgColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                AppStaticStrings.accountRecoveryDetails,
                                style: GoogleFonts.publicSans(
                                    color: AppColors.splashBgColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16
                                ),
                              ),
                              const SizedBox(height: 30),
                              Container(
                                padding:  const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                                decoration: BoxDecoration(
                                  color: AppColors.splashBgColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        textEditingController: controller.emailController,
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.text,
                                        prefixIconSrc: AppIcons.emailIcon,
                                        hintText: "Email",
                                        hintStyle: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
                                        fieldBorderColor: AppColors.fieldBorderColor,
                                        validator: (value) {
                                          if(value!.isEmpty || !value.contains("@") || !controller.emailRegExP.hasMatch(value))
                                          {
                                            return "Please, enter your valid email";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 32),
                                      controller.isLoading ? const CustomElevatedLoadingButton() : CustomElevatedButton(
                                        onPressed: () {
                                          if(formKey.currentState!.validate()){
                                            controller.sendOtpToEmail();
                                          }
                                        },
                                        titleText: "Get a verification code",
                                        titleColor: AppColors.colorWhite,
                                        titleSize: 16,
                                        buttonColor: AppColors.primaryColor,
                                        titleWeight: FontWeight.w600,
                                        buttonWidth: MediaQuery.of(context).size.width,
                                        buttonRadius: 8,
                                        buttonHeight: 60,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
