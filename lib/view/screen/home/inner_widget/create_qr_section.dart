import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/textfields/custom_textfield.dart';

class CreateQrSection extends StatefulWidget {
  const CreateQrSection({super.key});

  @override
  State<CreateQrSection> createState() => _CreateQrSectionState();
}

class _CreateQrSectionState extends State<CreateQrSection> {

  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Generate QR Code and organize your things as you want",
            style: GoogleFonts.montserrat(
                color: AppColors.colorBlack,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomTextField(
                isPrefixIcon: false,
                cursorColor: AppColors.colorBlack,
                textEditingController: amountController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                hintText: "Type Generated QR Code Number",
                hintStyle: GoogleFonts.publicSans(
                  color: AppColors.hintTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "*Up to 20 codes at a time",
                style: GoogleFonts.publicSans(
                    color: AppColors.colorBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 25),
          CustomElevatedButton(
              buttonWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                if (amountController.text.toString().isEmpty && amountController.text.toString() == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      closeIconColor: AppColors.primaryColor,
                      showCloseIcon: true,
                      elevation: 10,
                      margin: const EdgeInsets.only(
                          bottom: 40, left: 15, right: 15),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppColors.colorBlack,
                      content: Text(
                        "Please fill out this field",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                            color: AppColors.colorWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                } else if (int.parse(amountController.text.toString()) > 20) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    closeIconColor: AppColors.primaryColor,
                    showCloseIcon: true,
                    elevation: 10,
                    margin:
                        const EdgeInsets.only(bottom: 40, left: 15, right: 15),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColors.colorBlack,
                    content: Text(
                      "You won't generate more than 20 codes",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.montserrat(
                          color: AppColors.colorWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ));
                } else {
                  Get.offAndToNamed(AppRoute.generateQrCodeScreen, arguments: amountController.text);
                  amountController.text = "";
                }
              },
              titleText: "Create QR"
          )
        ],
      ),
    );
  }
}
