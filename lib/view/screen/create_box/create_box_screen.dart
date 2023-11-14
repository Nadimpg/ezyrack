import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/screen/create_box/create_box_controller/create_box_controller.dart';
import 'package:ezyrack/view/screen/create_box/inner_widget/create_box_bottom_nav.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/textfields/custom_textfield.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateBoxScreen extends StatefulWidget {

  const CreateBoxScreen({super.key});

  @override
  State<CreateBoxScreen> createState() => _CreateBoxScreenState();
}

class _CreateBoxScreenState extends State<CreateBoxScreen> {

  late String qrCodeID;

  @override
  void initState() {
    qrCodeID = Get.arguments;
    Get.find<CreateBoxController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: GetBuilder<CreateBoxController>(
        builder: (controller) {

          controller.itemNameController = List.generate(
            controller.images.length, (index) => TextEditingController(),
          );

          return Scaffold(
            backgroundColor: AppColors.colorBlack,
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) => Stack(
                clipBehavior: Clip.none,
                children: [
                  const TopCurve(),
                  Positioned(
                    top: 50, left: 20, right: 20,
                    child: AppBarLeading(
                      title: "Create EZYRack Box",
                      pressed: () => Get.toNamed(AppRoute.homeScreen),
                    ),
                  ),
                  Positioned(
                    top: 150, bottom: -50, left: 0, right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12))
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsetsDirectional.symmetric(vertical: 32, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.carBoxImage, width: 100, height: 100),
                                  const SizedBox(height: 10),
                                  Text(
                                    controller.boxNameController.text.isEmpty ? "---" : controller.boxName,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 18)
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    qrCodeID,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.publicSans(fontWeight: FontWeight.w500,fontSize: 12, color: AppColors.textColor_2)
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name" ,style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 18)),
                                const SizedBox(height: 8),
                                CustomTextField(
                                  textEditingController: controller.boxNameController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  prefixIconSrc: AppIcons.boxIcon,
                                  hintText: "Enter your box name",
                                  onChanged: (value) => setState(() {
                                    controller.boxName = value;
                                  }),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Image*", style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 18)),
                                const SizedBox(height: 8),
                                GridView.builder(
                                    shrinkWrap: true,
                                    addAutomaticKeepAlives: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.images.isEmpty ? 1 : controller.images.length + 1,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: MediaQuery.of(context).size.width,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        mainAxisExtent: controller.images.isEmpty ? 140 : 200
                                    ),
                                    itemBuilder: (context, index) {
                                      if (index < controller.images.length) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                ClipRRect(
                                                    borderRadius: BorderRadius.circular(12),
                                                    child: SizedBox(
                                                      height: 130, width: 200,
                                                      child: Image.file(
                                                        File(controller.images[index].path),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                ),
                                                Positioned.fill(
                                                  top: -8, right: -4,
                                                  child: GestureDetector(
                                                    onTap: () => controller.deleteItem(index),
                                                    child: Align(
                                                      alignment: Alignment.topRight,
                                                      child: Container(
                                                        height: 24, width: 24,
                                                        alignment: Alignment.center,
                                                        decoration: const BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
                                                        child: const Icon(Icons.remove, color: AppColors.colorWhite, size: 18),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            Expanded(
                                              child: CustomTextField(
                                                isPrefixIcon: false,
                                                textEditingController: controller.itemNameController[index],
                                                textInputAction: TextInputAction.next,
                                                keyboardType: TextInputType.text,
                                                hintText: "Type item name",
                                              ),
                                            )
                                          ],
                                        );
                                      } else{
                                        return GestureDetector(
                                          onTap: () async {
                                            await controller.pickImages();
                                          },
                                          child: DottedBorder(
                                            color: AppColors.primaryColor,
                                            borderType: BorderType.RRect,
                                            padding: EdgeInsets.zero,
                                            dashPattern: const [10, 6],
                                            radius: const Radius.circular(12),
                                            child: Container(
                                              height: 200, width: 200,
                                              decoration: BoxDecoration(
                                                  color: AppColors.statusDangerBgColor,
                                                  borderRadius: BorderRadius.circular(12)
                                              ),
                                              alignment: Alignment.center,
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      AppIcons.cameraIcon,
                                                      height: 30, width: 30,
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      "Upload",
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.montserrat(
                                                          color: AppColors.colorBlack,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                )
                              ]
                            ),
                            const SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Details (Optional)" ,style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 18)),
                                const SizedBox(height: 8),
                                CustomTextField(
                                  textEditingController: controller.detailsController,
                                  isPrefixIcon: false,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  maxLines: 3,
                                  hintText: "Type box details...",
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: CreateBoxBottomNav(
              isSubmitLoading: controller.isSubmitLoading,
              onPress: () {
                final itemNames = controller.itemNameController.map((element) => element.text).toList();
                controller.uploadData(context, qrCodeID, itemNames);
              }
            ),
          );
        }
      ),
    );
  }
}
