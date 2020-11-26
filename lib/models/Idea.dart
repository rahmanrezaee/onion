import 'dart:io';

class SetupIdeaModel {
  String typeIdea = "Implemented Idea";
  String category;
  String experienceYear;
  String experienceMonth;
  String ideaHeadline;
  String ideaText;
  Map<String, dynamic> timeline = {
    "timelineType": "date",
    "details": null,
  };
  List documents = [];
  Map uploadVideo;
  String location;
  String estimatedPeople;
  String whitePaper;
  bool needServiceProvider = false;
  bool needInvestor = true;

  Map<String, String> toSendMap() {
    return {
      "ideaType": typeIdea,
      "industry": category,
      "industryExperienceInMonth":
          "${int.parse(experienceYear) * 12 + int.parse(experienceMonth)}",
      // "ideaHeadline": ideaHeadline,
      "idea": ideaText,
      "timeline": timeline.toString(),
      "uploadDocuments": documents.toString(),
      "uploadVideo": uploadVideo.toString(),
      "targetAudience": location,
      "estimatedPeople": estimatedPeople,
      "needServiceProvider": needServiceProvider.toString(),
      "needInvestor": needInvestor.toString(),
    };
  }
}
