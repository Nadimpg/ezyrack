import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/view/screen/profile/profile_controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTopSection extends StatefulWidget {
  
  const ProfileTopSection({super.key});

  @override
  State<ProfileTopSection> createState() => _ProfileTopSectionState();
}

class _ProfileTopSectionState extends State<ProfileTopSection> {

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: CachedNetworkImage(
                height: 100, width: 100,
                imageUrl: "${controller.profileImage}",
                imageBuilder: (context, imageProvider) => Container(
                  height: 100, width: 100,
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
                    image: controller.profileImage,
                    imageFit: BoxFit.fill,
                  ),
                ),
              )
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.username,
                  style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorBlack),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    controller.userEmail,
                    style: GoogleFonts.publicSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.cardContentColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ],
        );
      }
    );
  }
}
