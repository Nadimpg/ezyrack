import 'package:dotted_border/dotted_border.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/screen/edit_box/edit_box_controller/edit_box_controller.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:ezyrack/view/widgets/textfields/custom_textfield.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBoxScreen extends StatefulWidget {
  const EditBoxScreen({super.key});

  @override
  State<EditBoxScreen> createState() => _EditBoxScreenState();
}

class _EditBoxScreenState extends State<EditBoxScreen> {

  late String qrCodeID;


  @override
  void initState() {
    qrCodeID = Get.arguments;
    final controller = Get.find<EditBoxController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchData(qrCodeID);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.colorBlack,
        body: GetBuilder<EditBoxController>(
          builder: (controller) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) => Stack(
                clipBehavior: Clip.none,
                children: [
                  const TopCurve(),
                  Positioned(
                    top: 50, left: 20, right: 20,
                    child: AppBarLeading(
                      title: "Edit EZYRack Box",
                      pressed: () => Get.offAndToNamed(AppRoute.boxDetailsScreen, arguments: qrCodeID),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 150),
                    child: controller.isLoading ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12))
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(color: AppColors.primaryColor),
                      ),
                    ) : Container(
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
                                      controller.boxName,
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
                                  readOnly: true,
                                  textEditingController: TextEditingController(text: controller.boxName),
                                  keyboardType: TextInputType.text,
                                  prefixIconSrc: AppIcons.boxIcon,
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Image", style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 18)),
                                  const SizedBox(height: 8),
                                  GridView.builder(
                                      shrinkWrap: true,
                                      addAutomaticKeepAlives: true,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.imageUrl.length + controller.images.length + 1,
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: MediaQuery.of(context).size.width,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          mainAxisExtent: 112
                                      ),
                                      itemBuilder: (context, index) {

                                        if(index < controller.imageUrl.length){
                                          return Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: SizedBox(
                                                    height: 112, width: 112,
                                                    child: Image.network(
                                                      controller.imageUrl[index],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                              ),
                                              Positioned.fill(
                                                top: -8, right: -4,
                                                child: GestureDetector(
                                                  onTap: () => controller.deleteImageFromFirebase(index),
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
                                          );
                                        }
                                        else if(index < controller.imageUrl.length + controller.images.length){
                                          final pickedIndex = index - controller.imageUrl.length;
                                          return Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: SizedBox(
                                                    height: 112, width: 112,
                                                    child: Image.file(
                                                      controller.images[pickedIndex],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                              ),
                                              Positioned.fill(
                                                top: -8, right: -4,
                                                child: GestureDetector(
                                                  onTap: () => controller.deleteImage(pickedIndex),
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
                                          );
                                        }
                                        else {
                                          return GestureDetector(
                                            onTap: () => controller.pickImages(),
                                            child: DottedBorder(
                                              color: AppColors.primaryColor,
                                              borderType: BorderType.RRect,
                                              padding: EdgeInsets.zero,
                                              dashPattern: const [10, 6],
                                              radius: const Radius.circular(12),
                                              child: Container(
                                                height: 112, width: 112,
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
                                                        height: 24, width: 24,
                                                      ),
                                                      const SizedBox(height: 3),
                                                      Text(
                                                        "Upload",
                                                        textAlign: TextAlign.center,
                                                        style: GoogleFonts.montserrat(
                                                            color: AppColors.colorBlack,
                                                            fontSize: 12,
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
                                  maxLines: 3,
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
            );
          }
        ),
        bottomNavigationBar: GetBuilder<EditBoxController>(
          builder: (controller) => SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                  color: AppColors.colorWhite,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.colorBlack.withOpacity(0.1),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 22,
                        offset: const Offset(0, 4)
                    )
                  ]
              ),
              child: controller.isSubmit ? const CustomElevatedLoadingButton() : CustomElevatedButton(
                  onPressed: () => controller.saveData(qrCodeID),
                  titleText: "Update"
              ),
            ),
          ),
        ),
      ),
    );
  }

}
