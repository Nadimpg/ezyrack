import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/view/screen/qr_scan/inner_widget/qr_scan_bottom_sheet_content.dart';
import 'package:ezyrack/view/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:ezyrack/view/widgets/image/custom_image.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner_with_effect/qr_scanner_with_effect.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<StatefulWidget> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> with SingleTickerProviderStateMixin {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isComplete = false;
  String myQrCode = "";

  void _onQRViewCreated(QRViewController controller) {

    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async{

      result = scanData;
      controller.pauseCamera();

      await Future<void>.delayed(const Duration(milliseconds: 300));

      myQrCode = (result?.code!=null && result!.code.toString().isNotEmpty ?result?.code.toString():'') ?? "";
      if(myQrCode.isNotEmpty){
        manageQRData(myQrCode);
      }

    });
  }

  void manageQRData(String myQrCode){
    controller?.stopCamera();

    setState(() {
      isComplete = true;
    });
    CustomBottomSheet(child: QrScanBottomSheetContent(data: myQrCode)).customBottomSheet(context);
  }

  @override
  void reassemble() {
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
    super.reassemble();
  }

  @override
  void dispose() {
    controller?.dispose();
    controller?.stopCamera();
    super.dispose();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.transparentColor,
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: QrScannerWithEffect(
                      qrKey: qrKey,
                      isScanComplete: isComplete,
                      onQrScannerViewCreated: _onQRViewCreated,
                      qrOverlayBorderColor: AppColors.primaryColor,
                      qrOverlayBorderWidth: 10,
                      qrOverlayBorderRadius: 5,
                      qrOverlayBorderLength: 50,
                      cutOutSize: (MediaQuery.of(context).size.width < 300 || MediaQuery.of(context).size.height < 400) ? 250.0 : 300.0,
                      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
                      effectColor: AppColors.primaryColor,
                    ),
                  ),
                  Positioned(
                      top: 50, left: 20, right: 20,
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 4),
                          color: AppColors.transparentColor,
                          child: Row(
                            children: [
                              const CustomImage(imageSrc: AppIcons.leftArrowIcon),
                              const SizedBox(width: 8),
                              Text(
                                isComplete ? "Create EzyRack Box" : "Scan EzyRack Box",
                                style: GoogleFonts.publicSans(
                                    fontSize: 16,
                                    color: AppColors.colorWhite,
                                    fontWeight: FontWeight.w500
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                  ),
                  Positioned(
                    top: 170,
                    child: Text(
                      isComplete ? "Result" : "Scanning...",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          color: AppColors.colorWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 120,
                    child: GestureDetector(
                      onTap: () => controller!.toggleFlash(),
                      child: Container(
                        height: 50, width: 50,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle
                        ),
                        child: const CustomImage(imageSrc: AppIcons.flashIcon),
                      ),
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}