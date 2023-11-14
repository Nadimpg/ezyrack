import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/model/user_model.dart';
import 'package:ezyrack/utils/app_colors.dart';

class HomeScreenTopSection extends StatefulWidget {
  const HomeScreenTopSection({super.key});

  @override
  State<HomeScreenTopSection> createState() => _HomeScreenTopSectionState();
}

class _HomeScreenTopSectionState extends State<HomeScreenTopSection> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  Future<void> getUserName() async {

    FirebaseFirestore.instance.collection("users").doc(user!.uid).get()
        .then((value){
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: (){
                Get.offAndToNamed(AppRoute.profileScreen);
              },borderRadius: BorderRadius.circular(50),
              child: loggedInUser.imageSrc != null ? CachedNetworkImage(
                height: 50, width: 50,
                imageUrl: "${loggedInUser.imageSrc}",
                imageBuilder: (context, imageProvider) => Container(
                  height: 50, width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover
                      )
                  ),
                ),
                placeholder: (context, hash) => ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BlurHash(
                    color: AppColors.transparentColor,
                    hash: "LHA-Vc_4s9ad4oMwt8t7RhXTNGRj",
                    image: loggedInUser.imageSrc,
                    imageFit: BoxFit.fill,
                  ),
                ),
              ) : Container(
                height: 50, width: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/images/user_image.png"),
                        fit: BoxFit.cover
                    )
                ),
              )
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back",
                  style: GoogleFonts.publicSans(
                    color: AppColors.textColor_1,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  loggedInUser.userName ?? "",
                  style: GoogleFonts.montserrat(
                      color: AppColors.textColor_1,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}