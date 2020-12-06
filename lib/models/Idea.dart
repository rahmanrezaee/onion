class SetupIdeaModel {
  String id;
  String userId;
  String typeIdea = "Implemented Idea";
  String category; //Or Industry
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
  Map whitePaper;
  bool needServiceProvider = false;
  bool needInvestor = true;

  Map<String, String> toSendMap() {
    return {
      "ideaType": typeIdea,
      "industry": category,
      "industryExperienceInMonth":
          "${int.parse(experienceYear) * 12 + int.parse(experienceMonth)}",
      "headline": ideaHeadline,
      "idea": ideaText,
      "timeline": "$timeline",
      "uploadDocuments": "$documents",
      "uploadVideo": "$uploadVideo",
      "targetAudience": "$location",
      "uploadPaper": "$whitePaper",
      "estimatedPeople": estimatedPeople,
      "needServiceProvider": "$needServiceProvider",
      "needInvestor": "$needInvestor",
    };
    // return {
    //   json.encode("ideaType"): json.encode(typeIdea),
    //   json.encode("industry"): json.encode(category),
    //   json.encode("industryExperienceInMonth"): json.encode(
    //       "${int.parse(experienceYear) * 12 + int.parse(experienceMonth)}"),
    //   json.encode("headline"): json.encode(ideaHeadline),
    //   json.encode("idea"): json.encode(ideaText),
    //   json.encode("timeline"): "${json.encode(timeline)}",
    //   json.encode("uploadDocuments"): "${json.encode(documents)}",
    //   json.encode("uploadVideo"): "${json.encode(uploadVideo)}",
    //   json.encode("targetAudience"): "${json.encode(location)}",
    //   json.encode("uploadPaper"): "${json.encode(whitePaper)}",
    //   json.encode("estimatedPeople"): estimatedPeople,
    //   json.encode("needServiceProvider"): "${json.encode(needServiceProvider)}",
    //   json.encode("needInvestor"): "${json.encode(needInvestor)}",
    // };
  }
}
