import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DatabaseModels {
  final String name;
  final String email;

  DatabaseModels({this.name, this.email});
}

class RealtimeData extends ChangeNotifier {
  final databaseReference = FirebaseDatabase.instance.reference();
  Map<dynamic, dynamic> _userInfo = {};

  Map<dynamic, dynamic> get userInfo {
    return _userInfo;
  }

  Future<void> getUserInfo(String firebaseId) async {
    try {
      await databaseReference
          .child("root")
          .child("users")
          .child("$firebaseId")
          // .child("$firebaseId")
          .once()
          .then((value) {
        _userInfo = value.value;
        notifyListeners();
      });
    } catch (e) {
      print("Error getAllContacts: $e");
    }
  }

  void clearUserInfo() {
    try {
      if (_userInfo.isNotEmpty) {
        _userInfo.clear();
      }
      notifyListeners();
    } catch (e) {
      print("Error clearUserInfo: $e");
    }
  }

  Map<dynamic, dynamic> _myMessage = {};

  Map<dynamic, dynamic> get myMessage {
    return _myMessage;
  }

  Future<void> getMyMessage(String groupName) async {
    try {
      await databaseReference
          .child("root")
          .child("messages")
          .child("$groupName")
          .orderByKey()
          .onChildAdded
          .listen((event) {
        print("Hello:: newValue: ${event.snapshot.key}");

        _myMessage['${event.snapshot.key}'] = {
          "message": event.snapshot.value["message"],
          "sendBy": event.snapshot.value["sendBy"],
        };

        notifyListeners();
      });
    } catch (e) {
      print("Error getMyMessage: $e");
    }
  }

  Future<void> editValue({
    @required String key,
    @required String editMessage,
    @required String groupName,
  }) async {
    print("I am Edit Method");
    try {
      await databaseReference
          .child("root")
          .child("messages")
          .child("$groupName")
          .child(key)
          .set({'sendBy': _myMessage[key]['sendBy'], 'message': editMessage});
      // databaseReference
      //     .child("chats")
      //     .child("chat_123")
      //     .onChildChanged
      //     .listen((event) {
      //   _myMessage[key]["message"] = ;
      //   notifyListeners();
      // });
    } catch (e) {
      print("Mahdi Error newValue $e");
    }
  }

  void editListener(String groupName) {
    try {
      databaseReference
          .child("root")
          .child("messages")
          .child("$groupName")
          .onChildChanged
          .listen((event) {
        print("Mahdi editListener ${event.snapshot.value["message"]}");
        _myMessage[event.snapshot.key]["message"] =
            event.snapshot.value["message"];
        notifyListeners();
      });
    } catch (e) {
      print("Error Mahdi editListener $e");
    }
  }

  void deleteListener(String groupName) {
    try {
      databaseReference
          .child("root")
          .child("messages")
          .child("$groupName")
          .onChildRemoved
          .listen((event) {
        print("Mahdi deleteValue: ${event.snapshot.key}");

        _myMessage.remove(event.snapshot.key);
        notifyListeners();
      });
    } catch (e) {
      print("Mahdi deleteListener $e");
    }
  }

  Future<void> deleteValue({String key, String groupName}) async {
    try {
      await databaseReference
          .child("root")
          .child("messages")
          .child("$groupName")
          .child("$key")
          .remove();
    } catch (e) {
      print("Mahdi deleteValue: Error $e");
    }
  }

  void sendMessage({
    @required Map<String, String> sendProperty,
    String groupName,
  }) {
    databaseReference
        .child("root")
        .child("messages")
        .child("$groupName")
        .child(sendProperty['time'])
        .set({
      'sendBy': sendProperty['sendBy'],
      'message': sendProperty['message']
    });
  }

  void clearMyMessage() {
    try {
      if (_myMessage.isNotEmpty) {
        _myMessage.clear();
      }
      notifyListeners();
    } catch (e) {
      print("Error clearMyMessage: $e");
    }
  }

  void createData({
    @required Map<String, String> messageParam,
  }) {
    databaseReference
        .child("chats")
        .child("chat_123")
        .child(messageParam['time'])
        .set({
      'sendBy': messageParam['sendBy'],
      'message': messageParam['message']
    });
  }

