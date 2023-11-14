import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezyrack/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class EditBoxController extends GetxController{

  bool isLoading = false;
  bool isSubmit = false;

  List<String> boxItemName = [];
  String boxName = '';
  List<String> imageUrl = [];

  TextEditingController detailsController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> fetchData(String qrCodeID) async {
    boxItemName.clear();
    imageUrl.clear();
    isLoading = true;
    update();

    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection(user!.uid)
          .doc(qrCodeID) // Replace with the actual document ID you want to fetch
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;

        boxItemName = List<String>.from(data['boxItemName'] ?? []);
        boxName = data['boxName'] ?? '';
        detailsController.text = data['boxDetails'] ?? '';
        imageUrl = List<String>.from(data['imageUrls'] ?? []);
      }
    } catch (e) {
      // need to add toast message
    }

    isLoading = false;
    update();
  }

  List<File> images = [];
  final picker = ImagePicker();

  Future<void> pickImages() async {
    final pickedImages = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImages != null) {

      images.add(File(pickedImages.path));
      update();
    }
  }

  Future<void> deleteImage(int index) async {
    images.removeAt(index);
    update();
  }

  Future<void> deleteImageFromFirebase(int index) async{

    if(index < imageUrl.length){
      final imageReference = FirebaseStorage.instance.refFromURL(imageUrl[index]);
      try{
        await imageReference.delete();
        imageUrl.removeAt(index);
        update();
      }catch (e){
        print('Error deleting image: $e');
      }
    }
    update();
  }

  Future<void> saveData(String qrCodeID) async {
    isSubmit = true;
    update();

    List<String> uploadedImageUrls = [];

    try{
      for (File imageFile in images) {
        Reference storageReference = FirebaseStorage.instance.ref().child('box_item_images/${user!.uid}').child("/$qrCodeID/${path.basename(imageFile.path)}");

        UploadTask uploadTask = storageReference.putFile(imageFile);
        TaskSnapshot storageSnapshot = await uploadTask;

        if (storageSnapshot.state == TaskState.success) {
          String downloadUrl = await storageReference.getDownloadURL();
          uploadedImageUrls.add(downloadUrl);
        }
      }

      await FirebaseFirestore.instance.collection(user!.uid).doc(qrCodeID).update({
        'boxDetails' : detailsController.text,
        'boxName' : boxName,
        'boxItemName' : boxItemName,
        'qrCodeID' : qrCodeID,
        'userID' : user!.uid,
        'imageUrls': [...imageUrl, ...uploadedImageUrls],
      });


      images.clear();
      update();


      Fluttertoast.showToast(
        msg: "Box updated Successfully",
        backgroundColor: AppColors.successColor,
        textColor: Colors.black,
        fontSize: 14,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
    catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: AppColors.primaryColor,
        textColor: AppColors.colorWhite,
        fontSize: 14,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }

    await fetchData(qrCodeID);
    isSubmit = false;
    update();
  }
}