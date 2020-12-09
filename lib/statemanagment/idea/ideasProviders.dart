import 'dart:convert';

import 'package:onion/const/MyUrl.dart';
import 'package:onion/models/Idea.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:onion/pages/Idea/postIdea.dart';

class DocumentModel {
  final String id;
  final String uri;

  DocumentModel({this.id, this.uri});
}

class IdeasProvider with ChangeNotifier {
  List<SetupIdeaModel> myIdeas;
  List<SetupIdeaModel> allIdeas;
  List<DocumentModel> _temp;

  List<DocumentModel> get temp {
    return _temp;
  }

  Future getAllIdeaList(String token) async {
    Response response = await APIRequest().get(
      myUrl: "$baseUrl/innovator/idea/list",
      token: token,
    );
    print("We are getting all ideas:  ${response.data}");
    allIdeas = List();
    try {
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
        List doc = element["uploadDocuments"];
        idea.documents = doc;
        Map timeLine = element["timeline"];
        idea.timeline = timeLine;
        Map uploadVideo = element["uploadVideo"];
        idea.uploadVideo = uploadVideo;
        allIdeas.add(idea);
      });
    } catch (e) {
      print("error: $e");
    }
    notifyListeners();
    print("AllIdeas $allIdeas");
    return response.data;
  }

  Future getMyIdeaList(String token) async {
    Response response = await APIRequest().get(
      myUrl: "$baseUrl/innovator/idea/list?list=my",
      token: token,
    );

    //Parsing ideaList to SetupIdeaModel
    // print("Response: ${response.data}");
    // List<SetupIdeaModel> apiData =
    //     (json.decode(utf8.decode(response.data)) as List).map((data) {
    //   return (response.data as List).forEach((element) {
    //     SetupIdeaModel idea = new SetupIdeaModel();
    //     var months = int.parse(element["industryExperienceInMonth"]);
    //     var year = (months / 12).floor();
    //     var remainderMonths = months % 12;
    //     print("$year year and $remainderMonths months");
    //     idea.id = element["_id"];
    //     idea.userId = element["userId"];
    //     idea.typeIdea = element["ideaType"];
    //     idea.category = element["industry"];
    //     idea.experienceYear = year.toString();
    //     idea.experienceMonth = remainderMonths.toString();
    //     idea.ideaHeadline = element["headline"];
    //     idea.ideaText = element["idea"];
    //     idea.estimatedPeople = element["estimatedPeople"].toString();
    //     print("Documents ${element["uploadDocuments"]}");
    //     idea.location = element["targetAudience"];
    //     // idea.documents = ideas[index]["uploadDocuments"];
    //     // idea.timeline = ideas[index]["timeline"];
    //   });
    // }).toList();
    print("The response datas:  ${response.data}");
    myIdeas = List();
    try {
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
        List doc = element["uploadDocuments"];
        idea.documents = doc;
        Map timeLine = element["timeline"];
        idea.timeline = timeLine;
        Map uploadVideo = element["uploadVideo"];
        idea.uploadVideo = uploadVideo;
        // print("Mahdi: ${json.decode(element["uploadDocuments"])}");
        // (element["uploadDocuments"] as List).forEach((d) {
        //   idea.documents.add(d);
        // });
        // print("Mahdi: ${element["uploadDocuments"]}");
        // print("Mahdi: element ${element["uploadDocuments"]}");
        // element["uploadDocuments"].map((e) {
        //   print("Mahdi: $e");
        // });

        // print("document ${doc}");
        myIdeas.add(idea);
      });
    } catch (e) {
      print("error: $e");
    }

    notifyListeners();
    print("ideas $myIdeas");
    return response.data;
  }

  Future<bool> setupIdea(Map data, String token) async {
    Response response = await APIRequest().post(
        myUrl: "$baseUrl/innovator/idea/addsetup",
        myBody: data,
        myHeaders: {"token": "$token"});
    print("Response: ${response.data}");
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

  findIdea(String key, String token) async {
    allIdeas = new List();
    Response response = await APIRequest().get(
        myUrl: "$baseUrl/innovator/idea/list?search=$key",
        // myBody: null,
        token: "$token");
    print("This is the result of $key: ${response.data}");
    try {
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
        List doc = element["uploadDocuments"];
        idea.documents = doc;
        Map timeLine = element["timeline"];
        idea.timeline = timeLine;
        Map uploadVideo = element["uploadVideo"];
        idea.uploadVideo = uploadVideo;
        // print("Mahdi: ${json.decode(element["uploadDocuments"])}");
        // (element["uploadDocuments"] as List).forEach((d) {
        //   idea.documents.add(d);
        // });
        // print("Mahdi: ${element["uploadDocuments"]}");
        // print("Mahdi: element ${element["uploadDocuments"]}");
        // element["uploadDocuments"].map((e) {
        //   print("Mahdi: $e");
        // });

        // print("document ${doc}");
        allIdeas.add(idea);
      });
    } catch (e) {
      print("error: $e");
    }
    return response.data;
  }

  Future<bool> bidIdea(Map data, String token) async {
    Response response = await APIRequest().post(
        myUrl: "$baseUrl/innovator/idea/bid",
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
    myIdeas.removeWhere((element) => element.id == ideaId);
    notifyListeners();
    return response.data["status"];
  }

  Future updateIdea(String ideaId, String token, data) async {
    Response response = await APIRequest().put(
        myUrl: "$baseUrl/innovator/idea/ideaid/$ideaId",
        myBody: data,
        myHeaders: {"token": "$token"});
    print("This is the response: ${response.data}");
    notifyListeners();
    return response.data["status"];
  }
}
