import 'package:image_picker/image_picker.dart';

class UserModel{

  String? uid;
  String? userName;
  String? postCode;
  String? email;
  String? phoneNumber;
  String? imageSrc;

  UserModel({this.uid, this.userName, this.postCode, this.email, this.phoneNumber, this.imageSrc});

  // receive data from server
  factory UserModel.fromMap(map)
  {
    return UserModel(

        uid: map['uid'],
        userName: map['username'],
        postCode: map['postCode'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        imageSrc: map['imageSrc'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap()
  {
    return {

      'uid': uid,
      'username': userName,
      'postCode': postCode,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageSrc': imageSrc,
    };
  }
}