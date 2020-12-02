import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onion/statemanagment/ChatManagement/Constants.dart';
import 'package:provider/provider.dart';
import '../statemanagment/ChatManagement/database.dart';

import '../const/Size.dart';
import '../const/color.dart';
import '../widgets/AnalysisWidget/MyAlert.dart';
import '../widgets/MyLittleAppbar.dart';

import '../const/values.dart';

class ProjectChat extends StatefulWidget {
  static const routeName = "project_chat";

  @override
  _ProjectChatState createState() => _ProjectChatState();
}

class _ProjectChatState extends State<ProjectChat> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final TextEditingController sendTxt = new TextEditingController();
  String args;
  Future<void> myFuture;
  var _tapPosition;

  sendMessage({String chatRoomId}) async {
    print("Mahdi sendMessage1");
    if (sendTxt.text.isEmpty || Constants.myName == null) {
      return;
    }
    Map<String, String> messageMap = {
      "message": sendTxt.text,
      "sendBy": Constants.myName,
      "time": DateTime.now().millisecondsSinceEpoch.toString(),
    };

    await RealtimeData().createData(message: messageMap);
    sendTxt.text = "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context).settings.arguments;
      myFuture = Provider.of<RealtimeData>(context, listen: false).newValue();
    });
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  showMyPopUp(BuildContext context, String key) async {
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
    print("Mahdi showMyPopUp $value");
    final myFutureTemp = Provider.of<RealtimeData>(context, listen: false);
    if (value == 0) {
      myFutureTemp.deleteValue(key);
    } else if (value == 1) {

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
                        return ListView.builder(
                          itemCount: value.message.length,
                          itemBuilder: (ctx, index) {
                            String key = value.message.keys.elementAt(index);
                            String getPreviuosdate = "";
                            if (index > 0) {
                              String previouskey = value.message.keys.elementAt(
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
                            String chatDate =
                                date.substring(0, date.indexOf(" ")) !=
                                        getPreviuosdate
                                    ? date.substring(0, date.indexOf(" "))
                                    : "";
                            return GestureDetector(
                              onTapDown: _storePosition,
                              onTap: () => showMyPopUp(context, key),
                              child: MyChatItems(
                                isMe: value.message[key]["owner"] ==
                                    Constants.myName,
                                message: "${value.message[key]["message"]}",
                                date: "$chatDate",
                                hour:
                                    "${date.substring(date.indexOf(" "), date.lastIndexOf(":"))}",
                              ),
                            );
                          },
                        );
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
              children: [
                Expanded(
                  child: SizedBox(
                    height: deviceSize(context).height * 0.05,
                    child: TextField(
                      controller: sendTxt,
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
                          left: deviceSize(context).width * 0.02,
                        ),
                        fillColor: grey,
                        hintText: "Type your message",
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: deviceSize(context).width * 0.25,
                  height: deviceSize(context).height * 0.05,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[firstPurple, thirdPurple],
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: InkWell(
                    onTap: () => sendMessage(chatRoomId: args),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "SEND",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(Icons.send, color: Colors.white)
                      ],
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

class MyChatItems extends StatelessWidget {
  final bool isMe;
  final String message;
  final String date;
  final String hour;

  const MyChatItems({
    Key key,
    @required this.isMe,
    this.message,
    this.date,
    this.hour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        children: [
          SizedBox(height: deviceSize(context).height * 0.04),
          date.isNotEmpty ? Text("$date") : SizedBox.shrink(),
          date.isNotEmpty
              ? SizedBox(height: deviceSize(context).height * 0.02)
              : SizedBox.shrink(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: deviceSize(context).height * 0.08,
                width: deviceSize(context).height * 0.08,
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/empty_profile.jpg"),
                ),
              ),
              SizedBox(width: deviceSize(context).width * 0.02),
              Container(
                decoration: BoxDecoration(
                  color: isMe ? greyBlue : grey,
                  borderRadius: BorderRadius.only(
                    topRight: isMe ? Radius.circular(0) : Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topLeft: !isMe ? Radius.circular(0) : Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: deviceSize(context).width * 0.03,
                        right: deviceSize(context).width * 0.03,
                        top: deviceSize(context).height * 0.03,
                        bottom: deviceSize(context).width * 0.02,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: deviceSize(context).height * 0.01,
                          maxHeight: deviceSize(context).height,
                          minWidth: deviceSize(context).width * 0.02,
                          maxWidth: deviceSize(context).width * 0.7,
                        ),
                        child: AutoSizeText(
                          message == null ? loremIpsum : message,
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.1,
                          maxLines: 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: deviceSize(context).width * 0.01,
                        right: deviceSize(context).width * 0.02,
                        bottom: deviceSize(context).width * 0.02,
                      ),
                      child: Text(
                        "$hour",
                        textAlign: TextAlign.end,
                        textScaleFactor: 0.9,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
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
