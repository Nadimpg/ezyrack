import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezyrack/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  bool isLoading = false;
  int selectedIndex = 0;
  List<String> tabTitle = ["All Items", "Create QR Code"];
  List<dynamic> filteredDocs = [];

  final TextEditingController searchController = TextEditingController();

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();



  void changeIndex(int index) {
    selectedIndex = index;
    update();
  }
}