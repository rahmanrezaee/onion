class FranchiesModel {
  String id;
  String userId;
  String industry;
  String brandName;
  String requirments;
  List<String> location = [];
  String uploadDocuments;
  String uploadVideo;

  FranchiesModel();

  Map sendMap() {
    return {
      "industry": industry,
      "brandName": brandName,
      "location": location.toList(),
      "requirments": requirments,
      "uploadDocuments": uploadDocuments,
      "uploadVideo": uploadVideo
    };
  }

  FranchiesModel.toJson(Map json) {
    this.id = json["_id"];
    this.userId = json["userId"];
    this.industry = json["industry"];
    this.brandName = json["brandName"];
    this.requirments = json["requirments"];
    this.uploadDocuments = json["uploadDocuments"];
    this.uploadVideo = json["uploadVideo"];
  }
}
