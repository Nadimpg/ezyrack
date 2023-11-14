import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BoxDetailsController extends GetxController{

  bool isLoading = false;

  final User? user = FirebaseAuth.instance.currentUser;

  String boxType = '';
  String boxName = '';
  String boxDetails = '';
  List<String> imageUrl = [];

  Future<void> fetchData(String qrCodeID) async {
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

        boxType = data['boxType'] ?? '';
        boxName = data['boxName'] ?? '';
        boxDetails = data['boxDetails'] ?? '';
        imageUrl = List<String>.from(data['imageUrls'] ?? []);

      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    isLoading = false;
    update();
  }
}