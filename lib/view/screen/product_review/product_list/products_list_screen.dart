import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/model/user_model.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/screen/product_review/product_list/inner_widget/all_ezy_rack_items.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';

class ProductListScreen extends StatefulWidget {
  
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

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
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.colorBlack,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => Stack(
            clipBehavior: Clip.none,
            children: [
              const TopCurve(),
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppBarLeading(
                      pressed: () => Get.offAndToNamed(AppRoute.homeScreen),
                      title: "EZYRack Products",
                    ),
                    InkWell(
                        onTap: (){
                          Get.offAndToNamed(AppRoute.profileScreen);
                        },borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 50, width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: loggedInUser.imageSrc == null ? const AssetImage(AppImages.userImage) : NetworkImage(loggedInUser.imageSrc!) as ImageProvider,
                                  fit: BoxFit.cover
                              )
                          ),
                        )
                    ),
                  ],
                ),
              ),
              const AllEzyRackItems()
            ],
          ),
        ),
      ),
    );
  }
}
