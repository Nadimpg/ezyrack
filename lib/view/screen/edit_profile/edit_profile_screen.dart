import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ezyrack/core/route/app_route.dart';
import 'package:ezyrack/model/user_model.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/utils/app_images.dart';
import 'package:ezyrack/view/widgets/app_bar/app_bar_leading.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_button.dart';
import 'package:ezyrack/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:ezyrack/view/widgets/image/custom_image.dart';
import 'package:ezyrack/view/widgets/textfields/custom_vertical_label_field.dart';
import 'package:ezyrack/view/widgets/top/top_curve.dart';

class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final userImage = AppImages.userImage;

  File? imageFile;
  final imagePicker = ImagePicker();
  String? imageUrl;
  String name = "";
  String email = "";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

  UserModel loggedInUser = UserModel();

  Future<void> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;

    if(user != null){
      FirebaseFirestore.instance.collection("users").doc(user.uid).get()
          .then((value){
        loggedInUser = UserModel.fromMap(value.data());

        name = loggedInUser.userName ?? "";
        email = loggedInUser.email ?? "";

        nameController.text = loggedInUser.userName ?? "";
        emailController.text = loggedInUser.email ?? "";
        phoneNumberController.text = loggedInUser.phoneNumber ?? "";
        postCodeController.text = loggedInUser.postCode ?? "";
        imageSrc = loggedInUser.imageSrc;
        setState(() {});
      });
    }
  }

  void openGallery(BuildContext context) async{

    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 120,
        maxWidth: 120
    );

    setState(() {
      if(pickedFile != null)
      {
        imageFile = File(pickedFile.path);
      }
    });

    Get.back();
  }

  void openCamera(BuildContext context)  async{

    final pickedFile = await ImagePicker().pickImage(

        source: ImageSource.camera,
        maxHeight: 120,
        maxWidth: 120
    );
    setState(() {

      if(pickedFile != null)
      {
        imageFile = File(pickedFile.path);
      }
    });

    Get.back();
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(
            "Choose option",
            style: GoogleFonts.publicSans(color: AppColors.colorBlack, fontWeight: FontWeight.w500, fontSize: 16)
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              const Divider(height: 1, color: Colors.blue),
              ListTile(
                onTap: (){
                  openGallery(context);
                },
                title: Text("Gallery", style: GoogleFonts.publicSans(color: Colors.black)),
                leading: const Icon(Icons.account_box,color: Colors.black),
              ),
              const Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  openCamera(context);
                },
                title: Text("Camera", style: GoogleFonts.publicSans(color: Colors.black)),
                leading: const Icon(Icons.camera,color: Colors.black),
              ),
            ],
          ),
        ),);
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
                  pressed: () => Get.offAndToNamed(AppRoute.profileDetailsScreen),
                  title: "Edit Profile",
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
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 30, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
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
                                          image: imageFile != null ? DecorationImage(
                                              image: FileImage(File(imageFile!.path)),
                                              fit: BoxFit.cover
                                          ) : loggedInUser.imageSrc != null ? DecorationImage(
                                              image: NetworkImage(imageSrc!),
                                              fit: BoxFit.cover
                                          ) : DecorationImage(
                                            image: AssetImage(userImage),
                                            fit: BoxFit.cover
                                          )
                                      ),
                                    )
                                ),
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 70, left: 60),
                                        child: GestureDetector(
                                          onTap: () => showChoiceDialog(context),
                                          child: const CircleAvatar(
                                              backgroundColor: AppColors.colorWhite,
                                              radius: 18,
                                              child: Padding(
                                                padding: EdgeInsets.all(2),
                                                child: CircleAvatar(
                                                  backgroundColor: AppColors.colorBlack,
                                                  child: CustomImage(imageSrc: AppImages.cameraImage),
                                                ),
                                              )
                                          ),
                                        )
                                    )
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  name,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.colorBlack),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    email,
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
                        ),
                        const SizedBox(height: 40),
                        Column(
                          children: [
                            CustomVerticalLabelField(
                              readOnly: false,
                              label: "Name",
                              textController: nameController,
                            ),
                            const SizedBox(height: 16),
                            CustomVerticalLabelField(
                              readOnly: false,
                              label: "Email",
                              textController: emailController,
                            ),
                            const SizedBox(height: 16),
                            CustomVerticalLabelField(
                              readOnly: false,
                              label: "Phone number",
                              textController: phoneNumberController,
                            ),
                            const SizedBox(height: 16),
                            CustomVerticalLabelField(
                              readOnly: false,
                              label: "Postcode",
                              textController: postCodeController,
                            ),
                            const SizedBox(height: 24),
                            isLoading ? const CustomElevatedLoadingButton() : CustomElevatedButton(
                                buttonWidth: MediaQuery.of(context).size.width,
                                onPressed: () => updateUserData(),
                                titleText: "Update Profile"
                            )
                          ],
                        )
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

  String? imageSrc;
  bool isLoading = false;

  void updateUserData() async{

    setState(() {
      isLoading = true;
    });

    User? user = FirebaseAuth.instance.currentUser;
    
    if (imageFile != null) {
      Reference storageReference = FirebaseStorage.instance.ref().child('profile_images/${user!.uid}');
      TaskSnapshot uploadTask = await storageReference.putFile(File(imageFile!.path));
      imageSrc = await uploadTask.ref.getDownloadURL();
    }

    if(user != null){
      await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
        "username" : nameController.text,
        "postCode" : postCodeController.text,
        "phoneNumber" : phoneNumberController.text,
        "imageSrc" : imageSrc,
        "email" : emailController.text
      });
    }

    Fluttertoast.showToast(
        msg: "Profile updated successfully",
        backgroundColor: AppColors.successColor,
        textColor: AppColors.colorBlack,
        fontSize: 14,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM
    );

    setState(() {
      isLoading = false;
    });
  }
}
