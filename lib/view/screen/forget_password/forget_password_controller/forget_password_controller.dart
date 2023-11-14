import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/view/widgets/email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{

  final TextEditingController emailController = TextEditingController();
  final emailRegExP = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");

  final emailOtp = EmailOTP();

  bool isLoading = false;

  Future<void> sendOtpToEmail() async{

    isLoading = true;
    update();

    emailOtp.setConfig(
        appEmail: "mirzamahmud.cse.bubt202@gmail.com",
        appName: "EzyRack",
        userEmail: emailController.text.toString(),
        otpLength: 5,
        otpType: OTPType.digitsOnly
    );

    if(await emailOtp.sendOTP() == true){
      Fluttertoast.showToast(
          msg: "OTP has been sent",
          backgroundColor: AppColors.successColor,
          textColor: AppColors.colorBlack,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );

      Get.offAndToNamed(AppRoute.emailVerificationScreen, arguments: [emailController.text.toString(), emailOtp]);
    }
    else{
      Fluttertoast.showToast(
          msg: "Oops! OTP send failed",
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.colorBlack,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );
    }

    clearData();
    isLoading = false;
    update();
  }

  clearData() {
    emailController.text = "";
  }
}