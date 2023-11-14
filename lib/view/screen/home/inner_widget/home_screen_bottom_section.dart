/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/model/user_model.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/screen/home/inner_widget/all_item_empty_section.dart';
import 'package:ezyrack/view/screen/home/inner_widget/create_qr_section.dart';
import 'package:ezyrack/view/widgets/card/custom_card.dart';
import 'package:ezyrack/view/widgets/textfields/custom_textfield.dart';

class HomeScreenBottomSection extends StatefulWidget {

  final int currentIndex;

  const HomeScreenBottomSection({required this.currentIndex, super.key});

  @override
  State<HomeScreenBottomSection> createState() => _HomeScreenBottomSectionState();
}

class _HomeScreenBottomSectionState extends State<HomeScreenBottomSection> {

  final TextEditingController searchController = TextEditingController();

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: widget.currentIndex == 0 ? SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 20),
        child: Column(
          children: [
            CustomTextField(
              textEditingController: searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              isPrefixIcon: true,
              prefixIconSrc: AppIcons.searchIcon,
              hintText: "Search by Box name or Item name",
              hintStyle: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
              fieldBorderColor: AppColors.fieldBorderColor,
              onChanged: (value) => setState(() {
                searchController.text = value;
              }),
            ),
            const SizedBox(height: 24),
            StreamBuilder<QuerySnapshot>(
               stream: FirebaseFirestore.instance.collection(user!.uid).snapshots(),
               builder: (context, snapshot) {

                 if(snapshot.connectionState == ConnectionState.waiting) {
                   return const Align(
                       alignment: Alignment.center,
                       child: CircularProgressIndicator(
                         color: AppColors.primaryColor,
                         strokeWidth: 3,
                       )
                   );
                 }
                 else if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                   return const AllItemEmptySection();
                 }
                 else{
                   final filteredDocs = snapshot.data!.docs.where((doc) {
                     final boxName = doc["boxName"].toString().toLowerCase();
                     final query = searchController.text.toLowerCase();
                     return boxName.contains(query);
                   }).toList();

                   final searchByItemName = snapshot.data!.docs.where((element) {
                     final boxItemName = element["boxItemName"].toString().toLowerCase();
                     final query = searchController.text.toLowerCase();
                     return boxItemName.contains(query);
                   }).toList();

                   if (filteredDocs.isEmpty) {
                     return Center(
                       child: Padding(
                         padding: const EdgeInsetsDirectional.only(top: 100, bottom: 100),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             SvgPicture.asset(AppImages.emptyBox),
                             const SizedBox(height: 8),
                             Text(
                               "There is no boxes here.",
                               textAlign: TextAlign.center,
                               style: GoogleFonts.montserrat(
                                   color: AppColors.colorBlack_2,
                                   fontSize: 14,
                                   fontWeight: FontWeight.w600
                               ),
                             ),
                           ],
                         ),
                       ),
                     );
                   }

                   else if(searchByItemName.isEmpty){
                     return Center(
                       child: Padding(
                         padding: const EdgeInsetsDirectional.only(top: 100, bottom: 100),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             SvgPicture.asset(AppImages.emptyBox),
                             const SizedBox(height: 8),
                             Text(
                               "There is no boxes here.",
                               textAlign: TextAlign.center,
                               style: GoogleFonts.montserrat(
                                   color: AppColors.colorBlack_2,
                                   fontSize: 14,
                                   fontWeight: FontWeight.w600
                               ),
                             ),
                           ],
                         ),
                       ),
                     );
                   }

                   return Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: List.generate(filteredDocs.length, (index) => GestureDetector(
                       onTap: () => Get.offAndToNamed(AppRoute.boxDetailsScreen, arguments: filteredDocs[index]["qrCodeID"]),
                       child: CustomCard(
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
                                       filteredDocs[index]["boxName"] ?? "",
                                       style: GoogleFonts.publicSans(
                                           color: AppColors.cardTitleColor,
                                           fontWeight: FontWeight.w600,
                                           fontSize: 16
                                       ),
                                     ),
                                     const SizedBox(height: 8),
                                     Text(
                                       filteredDocs[index]["qrCodeID"] ?? "",
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
                     )),
                   );
                 }
               }
            ),
          ],
        ),
      ) : const CreateQrSection(),
    );
  }
}*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/model/user_model.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/screen/home/inner_widget/all_item_empty_section.dart';
import 'package:ezyrack/view/screen/home/inner_widget/create_qr_section.dart';
import 'package:ezyrack/view/widgets/card/custom_card.dart';
import 'package:ezyrack/view/widgets/textfields/custom_textfield.dart';

class HomeScreenBottomSection extends StatefulWidget {
  final int currentIndex;

  const HomeScreenBottomSection({required this.currentIndex, super.key});

  @override
  State<HomeScreenBottomSection> createState() => _HomeScreenBottomSectionState();
}

class _HomeScreenBottomSectionState extends State<HomeScreenBottomSection> {
  final TextEditingController searchController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: widget.currentIndex == 0
          ? SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 20),
        child: Column(
          children: [
            CustomTextField(
              textEditingController: searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              isPrefixIcon: true,
              prefixIconSrc: AppIcons.searchIcon,
              hintText: "Search by Box name or Item name",
              hintStyle: GoogleFonts.publicSans(
                  fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.hintTextColor),
              fieldBorderColor: AppColors.fieldBorderColor,
              onChanged: (value) {
                setState(() {

                });
              },
            ),
            const SizedBox(height: 24),
            StreamBuilder<QuerySnapshot>(
              stream: firestore.collection(user!.uid).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                      strokeWidth: 3,
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const AllItemEmptySection();
                } else {
                  final searchText = searchController.text.toLowerCase();
                  final filteredDocs = snapshot.data!.docs.where((doc) {
                    final boxName = doc['boxName'].toString().toLowerCase();
                    final boxItemName = doc['boxItemName'] as List<dynamic>;

                    return boxName.contains(searchText) ||
                        boxItemName.any((itemName) => itemName.toLowerCase().contains(searchText));
                  }).toList();

                  if (filteredDocs.isEmpty) {
                    // Handle the case when no matching boxes are found
                    return Center(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(top: 100, bottom: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImages.emptyBox),
                            const SizedBox(height: 8),
                            Text(
                              "No matching boxes found.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                color: AppColors.colorBlack_2,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(filteredDocs.length, (index) {
                        return GestureDetector(
                          onTap: () => Get.offAndToNamed(AppRoute.boxDetailsScreen,
                              arguments: filteredDocs[index]["qrCodeID"]),
                          child: CustomCard(
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
                                          filteredDocs[index]["boxName"] ?? "",
                                          style: GoogleFonts.publicSans(
                                            color: AppColors.cardTitleColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          filteredDocs[index]["qrCodeID"] ?? "",
                                          style: GoogleFonts.publicSans(
                                            color: AppColors.cardContentColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
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
                        );
                      }),
                    );
                  }
                }
              },
            ),
          ],
        ),
      )
          : const CreateQrSection(),
    );
  }
}
