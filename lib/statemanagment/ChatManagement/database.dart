import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseModels {
  final String name;
  final String email;

  DatabaseModels({this.name, this.email});
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
}
