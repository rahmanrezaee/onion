import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/Size.dart';
import '../const/color.dart';
import '../widgets/AnalysisWidget/MyAlert.dart';
import '../widgets/MyLittleAppbar.dart';
import '../statemanagment/ChatManagement/Constants.dart';
import '../statemanagment/ChatManagement/database.dart';
import '../statemanagment/auth_provider.dart';
import '../widgets/ChatTabWidget/MyChatItems.dart';
import '../const/values.dart';

class ProjectChat extends StatefulWidget {
  static const routeName = "project_chat";

  @override
  _ProjectChatState createState() => _ProjectChatState();
}

class _ProjectChatState extends State<ProjectChat> {
  final TextEditingController sendTxt = new TextEditingController();
  String args;
  Future<void> myFuture;
  var _tapPosition;
  bool isEditMode = false;
  String editKey;
  FocusNode _focusNode = FocusNode();
  String getName;
  String firebaseId;
  RealtimeData realTimeData;
  final _listViewController = ScrollController();

  sendMessage({String chatRoomId}) async {
    print("Mahdi sendMessage1");
    if (sendTxt.text.isEmpty || Constants.myName == null) {
      return;
    }
    if (!isEditMode) {
      Map<String, String> messageMap = {
        "message": sendTxt.text,
        "sendBy": getName,
        "time": DateTime.now().millisecondsSinceEpoch.toString(),
        "firebaseId": firebaseId,
      };

      await RealtimeData().sendMessage(
        sendProperty: messageMap,
        groupName: args,
      );
      gotoLast(50);
    } else if (editKey != null) {
      realTimeData.editValue(
        key: editKey,
        editMessage: sendTxt.text,
        groupName: args,
        firebaseId: firebaseId,
      );
    }

    editKey = "";
    sendTxt.text = "";
    isEditMode = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      realTimeData = Provider.of<RealtimeData>(context, listen: false);
      realTimeData.clearMyMessage();
      args = ModalRoute.of(context).settings.arguments;

      myFuture = realTimeData.getMyMessage(args);
      getName = Provider.of<Auth>(context, listen: false).getName;
      firebaseId = Provider.of<Auth>(context, listen: false).firebaseId;
      realTimeData.deleteListener(args, firebaseId);
      realTimeData.editListener(args, firebaseId);
    });
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  showAlertDialog(BuildContext context, String key) {
    Widget okBtn = FlatButton(
      child: Text("OK"),
      onPressed: () {
        realTimeData.deleteValue(key: key, groupName: args);
        Navigator.pop(context);
      },
    );

    Widget cancelBtn = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Are you sure?"),
      content: Text("Do you want to delete this message?"),
      actions: [cancelBtn, okBtn],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showMyPopUp(BuildContext context, String key, String message) async {
    editKey = key.toString();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    var value = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        _tapPosition & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem<int>(
          value: 0,
          child: Text('Delete'),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Text('Edit'),
        ),
      ],
    );
    if (value == 0) {
      showAlertDialog(context, key);
    } else if (value == 1) {
      isEditMode = true;
      sendTxt.text = message;
      FocusScope.of(context).requestFocus(_focusNode);
      // myFutureTemp.editValue(key);
    }
  }

  void gotoLast(int time) {
    if (_listViewController.hasClients) {
      Timer(
        Duration(milliseconds: time),
        () => _listViewController.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: MyLittleAppbar(myTitle: "Project Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: myFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.error != null) {
                    return Center(
                      child: Text("Error Occurred"),
                    );
                  } else {
                    return Consumer<RealtimeData>(
                      builder: (BuildContext context, value, Widget child) {
                        if (value.myMessage.isNotEmpty) {
                          return ListView.builder(
                            controller: _listViewController,
                            itemCount: value.myMessage.length,
                            reverse: true,
                            itemBuilder: (ctx, index) {
                              String key = value.myMessage.keys.elementAt(
                                value.myMessage.length - index - 1,
                              );
                              String getPreviuosdate = "";
                              if (index > 0) {
                                String previouskey =
                                    value.myMessage.keys.elementAt(
                                  index - 1,
                                );
                                String previuosdate =
                                    DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(previouskey),
                                ).toString();
                                getPreviuosdate = previuosdate.substring(
                                    0, previuosdate.indexOf(" "));
                              }
                              String date = DateTime.fromMillisecondsSinceEpoch(
                                int.parse(key),
                              ).toString();
                              print("Mahdi ListView: $date");
                              String chatDate =
                                  date.substring(0, date.indexOf(" ")) !=
                                          getPreviuosdate
                                      ? date.substring(0, date.indexOf(" "))
                                      : "";
                              bool isMeFlag = value.myMessage[key]
                                      ["firebaseId"] ==
                                  firebaseId;

                              return GestureDetector(
                                onTapDown: _storePosition,
                                onTap: isMeFlag
                                    ? () => showMyPopUp(
                                          context,
                                          key,
                                          value.myMessage[key]["message"],
                                        )
                                    : null,
                                child: MyChatItems(
                                  isMe: isMeFlag,
                                  message:
                                      "${value.myMessage[key.toString()]["message"]}",
                                  date: "$chatDate",
                                  hour:
                                      "${date.substring(date.indexOf(" "), date.lastIndexOf(":"))}",
                                  firebaseId: firebaseId,
                                ),
                              );
                            },
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    );
                  }
                }
              },
            ),
          ),
          Container(
            width: deviceSize(context).width - deviceSize(context).width * 0.05,
            margin: EdgeInsets.symmetric(
              horizontal: deviceSize(context).width * 0.01,
              vertical: deviceSize(context).height * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: sendTxt,
                    focusNode: _focusNode,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    onSubmitted: (_) => sendMessage(chatRoomId: args),
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: grey),
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(5.0),
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                        top: deviceSize(context).height * 0.01,
                        bottom: deviceSize(context).height * 0.01,
                        left: deviceSize(context).width * 0.02,
                      ),
                      fillColor: grey,
                      hintText: "Type your message",
                      filled: true,
                      suffixIcon: InkWell(
                        onTap: () => sendMessage(chatRoomId: args),
                        child: Icon(Icons.send, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// if (snap.hasData &&
//     !snap.hasError &&
//     snap.data.snapshot.value != null) {
//   Map data = snap.data.snapshot.value;
//   List item = [];
//   data.forEach(
//       (index, data) => item.add({"key": index, ...data}));
//   return ListView.builder(
//     itemCount: item.length,
//     itemBuilder: (context, index) {
//       return ListTile(
//         title: Text(item[index]['message']),
//         trailing: Text(DateFormat("hh:mm:ss")
//             .format(DateTime.fromMicrosecondsSinceEpoch(
//                 item[index]['timestamp'] * 1000))
//             .toString()),
//         onTap: () => updateTimeStamp(item[index]['key']),
//         onLongPress: () => deleteMessage(item[index]['key']),
//       );
//     },
//   );
// } else
//   return Text("No data");
// Stream chatMessagesStream;

// Widget chatMessageList() {
//   return StreamBuilder(
//     stream: chatMessagesStream,
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       } else {
//         if (snapshot.error != null) {
//           return Center(child: Text("Error Occurred!"));
//         } else {
//           return ListView.builder(
//             itemCount: snapshot.data.documents.length,
//             reverse: true,
//             itemBuilder: (streamCtx, index) {
//               return MyChatItems(
//                 isMe: snapshot.data.documents[index]["sendBy"] ==
//                     Constants.myName,
//                 message: snapshot.data.documents[index]["message"],
//               );
//             },
//           );
//         }
//       }
//     },
//   );
// }
// Provider.of<RealtimeData>(context, listen: false).newValue();

// databaseMethods.getConversationMessages(chatRoomId: args).then((val) {
//   setState(() {
//     chatMessagesStream = val;
//   });
// });
// result.forEach((key, value) {
//   print("Mahdi readData: $value");
// });
// RealtimeData().readData();

// return Text("Data valid");
// result.forEach((key, value) {
//   return Text("Data valid");
// });
// result.forEach((key, value) {
//   print("Mahdi readData: $value");
// });
// return Text("Data valid");

// Container(
//   width: deviceSize(context).width * 0.25,
//   decoration: BoxDecoration(
//     gradient: LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: <Color>[firstPurple, thirdPurple],
//     ),
//     borderRadius: BorderRadius.only(
//       topRight: Radius.circular(5),
//       bottomRight: Radius.circular(5),
//     ),
//   ),
//   child: InkWell(
//     onTap: () => sendMessage(chatRoomId: args),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Text(
//           "SEND",
//           style: TextStyle(color: Colors.white),
//         ),
//         Icon(Icons.send, color: Colors.white)
//       ],
//     ),
//   ),
// ),
