class FranchiesModel {
  String id;
  String userId;
  String industry;
  String brandName;
  String requirments;
  List location = [];
  List uploadDocuments = [];
  List uploadVideo = [];

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
    this.location = json["location"];
    this.uploadDocuments = json["uploadDocuments"];
    this.uploadVideo = json["uploadVideo"];
  }
}
