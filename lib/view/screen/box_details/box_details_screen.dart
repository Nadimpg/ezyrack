import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezyrack/view/screen/box_details/box_details_controller/box_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/screen/box_details/inner_widget/box_details_bottom_nav.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/textfields/custom_textfield.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';

class BoxDetailsScreen extends StatefulWidget {
  const BoxDetailsScreen({super.key});

  @override
  State<BoxDetailsScreen> createState() => _BoxDetailsScreenState();
}

class _BoxDetailsScreenState extends State<BoxDetailsScreen> {

  late String qrCodeID;

  @override
  void initState() {
    qrCodeID = Get.arguments;
    final controller = Get.find<BoxDetailsController>();

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
        body: GetBuilder<BoxDetailsController>(
          builder: (controller) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) => Stack(
                clipBehavior: Clip.none,
                children: [
                  const TopCurve(),
                  Positioned(
                    top: 50, left: 20, right: 20,
                    child: AppBarLeading(
                      title: "EZYRack Box Details",
                      pressed: () => Get.offAndToNamed(AppRoute.homeScreen),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 150),
                    child: controller.isLoading ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
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
                                Text("Images" ,style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 18)),
                                const SizedBox(height: 8),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: Row(
                                    children: List.generate(controller.imageUrl.length, (index) => Container(
                                      margin: const EdgeInsetsDirectional.only(end: 12),
                                      padding: const EdgeInsetsDirectional.symmetric(vertical: 12, horizontal: 12),
                                      decoration: BoxDecoration(
                                          color: AppColors.transparentColor,
                                          border: Border.all(color: const Color(0xffEAEAEA), width: 1),
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      alignment: Alignment.center,
                                      child: CachedNetworkImage(
                                        height: 250, width: 250,
                                        imageUrl: controller.imageUrl[index],
                                        imageBuilder: (context, imageProvider) => Container(
                                          height: MediaQuery.of(context).size.height,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            )
                                          ),
                                        ),
                                        placeholder: (context, hash) => ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: BlurHash(
                                            color: AppColors.transparentColor,
                                            hash: "LHA-Vc_4s9ad4oMwt8t7RhXTNGRj",
                                            image: controller.imageUrl[index],
                                            imageFit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Details" ,style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 18)),
                                const SizedBox(height: 8),
                                Text(controller.boxDetails ,style: GoogleFonts.montserrat(fontWeight: FontWeight.w400,fontSize: 16)),
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
        bottomNavigationBar: BoxDetailsBottomNav(qrCode: qrCodeID),
      ),
    );
  }
}
