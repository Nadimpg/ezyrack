class EzyRackBoxModel{

  String? userID;
  String? qrCodeID;
  String? boxName;
  List<dynamic>? boxItemName;
  String? boxDetails;
  List<dynamic>? imageUrls;

  EzyRackBoxModel({
    this.userID,
    this.qrCodeID,
    this.boxItemName,
    this.boxName,
    this.boxDetails,
    this.imageUrls,
  });

  // receive data from server
  factory EzyRackBoxModel.fromMap(map) {

    return EzyRackBoxModel(
      userID: map['userID'],
      qrCodeID: map['qrCodeID'],
      boxItemName: map['boxItemName'],
      boxName: map['boxName'],
      boxDetails: map['boxDetails'],
      imageUrls: map['imageUrls'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'qrCodeID': qrCodeID,
      'boxItemName': boxItemName,
      'boxName': boxName,
      'boxDetails': boxDetails,
      'imageUrls': imageUrls,
    };
  }
}