import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/view/screen/generate_qr_code/inner_widget/qr_code_bottom_nav_bar.dart';
import 'package:ezyrack/view/widgets/buttons/custom_button_with_icon.dart';
import 'package:ezyrack/view/widgets/image/custom_image.dart';
import 'package:ezyrack/view/widgets/qr_code/custom_qr_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GenerateQRCodeScreen extends StatefulWidget {


  const GenerateQRCodeScreen({super.key});

  @override
  State<GenerateQRCodeScreen> createState() => _GenerateQRCodeScreenState();
}

class _GenerateQRCodeScreenState extends State<GenerateQRCodeScreen> {

  final List<GlobalKey> qrCodeKeys = [];
  late String item;

  @override
  void initState() {
    item = Get.arguments;
    qrCodeKeys.addAll(List.generate(int.parse(item), (index) => GlobalKey()));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.colorBlack,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -200, left: -110,
                child: Container(
                  height: 360, width: 360,
                  decoration: BoxDecoration(
                      color: AppColors.colorWhite.withOpacity(0.02),
                      shape: BoxShape.circle
                  ),
                ),
              ),
              Positioned(
                top: -190, left: -90,
                child: Container(
                  height: 410, width: 410,
                  decoration: BoxDecoration(
                      color: AppColors.colorWhite.withOpacity(0.02),
                      shape: BoxShape.circle
                  ),
                ),
              ),
              Positioned(
                top: 50, left: 20, right: 20,
                child: InkWell(
                  onTap: () => Get.offAndToNamed(AppRoute.homeScreen),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 4),
                    color: AppColors.transparentColor,
                    child: Row(
                      children: [
                        const CustomImage(imageSrc: AppIcons.leftArrowIcon),
                        const SizedBox(width: 8),
                        Text(
                          "QR Code",
                          style: GoogleFonts.publicSans(
                            fontSize: 16,
                            color: AppColors.colorWhite,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 150, bottom: -50, left: 0, right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: AppColors.containerColor,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 24, start: 20, end: 20),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:"Generated QR Code: ",
                                style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              TextSpan(
                                text: item,
                                style: GoogleFonts.publicSans(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700
                                ),
                              )
                            ]
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                          physics: const BouncingScrollPhysics(),
                          child: GridView.builder(
                            shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: int.parse(item),
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: MediaQuery.of(context).size.width,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 220
                            ),
                            itemBuilder: (context, index) {
                              return CustomQrWidget(
                                key: qrCodeKeys[index],
                                data: "EZY-2023-${"${index + 1}".padLeft(2, "0")}",
                                qrSerialNo: "EZY-2023-${"${index + 1}".padLeft(2, "0")}",
                              );
                            }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: QrCodeBottomNavBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: CustomElevatedButtonWithIcon(
                    onPressed: () async{
                      saveQRCodeAsPDF();
                    },
                    buttonHeight: 55,
                    buttonWidth: MediaQuery.of(context).size.width,
                    titleText: "Download",
                    iconSrc: AppIcons.downloadIcon,
                    buttonBorderColor: AppColors.colorBlack,
                    buttonColor: AppColors.colorWhite,
                    titleColor: AppColors.colorBlack,
                    iconColor: AppColors.colorBlack,
                  )
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: CustomElevatedButtonWithIcon(
                      onPressed: () => printQRCodePDF(),
                      buttonHeight: 55,
                      buttonWidth: MediaQuery.of(context).size.width,
                      titleText: "Print",
                      iconSrc: AppIcons.printIcon
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> uploadPDFToFirebase(Uint8List pdfBytes) async {
    try {
      final storage = FirebaseStorage.instance;
      const pdfFileName = 'qr_codes.pdf'; // Replace with your desired PDF file name
      final pdfRef = storage.ref("documents/").child(pdfFileName);

      final uploadTask = pdfRef.putData(pdfBytes, SettableMetadata(contentType: 'application/pdf'));

      await uploadTask;
      final downloadUrl = await pdfRef.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      // Handle any errors that occur during the upload process
      print('Error uploading PDF: $e');
      return null;
    }
  }

  Future<void> saveQRCodeAsPDF() async {
    EasyLoading.show(status: 'Saving PDF...');

    try {
      final List<pw.MemoryImage> pdfImages = [];

      final pdf = pw.Document();
      /*final outputDir = await getApplicationDocumentsDirectory();
      final outputFile = File('${outputDir.path}/qr_codes.pdf');
      print("File Dir: $outputDir");*/

      for (int i = 0; i < qrCodeKeys.length; i++) {
        final GlobalKey qrCodeKey = qrCodeKeys[i];
        final boundary = qrCodeKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

        final image = await boundary.toImage(pixelRatio: 1.0);
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        final bytes = byteData!.buffer.asUint8List();

        final pdfImage = pw.MemoryImage(bytes);
        pdfImages.add(pdfImage);
      }

      /// show qr code in pdf
      pdf.addPage(
        pw.Page(
          pageTheme: const pw.PageTheme(
            margin: pw.EdgeInsets.all(10),
          ),
          build: (pw.Context context) {
            final List<pw.Widget> imageWidgets = pdfImages
                .map((pdfImage) => pw.Center(child: pw.Image(pdfImage)))
                .toList();
            return pw.GridView(
              crossAxisCount: 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: imageWidgets,
            );
          },
        ),
      );

      final pdfBytes = await pdf.save();
      final downloadUrl = await uploadPDFToFirebase(pdfBytes);

      EasyLoading.dismiss();
      if (downloadUrl != null) {
        final dio = Dio();
        final response = await dio.get(downloadUrl, options: Options(responseType: ResponseType.bytes));

        if (response.statusCode == 200) {
          final outputDir = await getDownloadsDirectory();
          final outputFile = File('${outputDir?.path}/qr_codes.pdf');
          print(outputFile);

          await outputFile.writeAsBytes(response.data);
          await OpenFile.open(outputFile.path);
          EasyLoading.showSuccess('PDF Downloaded Successfully');
        } else {
          EasyLoading.showError('Failed to download PDF');
        }
      } else {
        EasyLoading.showError('Failed to upload PDF');
      }
    } catch (e) {
      EasyLoading.showError('Failed to save PDF');
    }
  }

  Future<Uint8List> generatePDF() async {
    EasyLoading.show(status: 'Load Printer...');

    final pdf = pw.Document();

    final List<pw.MemoryImage> pdfImages = [];
    for (int i = 0; i < qrCodeKeys.length; i++) {
      final GlobalKey qrCodeKey = qrCodeKeys[i];
      final boundary = qrCodeKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 3.0); // Increase pixel ratio for better quality
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

      final pdfImage = pw.MemoryImage(bytes);
      pdfImages.add(pdfImage);
    }
    final gridLayout = pw.GridView(
      crossAxisCount: 4,
      crossAxisSpacing: 12,
      mainAxisSpacing: 5,
      children: pdfImages
          .map((pdfImage) => pw.Container(
        child: pw.Image(pdfImage),
      )).toList(),
    );

    // Add the grid layout to the PDF page
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: gridLayout,
          );
        },
      ),
    );

    EasyLoading.dismiss();
    return pdf.save();
  }

  Future<void> printQRCodePDF() async {
    final pdfBytes = await generatePDF();

    Printing.layoutPdf(
      format: PdfPageFormat.a4,
      dynamicLayout: false,
      usePrinterSettings: true,
      onLayout: (format) {
        return pdfBytes;
      },
    );
  }
}
