import 'package:ezyrack/view/screen/home/home_controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/device_utils.dart';
import 'package:ezyrack/view/screen/home/inner_widget/home_screen_bottom_section.dart';
import 'package:ezyrack/view/screen/home/inner_widget/home_screen_top_section.dart';
import 'package:ezyrack/view/widgets/bottom_nav/custom_bottom_nav_bar.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    DeviceUtils.othersUtils();
    Get.find<HomeController>();
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.othersUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.colorBlack,
        body: GetBuilder<HomeController>(

          builder: (controller) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) => Stack(
                clipBehavior: Clip.none,
                children: [
                  const TopCurve(),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 50),
                    child: Column(
                      children: [
                        const HomeScreenTopSection(),
                        const SizedBox(height: 30),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                          padding: const EdgeInsetsDirectional.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.colorWhite.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(controller.tabTitle.length,
                              (index) => Flexible(
                                child: GestureDetector(
                                  onTap: () => controller.changeIndex(index),
                                  child: Container(
                                    padding: const EdgeInsetsDirectional.all(15),
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: index == controller.selectedIndex
                                            ? AppColors.primaryColor
                                            : AppColors.transparentColor,
                                        borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      controller.tabTitle[index],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.publicSans(
                                          color: AppColors.colorWhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 225),
                    child: HomeScreenBottomSection(currentIndex: controller.selectedIndex),
                  )
                ],
              ),
            );
          }
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      ),
    );
  }
}
