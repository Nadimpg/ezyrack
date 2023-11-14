import 'package:flutter/services.dart';
import 'package:ezyrack/utils/app_colors.dart';

class DeviceUtils{

  // my added
  static void splashUtils(){
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.splashBgColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.splashBgColor,
        systemNavigationBarIconBrightness: Brightness.dark
      )
    );
  }

  static void othersUtils(){
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparentColor,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: AppColors.splashBgColor,
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );
  }

  static void authUtils(){
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparentColor,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: AppColors.colorBlack,
            systemNavigationBarIconBrightness: Brightness.light
        )
    );
  }

// -----------------------------------------------
}