class RequestFranchiesModel {
  String id;
  String franchiesId;
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
    this.id = json["_id"];
    this.franchiesId = json["franchiesId"];
    this.message = json["message"];
   
    this.uploadDocuments = json["uploadDocuments"];
    this.users = json["references"];
    this.uploadVideo = json["uploadVideo"];
  }
}
