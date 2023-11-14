import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/view/screen/profile/inner_widget/profile_card.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/bottom_nav/custom_bottom_nav_bar.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.colorBlack,
        body: LayoutBuilder(
          builder: (context, constraints) => Stack(
            clipBehavior: Clip.none,
            children: [
              const TopCurve(),
              const Positioned(
                top: 64,
                left: 20, right: 0,
                child: AppBarLeading(
                  fromBottomNav: true,
                  title: "Settings",
                ),
              ),
              Positioned(
                top: 135, bottom: -50,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 30, horizontal: 20),
                  decoration: const BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(16))
                  ),
                  child: Column(
                    children: [
                      ProfileCard(
                          imageSrc: AppIcons.updateDetailsIcon,
                          title: "Privacy policy",
                          subTitle: "You can change your details.",
                          onPressed: () => Get.offAndToNamed(AppRoute.privacyPolicyScreen)
                      ),
                      const SizedBox(height: 12),
                      ProfileCard(
                          imageSrc: AppIcons.emergencyContactIcon,
                          title: "Terms of service",
                          subTitle: "You can emergency contact with us",
                          onPressed: () {
                            Get.offAndToNamed(AppRoute.termsOfServiceScreen);
                          },
                      ),
                      const SizedBox(height: 12),
                      ProfileCard(
                          imageSrc: AppIcons.settingIcon,
                          title: "Password change",
                          subTitle: "You can change your setting.",
                          onPressed: () => Get.offAndToNamed(AppRoute.passwordChangeScreen)
                      ),
                      const SizedBox(height: 12),
                      ProfileCard(
                          imageSrc: AppIcons.aboutUsIcon,
                          title: "Delete account",
                          subTitle: "You can see about us details.",
                          onPressed: () => deleteUser()
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
      ),
    );
  }

  Future<void> deleteUser() async{
    try {
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).delete();
      await FirebaseAuth.instance.currentUser!.delete();

      Fluttertoast.showToast(
          msg: "Account deleted successfully",
          backgroundColor: AppColors.successColor,
          textColor: AppColors.colorBlack,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );

      Get.offAndToNamed(AppRoute.authenticationScreen);
      setState(() {});
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        await reAuthenticateAndDelete();
      } else {
        Fluttertoast.showToast(
            msg: e.message ?? "Something went wrong",
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.colorWhite,
            fontSize: 14,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM
        );

        Get.back();
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.colorWhite,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM
      );

      Get.back();
    }
  }

  Future<void> reAuthenticateAndDelete() async {
    try {
      final providerData = FirebaseAuth.instance.currentUser?.providerData.first;

      if (GoogleAuthProvider().providerId == providerData!.providerId) {
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      await FirebaseAuth.instance.currentUser?.delete();
    } catch (e) {
      // Handle exceptions
    }
  }
}
