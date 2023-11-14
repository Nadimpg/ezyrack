import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:ezyrack/view/widgets/image/custom_image.dart';
import 'package:ezyrack/view/widgets/textfields/custom_textfield.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';

class PasswordChangeScreen extends StatefulWidget {
   const PasswordChangeScreen({super.key});

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {

  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  Future<void> changePassword() async {

    setState(() {
      isLoading = true;
    });

    try {
      final user = auth.currentUser;
      final credentials = EmailAuthProvider.credential(
          email: user!.email!,
          password: oldPasswordController.text,
        );

      await user.reauthenticateWithCredential(credentials);
      await user.updatePassword(newPasswordController.text);

      Fluttertoast.showToast(
            msg: "Password updated successfully",
            backgroundColor: AppColors.successColor,
            textColor: AppColors.colorBlack,
            fontSize: 14,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM
        );
    } catch (e) {
      Fluttertoast.showToast(
            msg: "Password change failed, Retry",
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.colorWhite,
            fontSize: 14,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM
        );
    }

    oldPasswordController.text = "";
    newPasswordController.text = "";
    confirmPasswordController.text = "";

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.colorBlack,
        body: LayoutBuilder(
          builder: (context, BoxConstraints constraint) => Stack(
            children: [
              const TopCurve(),
              Positioned(
                top: 64,
                left: 20, right: 0,
                child: AppBarLeading(
                  pressed: () => Get.offAndToNamed(AppRoute.settingScreen),
                  title: "Password change",
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 135),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(16))
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            textEditingController: oldPasswordController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            prefixIconSrc: AppIcons.passwordIcon,
                            isPassword: true,
                            hintText: "Old Password",
                            hintStyle: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
                            fieldBorderColor: AppColors.fieldBorderColor,
                            validator: (value){
                              if(value!.isEmpty || value.length < 8) {
                                return "Please, use more than 6 characters long password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            textEditingController: newPasswordController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            prefixIconSrc: AppIcons.passwordIcon,
                            isPassword: true,
                            hintText: "New Password",
                            hintStyle: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
                            fieldBorderColor: AppColors.fieldBorderColor,
                            validator: (value){
                              if(value!.isEmpty || value.length < 8) {
                                return "Please, use more than 6 characters long password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            textEditingController: confirmPasswordController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            prefixIconSrc: AppIcons.passwordIcon,
                            isPassword: true,
                            hintText: "Confirm Password",
                            hintStyle: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
                            fieldBorderColor: AppColors.fieldBorderColor,
                            validator: (value){
                              if(value!.isEmpty || value.length < 8) {
                                return "Please, use more than 6 characters long password";
                              }
                              if(newPasswordController.text != confirmPasswordController.text){
                                return "Password doesn't match";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 40),
                          isLoading ? const CustomElevatedLoadingButton() : CustomElevatedButton(
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                changePassword();
                              }
                            },
                            titleText: "Change Password",
                            buttonWidth: MediaQuery.of(context).size.width,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
