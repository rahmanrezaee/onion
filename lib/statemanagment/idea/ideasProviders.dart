import 'package:onion/const/MyUrl.dart';
import 'package:onion/models/Idea.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:onion/pages/Idea/postIdea.dart';

class IdeasProvider with ChangeNotifier {
  List<SetupIdeaModel> ideas;

  Future getIdeaList(String token) async {
    Response response = await APIRequest().get(
      myUrl: "$baseUrl/innovator/idea/list",
      token: token,
    );

    //Parsing ideaList to SetupIdeaModel
    print("Response: ${response.data}");

    ideas = List();
    (response.data as List).forEach((element) {
      SetupIdeaModel idea = new SetupIdeaModel();
      var months = int.parse(element["industryExperienceInMonth"]);
      var year = (months / 12).floor();
      var remainderMonths = months % 12;
      print("$year year and $remainderMonths months");
      idea.id = element["_id"];
      idea.userId = element["userId"];
      idea.typeIdea = element["ideaType"];
      idea.category = element["industry"];
      idea.experienceYear = year.toString();
      idea.experienceMonth = remainderMonths.toString();
      idea.ideaHeadline = element["headline"];
      idea.ideaText = element["idea"];
      idea.estimatedPeople = element["estimatedPeople"].toString();
      print("Documents ${element["uploadDocuments"]}");
      idea.location = element["targetAudience"];
      // idea.documents = ideas[index]["uploadDocuments"];
      // idea.timeline = ideas[index]["timeline"];
      ideas.add(idea);
    });

    notifyListeners();
    print("ideas $ideas");
    return response.data;
  }

  Future<bool> setupIdea(Map data, String token) async {
    Response response = await APIRequest().post(
        myUrl: "$baseUrl/innovator/idea/addsetup",
        myBody: data,
        myHeaders: {"token": "$token"});
    print("Response: ${response.data['status']}");
    return response.data['status'];
  }

  Future<bool> postIdea(Map data, String token) async {
    Response response = await APIRequest().post(
        myUrl: "$baseUrl/innovator/idea/add",
        myBody: data,
        myHeaders: {"token": "$token"});
    print("This is the response: ${response.data}");
    return response.data['status'];
  }

  Future deleteIdea(String ideaId, String token) async {
    Response response = await APIRequest().delete(
        myUrl: "$baseUrl/innovator/idea/ideaid/$ideaId",
        myBody: null,
        myHeaders: {"token": "$token"});
    print("This is the response: ${response.data}");
    ideas.removeWhere((element) => element.id == ideaId);
    notifyListeners();
    return response.data["status"];
  }
}
