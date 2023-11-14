import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezyrack/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends GetxController{

  bool isLoading = false;

  User? user = FirebaseAuth.instance.currentUser;
  GoogleSignInAccount? googleUser;

  String? profileImage;
  String username = "";
  String userEmail = "";
  String phoneNumber = "";
  String postCode = "";

  Future<void> getUserInfo() async {
    isLoading = true;
    update();

    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;

        profileImage = data['imageSrc'] ?? '';
        username = data['username'] ?? '';
        userEmail = data['email'] ?? '';
        phoneNumber = data['phoneNumber'] ?? '';
        postCode = data['postCode'] ?? '';
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    isLoading = false;
    update();
  }
}