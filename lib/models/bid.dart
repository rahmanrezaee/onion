import 'package:intl/intl.dart';

class BidModel {
  String ideaId;
  String whatYouDo;
  String industry;
  String projectName;
  String projectJobSummary;
  List uploadDocuments;
  Map uploadVideo;
  DateTime date;
  String message;
  BidModel({
    this.ideaId,
    this.whatYouDo,
    this.industry,
    this.projectName,
    this.projectJobSummary,
    this.uploadDocuments,
    this.uploadVideo,
    this.date,
    this.message,
  });

  toJson() {
    //Some parameters is deffrent from Server side
    return {
      "ideaId": this.ideaId,
      "idea": this.whatYouDo,
      "industry": this.industry,
      "projectName": this.projectName,
      "projectJobSummary": this.projectJobSummary,
      "uploadDocuments": this.uploadDocuments,
      "uploadVideo": this.uploadVideo,
      "date": DateFormat.yMd().format(this.date),
      "message": this.message,
    };
  }

  fromJson(json) {
    //Some parameters is deffrent from Server side
    return BidModel(
      ideaId: json["ideaId"],
      whatYouDo: json["idea"],
      industry: json["industry"],
      projectName: json["projectName"],
      projectJobSummary: json["projectJobSummary"],
      uploadDocuments: json["uploadDocuments"],
      uploadVideo: json["uploadVideo"],
      date: DateTime(json["date"]),
      message: json["message"],
    );
  }
}
