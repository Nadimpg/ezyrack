import 'package:ezyrack/view/screen/profile/profile_controller/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/screen/profile/inner_widget/profile_card.dart';
import 'package:ezyrack/view/screen/profile/inner_widget/profile_top_section.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/image/custom_image.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  void initState()
  {
    final controller = Get.find<ProfileController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getUserInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.colorBlack,
        body: GetBuilder<ProfileController>(
          builder: (controller) {
            return LayoutBuilder(
              builder: (context, constraints) => Stack(
                clipBehavior: Clip.none,
                children: [
                  const TopCurve(),
                  Positioned(
                    top: 64,
                    left: 20, right: 0,
                    child: AppBarLeading(
                      pressed: () => Get.offAndToNamed(AppRoute.homeScreen),
                      title: "Profile",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 135),
                    child: controller.isLoading ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      padding: const EdgeInsetsDirectional.symmetric(vertical: 30, horizontal: 20),
                      decoration: const BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(16))
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(color: AppColors.primaryColor),
                      ),
                    ) : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      padding: const EdgeInsetsDirectional.symmetric(vertical: 30, horizontal: 20),
                      decoration: const BoxDecoration(
                        color: AppColors.colorWhite,
                        borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(16))
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ProfileTopSection(),
                          const SizedBox(height: 40),
                          Flexible(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  ProfileCard(
                                      imageSrc: AppIcons.updateDetailsIcon,
                                      title: "Update my details",
                                      subTitle: "You can change your details.",
                                      onPressed: () => Get.offAndToNamed(AppRoute.profileDetailsScreen)
                                  ),
                                  const SizedBox(height: 12),
                                  ProfileCard(
                                      imageSrc: AppIcons.settingIcon,
                                      title: "Settings",
                                      subTitle: "Setting and terms of service",
                                      onPressed: () => Get.offAndToNamed(AppRoute.settingScreen)
                                  ),
                                  const SizedBox(height: 12),
                                  ProfileCard(
                                      imageSrc: AppIcons.aboutUsIcon,
                                      title: "About us",
                                      subTitle: "You can see about us details.",
                                      onPressed: () => Get.offAndToNamed(AppRoute.aboutUsScreen)
                                  ),
                                  const SizedBox(height: 12),
                                  ProfileCard(
                                      imageSrc: AppIcons.logoutIcon,
                                      title: "Logout",
                                      subTitle: "You can change your details.",
                                      onPressed: () => showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            alignment: Alignment.center,
                                            child: SingleChildScrollView(
                                              physics: const ClampingScrollPhysics(),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                alignment: Alignment.center,
                                                padding: const EdgeInsetsDirectional.only(top: 24, bottom: 24, start: 16, end: 16),
                                                decoration: BoxDecoration(
                                                    color: AppColors.colorWhite,
                                                    borderRadius: BorderRadius.circular(16)
                                                ),
                                                child: Column(
                                                  children: [
                                                    const CustomImage(imageSrc: AppImages.logoutImage),
                                                    const SizedBox(height: 24),
                                                    Text(
                                                      "Logout",
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.montserrat(
                                                        color: AppColors.colorBlack,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 20
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Text(
                                                      "Are you sure you want to logout?",
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.publicSans(
                                                          color: AppColors.colorBlack_1,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 16
                                                      ),
                                                    ),
                                                    const SizedBox(height: 40),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: CustomElevatedButton(
                                                            onPressed: () => Get.back(),
                                                            titleText: "Cancel",
                                                            buttonColor: AppColors.transparentColor,
                                                            titleColor: AppColors.primaryColor,
                                                            buttonWidth: MediaQuery.of(context).size.width,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 12),
                                                        Expanded(
                                                          child: CustomElevatedButton(
                                                            onPressed: () => signOut(),
                                                            titleText: "Sure",
                                                            buttonColor: AppColors.primaryColor,
                                                            titleColor: AppColors.colorWhite,
                                                            buttonWidth: MediaQuery.of(context).size.width,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                      )
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            );
          }
        ),
      ),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();

    Fluttertoast.showToast(
        msg: "Logout Successfully",
        backgroundColor: AppColors.successColor,
        textColor: AppColors.colorBlack,
        fontSize: 14,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM
    );
    Get.offAndToNamed(AppRoute.authenticationScreen);
  }
}
