import 'package:onion/models/users.dart';

class RequestFranchiesModel {
  String id;
  String franchiesId;
  User userData = new User();
  String date;
  String message;

  List users = [];
  List uploadDocuments = [];
  List uploadVideo = [];

  RequestFranchiesModel();

  Map sendMap() {
    return {
      "franchiesId": franchiesId,
      "date": date,
      "message": message,
      "uploadDocuments": uploadDocuments,
      "uploadVideo": uploadVideo.toList(),
      "references": users.toList()
    };
  }

  RequestFranchiesModel.toJson(Map json) {
    print("json $json");
    this.id = json["_id"];
    this.franchiesId = json["franchiesId"];
    this.message = json["message"];
    this.date = json["date"];

    this.uploadDocuments =
        json["uploadDocuments"] is List ? json["uploadDocuments"] : [];
    this.users = json["references"] is List ? json["references"] : [];
    this.uploadVideo = json["uploadVideo"] is List ? json["uploadVideo"] : [];

    this.userData.id = json["userId"]['_id'];
    this.userData.username = json["userId"]['username'];
    this.userData.interst = json["userId"]['interestedin'];

    
  }
}
