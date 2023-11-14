import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/utils/app_static_strings.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;

  const CustomBottomNavBar({required this.currentIndex, super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  var bottomNavIndex = 0;

  List<String> iconList = [AppIcons.homeIcon, AppIcons.settingsIcon];
  final textList = [AppStaticStrings.home, AppStaticStrings.settings];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 72,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsetsDirectional.only(top: 8, start: 50, end: 50),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.colorWhite,
              boxShadow: [
                BoxShadow(
                    color: AppColors.colorBlack.withOpacity(0.1),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 22,
                    offset: const Offset(0, 4))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              iconList.length,
              (index) => InkWell(
                onTap: () => onTap(index),
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(4),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          iconList[index],
                          height: 24,
                          width: 24,
                          color: index == bottomNavIndex
                              ? AppColors.primaryColor
                              : AppColors.inactiveIconColor,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          textList[index],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.publicSans(
                              color: index == bottomNavIndex
                                  ? AppColors.primaryColor
                                  : AppColors.inactiveTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoute.qrScanScreen);
            },
            child: Column(
              children: [
                Container(
                  height: 68,
                  width: 68,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      color: AppColors.colorWhite, shape: BoxShape.circle),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor, shape: BoxShape.circle),
                    child: SvgPicture.asset(AppIcons.scannerIcon,
                        color: AppColors.colorWhite, width: 24, height: 24),
                  ),
                ),
                const SizedBox(height: 10),
                Text(AppStaticStrings.qrScan,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.publicSans(
                        color: AppColors.inactiveTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void onTap(int index) {
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.offAndToNamed(AppRoute.homeScreen);
      }
    } else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        Get.offAndToNamed(AppRoute.settingScreen);
      }
    }
  }
}
