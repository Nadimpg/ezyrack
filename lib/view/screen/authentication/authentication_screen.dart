import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/screen/Authentication/inner_widget/login_section.dart';
import 'package:ezyrack/view/screen/Authentication/inner_widget/registration_section.dart';
import 'package:ezyrack/view/screen/authentication/authentication_controller.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {

  bool isLoggedIn = false;

  @override
  void initState() {
    final controller = Get.put(AuthenticationController());
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.rememberMe = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: GetBuilder<AuthenticationController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.cardTitleColor,
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) => Stack(
              children: [
                const TopCurve(),
                // Select LogIn Or Sign Up Page...
                Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 20, bottom: 24, right: 20),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        controller.selectedIndex == 0 ? Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 115),
                            child: SvgPicture.asset(
                                AppImages.appLogo1Image,
                                height: 100,
                                width: 235
                            ),
                          ),
                        ) : Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 115),
                            child: SvgPicture.asset(
                                AppImages.appLogo1Image,
                                height: 100,
                                width: 235
                            ),
                          ),
                        ),
                        controller.selectedIndex == 0 ? const SizedBox(height: 100) : const SizedBox(height: 60),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsetsDirectional.only(start: 12, end: 12, bottom: 24),
                          decoration: BoxDecoration(
                            color: AppColors.colorWhite,
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: List.generate(controller.tabTitle.length, (index) => Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      controller.changeIndex(index);
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 25),
                                          child: Text(
                                            controller.tabTitle[index],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.publicSans(
                                                color: index == controller.selectedIndex ? AppColors.colorBlack : AppColors.hintTextColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Divider(height: 0,thickness: 1.5,color: index == controller.selectedIndex?  AppColors.primaryColor : AppColors.fieldFillColor),
                                      ],
                                    ),
                                  ),
                                )) ,
                              ),
                              const SizedBox(height: 24),
                              controller.selectedIndex == 0 ? const LoginSection() : const RegistrationSection()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
