import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/model/user_model.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_icons.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/widgets/image/custom_image.dart';

class ProfileDetailsTopSection extends StatefulWidget {

  final UserModel loggedInUser;

  const ProfileDetailsTopSection({required this.loggedInUser, super.key});

  @override
  State<ProfileDetailsTopSection> createState() => _ProfileDetailsTopSectionState();
}

class _ProfileDetailsTopSectionState extends State<ProfileDetailsTopSection> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 100, width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: widget.loggedInUser.imageSrc == null ? const AssetImage(AppImages.userImage) : NetworkImage(widget.loggedInUser.imageSrc!) as ImageProvider,
                          fit: BoxFit.cover
                      )
                  ),
                )
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Get.offAndToNamed(AppRoute.editProfileScreen, arguments: widget.loggedInUser);
                },
                child: Container(
                  height: 32,
                  width: 32,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.fieldFillColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 0.1, color: AppColors.hintTextColor),
                  ),
                  child: const CustomImage(
                      imageSrc: AppIcons.editIcon,
                      imageType: ImageType.svg,
                      size: 20),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.loggedInUser.userName ?? "",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorBlack),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                widget.loggedInUser.email ?? "",
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
}
