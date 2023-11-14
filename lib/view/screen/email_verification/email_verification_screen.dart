import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/utils/app_static_strings.dart';
import 'package:ezyrack/view/screen/email_verification/inner_widget/otp_timer.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:ezyrack/view/widgets/email_otp/email_otp.dart';

class VerificationCode extends StatefulWidget {

  const VerificationCode({super.key});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {

  late String email;
  late EmailOTP emailOTP;

  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    email = Get.arguments[0];
    emailOTP = Get.arguments[1];
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
                  AppBarLeading(pressed: () => Get.back()),
                  const SizedBox(height: 44),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AppImages.appLogo2Image, height: 37, width: 200),
                      const SizedBox(height: 97),
                      Text(
                        AppStaticStrings.enterVerificationCode,
                        style: GoogleFonts.montserrat(
                            color: AppColors.splashBgColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 28
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "${AppStaticStrings.enterVerificationCodeDetails} $email",
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 0,
                              child: PinCodeTextField(
                                appContext: context,
                                controller: otpController,
                                length: 5,
                                textStyle: GoogleFonts.publicSans(color: AppColors.primaryColor, fontSize: 20, fontWeight: FontWeight.w600),
                                obscureText: false,
                                obscuringCharacter: '*',
                                blinkWhenObscuring: false,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderWidth: 0.5,
                                    fieldHeight: 60,
                                    fieldWidth: 60,
                                    borderRadius: BorderRadius.circular(8),
                                    inactiveColor:  AppColors.fieldBorderColor,
                                    inactiveFillColor: AppColors.transparentColor,
                                    activeFillColor: AppColors.transparentColor,
                                    activeColor: AppColors.primaryColor,
                                    selectedFillColor: AppColors.transparentColor,
                                    selectedColor: AppColors.primaryColor
                                ),
                                cursorColor: AppColors.colorBlack,
                                animationDuration:
                                const Duration(milliseconds: 100),
                                enableActiveFill: true,
                                keyboardType: TextInputType.number,
                                beforeTextPaste: (text) {
                                  return true;
                                },
                                onChanged: (value){},
                              ),
                            ),
                            const SizedBox(height: 32),
                            isLoading ? const CustomElevatedLoadingButton() : CustomElevatedButton(
                              onPressed: (){
                                verifyEmailOTP();
                              },
                              titleText: AppStaticStrings.submitVerificationCode,
                              buttonWidth: MediaQuery.of(context).size.width,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OtpTimer(
                            duration: 60,
                            onTimeComplete: (){}
                          ),
                          InkWell(
                            onTap: () => resendOtpToEmail(),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Didn't get a code?  ",
                                      style: GoogleFonts.publicSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.colorWhite
                                      )
                                    ),
                                    TextSpan(
                                      text: "Resend",
                                      style: GoogleFonts.publicSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor
                                      )
                                    )
                                  ]
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future <void> verifyEmailOTP() async{

    setState(() {
      isLoading = true;
    });

    if(emailOTP.verifyOTP(otp: otpController.text.toString()) == true){

      Fluttertoast.showToast(
          msg: "OTP is verified",
          backgroundColor: AppColors.successColor,
          textColor: AppColors.colorBlack,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );

      setState(() {
        isLoading = false;
      });

      Get.toNamed(AppRoute.resetPasswordScreen, arguments: email);
    }
    else{
      Fluttertoast.showToast(
          msg: "Invalid OTP",
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.colorBlack,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );

      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> resendOtpToEmail() async{

    emailOTP.setConfig(
        appEmail: "mirzamahmud.cse.bubt202@gmail.com",
        appName: "EzyRack",
        userEmail: email,
        otpLength: 5,
        otpType: OTPType.digitsOnly
    );

    if(await emailOTP.sendOTP() == true){
      Fluttertoast.showToast(
          msg: "OTP has been sent",
          backgroundColor: AppColors.successColor,
          textColor: AppColors.colorBlack,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );
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
  }
}