  Future<void> getAllContacts() async {
    try {
      await databaseReference
          .child("root")
          .child("users")
          .child("5fb6650eacc60d0011910a9b")
          .once()
          .then((value) {
        print("Mahdi getAllContacts: ${value.value}");
      });
      // });
    } catch (e) {
      print("Error getAllContacts: $e");
    }
  }
}

// class DatabaseMethods extends ChangeNotifier {
//   QuerySnapshot _searchSnapshot;
//
//   QuerySnapshot get searchSnapshot {
//     return _searchSnapshot;
//   }
//
//   Future<void> getUserByUserName() async {
//     try {
//       final response =
//           await Firestore.instance.collection("users").getDocuments();
//       if (response == null) {
//         return;
//       }
//       _searchSnapshot = response;
//       print("Mahdi get: ${searchSnapshot.documents}");
//       notifyListeners();
//     } catch (e) {
//       print("Firebase getUserByUserName ${e.toString()}");
//     }
//   }
//
//   createChatRoom({
//     @required String chatRoomId,
//     @required Map<String, dynamic> chatRoomMap,
//   }) {
//     Firestore.instance
//         .collection("ChatRoom")
//         .document(chatRoomId)
//         .setData(chatRoomMap)
//         .catchError((e) {
//       print("Firebase createChatRoom $e}");
//     });
//   }
// }
// addConversationMessages({@required String chatRoomId, messageMap}) {
//   Firestore.instance
//       .collection("ChatRoom")
//       .document(chatRoomId)
//       .collection("chats")
//       .add(messageMap)
//       .then((value) {})
//       .catchError((e) {
//     print("getConversationMessages: $e");
//   });
// }

// getConversationMessages({@required String chatRoomId}) async {
//   print("getConversationMessages: executed! $chatRoomId");
//   return await FirebaseFirestore.instance
//       .collection("ChatRoom")
//       .document(chatRoomId)
//       .collection("chats")
//       .orderBy("time", descending: true)
//       .snapshots();
// }

// getChatRoom(String userName) async {
//   print(
//       "Mahdi: getChatRoom: ${Firestore.instance.collection("ChatRoom").where("ChatRoomId", isEqualTo: userName).getDocuments()}");
//   return await Firestore.instance
//       .collection("ChatRoom")
//       .where("ChatRoomId", isEqualTo: userName)
//       .snapshots();
// }

//
// Future<void> editValue({String key, String editMessage}) async {
//   try {
//     _message[key]["message"] = editMessage;
//     await databaseReference
//         .child("chats")
//         .child("chat_123")
//         .child(key)
//         .set({'owner': message[key]['owner'], 'message': editMessage});
//     databaseReference
//         .child("chats")
//         .child("chat_123")
//         .onChildChanged
//         .listen((event) {
//       notifyListeners();
//     });
//   } catch (e) {
//     print("Mahdi Error newValue $e");
//   }
// }

// -----------
//   Map<dynamic, dynamic> _message = {};
//
//   Map<dynamic, dynamic> get message {
//     return _message;
//   }

// -------

// uploadUserInfo(userMap) {
//   Firestore.instance.collection("users").add(userMap).catchError((e) {
//     print("Firebase uploadUserInfo ${e.toString()}");
//   });
// }

// Future<void> newValue() async {
//   try {
//     await databaseReference
//         .child("chats")
//         .child("chat_123")
//         .orderByKey()
//         .onChildAdded
//         .listen((event) {
//       _message['${event.snapshot.key}'] = {
//         "message": event.snapshot.value["message"],
//         "owner": event.snapshot.value["owner"],
//       };
//       print("Hello:: newValue: ${event.snapshot.value}");
//     });
//     notifyListeners();
//   } catch (e) {
//     print("Mahdi Error newValue $e");
//   }
// }

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

// void updateData() {
//   databaseReference.child('flutterDevsTeam1').update({'description': 'CEO'});
//   databaseReference
//       .child('flutterDevsTeam2')
//       .update({'description': 'Team Lead'});
//   databaseReference
//       .child('flutterDevsTeam3')
//       .update({'description': 'Senior Software Engineer'});
// }

// Map<dynamic, dynamic> _messageWithAuth = {};

// Map<dynamic, dynamic> get messageWithAuth {
//   return _messageWithAuth;
// }
//
// void clearMessageWithAuth() {
//   _messageWithAuth.clear();
// }
