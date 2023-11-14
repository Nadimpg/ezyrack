import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezyrack/model/ezy_rack_box_model.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:ezyrack/view/screen/create_box/inner_widget/create_box_review_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class CreateBoxController extends GetxController{

  final TextEditingController boxNameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  String boxName = "";

  bool isSubmitLoading = false;
  List<File> images = [];
  final picker = ImagePicker();
  List<String> imageUrl = [];

  List<TextEditingController> itemNameController = [];

  final TextEditingController extraBoxItemNameController = TextEditingController();

  Future<void> pickImages() async {
    final pickedImages = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImages != null) {
      images.add(File(pickedImages.path));
      update();
    }
  }

  Future<void> uploadData(BuildContext context, String qrCodeID, List<String> itemNames) async {
    isSubmitLoading = true;
    update();

    User? user = FirebaseAuth.instance.currentUser;
    List<String> imageUrls = [];

    EzyRackBoxModel boxModel = EzyRackBoxModel();

    try {
      final dataCollection = FirebaseFirestore.instance.collection(user!.uid).doc(qrCodeID);
      final batch = FirebaseFirestore.instance.batch();

      for (var imageFile in images) {
        Reference storageReference = FirebaseStorage.instance.ref().child('box_item_images/${user.uid}').child("/$qrCodeID/${path.basename(imageFile.path)}");

        UploadTask uploadTask = storageReference.putFile(imageFile);
        TaskSnapshot storageSnapshot = await uploadTask;

        if (storageSnapshot.state == TaskState.success) {
          String imageUrl = await storageReference.getDownloadURL();
          imageUrls.add(imageUrl); // Add each URL to the list
        }
      }

      boxModel.boxItemName = itemNames;
      boxModel.qrCodeID = qrCodeID;
      boxModel.boxName = boxNameController.text.toString();
      boxModel.imageUrls = imageUrls;
      boxModel.boxDetails = detailsController.text.toString();
      boxModel.userID = user.uid;

      batch.set(dataCollection, boxModel.toMap(), SetOptions(merge: true));

      await batch.commit();

      images.clear();
      update();

      Fluttertoast.showToast(
        msg: "Create EZYRack Box Successfully",
        backgroundColor: AppColors.successColor,
        textColor: Colors.black,
        fontSize: 14,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );

      showAlertDialog(context);

    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: AppColors.primaryColor,
        textColor: AppColors.colorWhite,
        fontSize: 14,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }

    clearData();
    isSubmitLoading = false;
    update();
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => const CreateBoxReviewDialog()
    );
  }

  void deleteItem(int index) {
    images.removeAt(index);
    update();
  }

  void clearData(){
    boxNameController.text = "";
    detailsController.text = "";
    for (var element in itemNameController) {
      element.text = "";
    }
    update();
  }
}