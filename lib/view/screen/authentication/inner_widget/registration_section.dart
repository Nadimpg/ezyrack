import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/utils/app_static_strings.dart';
import 'package:ezyrack/view/screen/Authentication/inner_widget/auth_divider.dart';
import 'package:ezyrack/view/screen/authentication/authentication_controller.dart';
import 'package:ezyrack/view/widgets/buttons/custom_button_with_icon.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:ezyrack/view/widgets/textfields/custom_textfield.dart';


class RegistrationSection extends StatefulWidget {
  const RegistrationSection({super.key});

  @override
  State<RegistrationSection> createState() => _RegistrationSectionState();
}

class _RegistrationSectionState extends State<RegistrationSection> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthenticationController>(
      builder: (controller) => SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                textEditingController: controller.nameController,
                prefixIconSrc: AppIcons.userIcon,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                hintText: AppStaticStrings.userName,
                hintStyle: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
                fieldBorderColor: AppColors.fieldBorderColor,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter your first name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                textEditingController: controller.emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                prefixIconSrc: AppIcons.emailIcon,
                hintText: AppStaticStrings.email,
                hintStyle: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
                fieldBorderColor: AppColors.fieldBorderColor,
                validator: (value){
                  if(value!.isEmpty || !value.contains("@") || !controller.emailRegExP.hasMatch(value))
                  {
                    return "Please enter your valid email";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                textEditingController: controller.passController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                prefixIconSrc: AppIcons.passwordIcon,
                hintText: AppStaticStrings.password,
                hintStyle: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
                fieldBorderColor: AppColors.fieldBorderColor,
                validator: (value) {
                  if(value!.isEmpty || value.length < 8)
                  {
                    return "Please enter your password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                textEditingController: controller.postCodeController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                prefixIconSrc: AppIcons.postCodeIcon,
                hintText: AppStaticStrings.postCode,
                hintStyle: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
                fieldBorderColor: AppColors.fieldBorderColor,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter your postcode";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 32),
              controller.isLoading ? const CustomElevatedLoadingButton() : CustomElevatedButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    controller.registerUser(
                        email: controller.emailController.text.toString(),
                        password: controller.passController.text.toString()
                    );
                  }
                },
                titleText: AppStaticStrings.createAccount,
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
    );
  }
}
