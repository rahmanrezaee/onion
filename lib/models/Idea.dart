class SetupIdeaModel {
  String id;
  String userId;
  String typeIdea = "Implemented Idea";
  String category; //Or Industry
  String experienceYear;
  String experienceMonth;
  String ideaHeadline;
  String ideaText;
  Map timeline = {
    "timelineType": "date",
    "details": null,
  };
  SetupIdeaModel();
  // SetupIdeaModel({
  //   this.id,
  //   this.userId,
  //   this.typeIdea,
  //   this.category,
  //   this.experienceYear,
  //   this.experienceMonth,
  //   this.ideaHeadline,
  //   this.ideaText,
  //   this.timeline,
  // });
  List documents = [];
  Map uploadVideo;
  String location;
  String estimatedPeople;
  Map whitePaper;
  bool needServiceProvider = false;
  bool needInvestor = true;

  Map toSendMap() {
    return {
      "ideaType": typeIdea,
      "industry": category,
      "industryExperienceInMonth":
          "${int.parse(experienceYear) * 12 + int.parse(experienceMonth)}",
      "headline": ideaHeadline,
      "idea": ideaText,
      "timeline": timeline,
      "uploadDocuments": documents,
      "uploadVideo": uploadVideo,
      "targetAudience": "$location",
      "uploadPaper": whitePaper,
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

  // SetupIdeaModel.fromJson(Map<String, dynamic> json) {
  //   var months = int.parse(json["industryExperienceInMonth"]);
  //   var year = (months / 12).floor();
  //   var remainderMonths = months % 12;
  //   experienceYear = "$year";
  //   experienceMonth = "$remainderMonths";
  //   estimatedPeople = json['estimatedPeople'];
  //   needServiceProvider = json['needServiceProvider'];
  //   needInvestor = json['needInvestor'];
  //   id = json['_id'];
  //   userId = json['userId'];
  //   typeIdea = json['ideaType'];
  //   category = json['industry'];
  //   ideaHeadline = json['headline'];
  //   ideaText = json['idea'];
  //   // timeline = json['timeline'] ?? null;
  //   // if (json['uploadDocuments'] != null) {
  //   //   documents = new List();
  //   //   json['uploadDocuments'].forEach((v) {
  //   //     documents.add(v);
  //   //   });
  //   // }
  //   // uploadVideo = json['uploadVideo'];
  //   location = json['targetAudience'];
  //   // iV = json['__v'];
  // }
}

// class SetupIdeaModel {
//   int experienceYear;
//   int experienceMonth;
//   int estimatedPeople;
//   bool needServiceProvider;
//   bool needInvestor;
//   String sId;
//   String userId;
//   String ideaType;
//   String industry;
//   String headline;
//   String idea;
//   Timeline timeline;
//   List<UploadDocuments> uploadDocuments;
//   UploadDocuments uploadVideo;
//   String targetAudience;
//   int iV;

//   SetupIdeaModel(
//       {this.experienceYear,
//       this.experienceMonth,
//       this.estimatedPeople,
//       this.needServiceProvider,
//       this.needInvestor,
//       this.sId,
//       this.userId,
//       this.ideaType,
//       this.industry,
//       this.headline,
//       this.idea,
//       this.timeline,
//       this.uploadDocuments,
//       this.uploadVideo,
//       this.targetAudience,
//       this.iV});

//   SetupIdeaModel.fromJson(Map<String, dynamic> json) {
//     var months = int.parse(json["industryExperienceInMonth"]);
//     var year = (months / 12).floor();
//     var remainderMonths = months % 12;
//     experienceYear = year;
//     experienceMonth = remainderMonths;
//     estimatedPeople = json['estimatedPeople'];
//     needServiceProvider = json['needServiceProvider'];
//     needInvestor = json['needInvestor'];
//     sId = json['_id'];
//     userId = json['userId'];
//     ideaType = json['ideaType'];
//     industry = json['industry'];
//     headline = json['headline'];
//     idea = json['idea'];
//     timeline = json['timeline'] != null
//         ? new Timeline.fromJson(json['timeline'])
//         : null;
//     if (json['uploadDocuments'] != null) {
//       uploadDocuments = new List<UploadDocuments>();
//       json['uploadDocuments'].forEach((v) {
//         uploadDocuments.add(new UploadDocuments.fromJson(v));
//       });
//     }
//     uploadVideo = json['uploadVideo'] != null
//         ? new UploadDocuments.fromJson(json['uploadVideo'])
//         : null;
//     targetAudience = json['targetAudience'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['industryExperienceInMonth'] =
//         "${this.experienceYear * 12 + this.experienceMonth}";
//     data['estimatedPeople'] = this.estimatedPeople;
//     data['needServiceProvider'] = this.needServiceProvider;
//     data['needInvestor'] = this.needInvestor;
//     data['_id'] = this.sId;
//     data['userId'] = this.userId;
//     data['ideaType'] = this.ideaType;
//     data['industry'] = this.industry;
//     data['headline'] = this.headline;
//     data['idea'] = this.idea;
//     if (this.timeline != null) {
//       data['timeline'] = this.timeline.toJson();
//     }
//     if (this.uploadDocuments != null) {
//       data['uploadDocuments'] =
//           this.uploadDocuments.map((v) => v.toJson()).toList();
//     }
//     if (this.uploadVideo != null) {
//       data['uploadVideo'] = this.uploadVideo.toJson();
//     }
//     data['targetAudience'] = this.targetAudience;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

// class Timeline {
//   String timelineType;
//   Details details;

//   Timeline({this.timelineType, this.details});

//   Timeline.fromJson(Map<String, dynamic> json) {
//     timelineType = json['timelineType'];
//     details =
//         json['details'] != null ? new Details.fromJson(json['details']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['timelineType'] = this.timelineType;
//     if (this.details != null) {
//       data['details'] = this.details.toJson();
//     }
//     return data;
//   }
// }

// class Details {
//   String date;

//   Details({this.date});

//   Details.fromJson(Map<String, dynamic> json) {
//     date = json['date'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['date'] = this.date;
//     return data;
//   }
// }

// class UploadDocuments {
//   String sId;
//   String uriPath;

//   UploadDocuments({this.sId, this.uriPath});

//   UploadDocuments.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     uriPath = json['uriPath'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['uriPath'] = this.uriPath;
//     return data;
//   }
// }
