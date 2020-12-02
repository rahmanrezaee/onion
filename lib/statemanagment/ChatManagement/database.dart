import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DatabaseModels {
  final String name;
  final String email;

  DatabaseModels({this.name, this.email});
}

class RealtimeData extends ChangeNotifier {
  final databaseReference = FirebaseDatabase.instance.reference();

  Map<dynamic, dynamic> _message = {};

  Map<dynamic, dynamic> get message {
    return _message;
  }

  void createData({
    @required Map<String, String> message,
  }) {
    databaseReference
        .child("chats")
        .child("chat_123")
        .child(message['time'])
        .set({'owner': message['sendBy'], 'message': message['message']});
  }

  Future<void> deleteValue(String key) async {
    try {
      await databaseReference
          .child("chats")
          .child("chat_123")
          .child(key)
          .remove();
      databaseReference
          .child("chats")
          .child("chat_123")
          .onChildRemoved
          .listen((event) {
        _message.remove(event.snapshot.key);

        notifyListeners();
      });
    } catch (e) {
      print("Mahdi deleteValue: Error $e");
    }
  }

  Future<void> editValue(String key) async {
    try {
      await databaseReference
          .child("chats")
          .child("chat_123")
          .orderByKey()
          .onChildAdded
          .listen((event) {
        _message['${event.snapshot.key}'] = {
          "message": event.snapshot.value["message"],
          "owner": event.snapshot.value["owner"],
        };
        print("Hello:: newValue: ${event.snapshot.value}");
      });
      notifyListeners();
    } catch (e) {
      print("Mahdi Error newValue $e");
    }
  }

  Future<void> newValue() async {
    try {
      await databaseReference
          .child("chats")
          .child("chat_123")
          .orderByKey()
          .onChildAdded
          .listen((event) {
        _message['${event.snapshot.key}'] = {
          "message": event.snapshot.value["message"],
          "owner": event.snapshot.value["owner"],
        };
        print("Hello:: newValue: ${event.snapshot.value}");
      });
      notifyListeners();
    } catch (e) {
      print("Mahdi Error newValue $e");
    }
  }

  // Future<void> readData() async {
  //   Map<dynamic, dynamic> result =
  //       (await databaseReference.child("chats").child("chat_123").once()).value;
  //   result.forEach((key, value) {
  //     print("Mahdi readData: $value");
  //   });
  //   _message = result;
  //   notifyListeners();
  //   // for (int i = 0; i < result.length; i++) {
  //   //   print("Mahdi readData: ${result}");
  //   // }
  //   // print("Mahdi ReadData ${databaseReference.onValue}");
  //   // return await databaseReference;
  // }

  void updateData() {
    databaseReference.child('flutterDevsTeam1').update({'description': 'CEO'});
    databaseReference
        .child('flutterDevsTeam2')
        .update({'description': 'Team Lead'});
    databaseReference
        .child('flutterDevsTeam3')
        .update({'description': 'Senior Software Engineer'});
  }

  void deleteData() {
    databaseReference.child('flutterDevsTeam1').remove();
    databaseReference.child('flutterDevsTeam2').remove();
    databaseReference.child('flutterDevsTeam3').remove();
  }
}

class DatabaseMethods extends ChangeNotifier {
  QuerySnapshot _searchSnapshot;

  QuerySnapshot get searchSnapshot {
    return _searchSnapshot;
  }

  Future<void> getUserByUserName() async {
    try {
      final response =
          await Firestore.instance.collection("users").getDocuments();
      if (response == null) {
        return;
      }
      _searchSnapshot = response;
      print("Mahdi get: ${searchSnapshot.documents}");
      notifyListeners();
    } catch (e) {
      print("Firebase getUserByUserName ${e.toString()}");
    }
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection("users").add(userMap).catchError((e) {
      print("Firebase uploadUserInfo ${e.toString()}");
    });
  }

  createChatRoom({
    @required String chatRoomId,
    @required Map<String, dynamic> chatRoomMap,
  }) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print("Firebase createChatRoom $e}");
    });
  }

  addConversationMessages({@required String chatRoomId, messageMap}) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .then((value) {})
        .catchError((e) {
      print("getConversationMessages: $e");
    });
  }

  getConversationMessages({@required String chatRoomId}) async {
    print("getConversationMessages: executed! $chatRoomId");
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  getChatRoom(String userName) async {
    print(
        "Mahdi: getChatRoom: ${Firestore.instance.collection("ChatRoom").where("ChatRoomId", isEqualTo: userName).getDocuments()}");
    return await Firestore.instance
        .collection("ChatRoom")
        .where("ChatRoomId", isEqualTo: userName)
        .snapshots();
  }
}
