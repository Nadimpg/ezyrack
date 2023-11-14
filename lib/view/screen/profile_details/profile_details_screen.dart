import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/model/user_model.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/view/screen/profile_details/inner_widget/profile_details_form.dart';
import 'package:ezyrack/view/screen/profile_details/inner_widget/profile_details_top_section.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();


  Future<void> getUserInfo() async {

    FirebaseFirestore.instance.collection("users").doc(user!.uid).get()
        .then((value){
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  void initState()
  {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.colorBlack,
        body: LayoutBuilder(
          builder: (context, constraints) => Stack(
            clipBehavior: Clip.none,
            children: [
              const TopCurve(),
              Positioned(
                top: 64,
                left: 20, right: 0,
                child: AppBarLeading(
                  pressed: () => Get.offAndToNamed(AppRoute.profileScreen),
                  title: "Profile Details",
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 135),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(16))
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 30, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProfileDetailsTopSection(loggedInUser: loggedInUser),
                        const SizedBox(height: 40),
                        ProfileDetailsForm(loggedInUser: loggedInUser)
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
