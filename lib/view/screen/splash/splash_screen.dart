import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/utils/device_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  User? user;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    user != null ? Timer(const Duration(seconds: 3), (){
      Get.offAndToNamed(AppRoute.homeScreen);
    }) : Timer(const Duration(seconds: 3), (){
      Get.offAndToNamed(AppRoute.authenticationScreen);
    });
    super.initState();
  }

  @override
  void dispose() {
    user != null ? DeviceUtils.othersUtils() : DeviceUtils.authUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.splashBgColor,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(AppImages.appLogoImage, height: 115, width: 270),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 35),
                  child: SvgPicture.asset(
                      AppImages.splashBgImage,
                      width: constraints.maxWidth
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                    AppImages.splashBgImage,
                    width: constraints.maxWidth
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
