import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  late DocumentSnapshot documentSnapshot;

  Future<void> fetchItems() async {
    documentSnapshot = await fireStore.collection('ezy_rack_box').doc(user!.uid).get();
  }
}