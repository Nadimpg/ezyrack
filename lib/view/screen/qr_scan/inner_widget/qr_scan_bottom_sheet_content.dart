import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/model/ezy_rack_box_model.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/card/custom_card.dart';

class QrScanBottomSheetContent extends StatefulWidget {

  final String? data;

  const QrScanBottomSheetContent({this.data, super.key});

  @override
  State<QrScanBottomSheetContent> createState() => _QrScanBottomSheetContentState();
}

class _QrScanBottomSheetContentState extends State<QrScanBottomSheetContent> {

  User? user = FirebaseAuth.instance.currentUser;
  EzyRackBoxModel boxModel = EzyRackBoxModel();

  final fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    getQrInfo();
    super.initState();
  }

  Future<void> getQrInfo() async{

    fireStore.collection(user!.uid).doc(widget.data).get()
        .then((value){
      boxModel = EzyRackBoxModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    return widget.data == boxModel.qrCodeID ? Column(
      children: [
        CustomCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        boxModel.boxName ?? "",
                        style: GoogleFonts.publicSans(
                            color: AppColors.cardTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        boxModel.qrCodeID ?? "",
                        style: GoogleFonts.publicSans(
                            color: AppColors.cardContentColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(
                AppImages.carBoxImage,
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        CustomElevatedButton(
          buttonWidth: MediaQuery.of(context).size.width,
          onPressed: () => Get.offAndToNamed(AppRoute.boxDetailsScreen, arguments: boxModel.qrCodeID),
          titleText: "View Box"
        )
      ],
    ) : Column(
      children: [
        CustomCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data ?? "",
                          style: GoogleFonts.publicSans(
                              color: AppColors.cardTitleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Do you want to add EZYRACK Box?",
                          style: GoogleFonts.publicSans(
                              color: AppColors.cardContentColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                  flex: 1,
                  child: SvgPicture.asset(
                    AppImages.carBoxImage,
                  )
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        CustomElevatedButton(
          buttonWidth: MediaQuery.of(context).size.width,
          onPressed: () => Get.offAndToNamed(AppRoute.createBoxScreen, arguments: widget.data),
          titleText: "Create EZYRACK Box"
        )
      ],
    );
  }
}
