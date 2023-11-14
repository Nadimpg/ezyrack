import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

class ResetPasswordScreen extends StatefulWidget {

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  String email = "";

  @override
  void initState() {

    email = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
        backgroundColor: AppColors.cardTitleColor,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => Stack(
            clipBehavior: Clip.none,
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 64, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarLeading(pressed: () => Get.toNamed(AppRoute.forgetPasswordScreen)),
                    const SizedBox(height: 44),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(AppImages.appLogo2Image, height: 37, width: 200),
                        const SizedBox(height: 97),
                        Text(
                          AppStaticStrings.resetYourPassword,
                          style: GoogleFonts.montserrat(
                              color: AppColors.splashBgColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 28
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          AppStaticStrings.resetPasswordDetails,
                          style: GoogleFonts.publicSans(
                              color: AppColors.splashBgColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding:  const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                          decoration: BoxDecoration(
                            color: AppColors.splashBgColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextField(
                                  isPassword: true,
                                  textEditingController: newPasswordController,
                                  prefixIconSrc: AppIcons.passwordIcon,
                                  hintText: AppStaticStrings.newPassword,
                                  hintStyle: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
                                  fieldBorderColor: AppColors.fieldBorderColor,
                                  validator: (value){
                                    if(value!.isEmpty || value.length < 8) {
                                      return "Please, use more than 6 characters long password";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 12),
                                CustomTextField(
                                  isPassword: true,
                                  textEditingController: confirmPasswordController,
                                  prefixIconSrc: AppIcons.passwordIcon,
                                  hintText: AppStaticStrings.confirmPassword,
                                  hintStyle: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
                                  fieldBorderColor: AppColors.fieldBorderColor,
                                  validator: (value){
                                    if(value!.isEmpty || value.length < 8) {
                                      return "Please, use more than 6 characters long password";
                                    }
                                    else if(newPasswordController.text.toString() != confirmPasswordController.text.toString()){
                                      return "Password does not match";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 32),
                                isLoading ? const CustomElevatedLoadingButton() : CustomElevatedButton(
                                  onPressed: () {
                                    if(formKey.currentState!.validate()){
                                      resetPassword(email, newPasswordController.text.toString());
                                    }
                                  },
                                  titleText: AppStaticStrings.resetPassword,
                                  buttonWidth: MediaQuery.of(context).size.width,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  resetPassword(String email, String newPassword) async {
    setState(() {
      isLoading = true;
    });

    //pass the password here
    String newPassword = newPasswordController.text.toString();

    try{
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: newPassword,
      );

      Fluttertoast.showToast(
          msg: "Password reset successfully",
          backgroundColor: AppColors.successColor,
          textColor: AppColors.colorWhite,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );

      Get.offAndToNamed(AppRoute.authenticationScreen);
    } catch(e){
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: AppColors.successColor,
          textColor: AppColors.colorWhite,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );
    }

    setState(() {
      isLoading = false;
    });
  }
}
