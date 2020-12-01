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
  Stream chatMessagesStream;

  Widget chatMessageList() {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.error != null) {
            return Center(child: Text("Error Occurred!"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              reverse: true,
              itemBuilder: (streamCtx, index) {
                return MyChatItems(
                  isMe: true,
                  message: snapshot.data.documents[index]["message"],
                );
              },
            );
          }
        }
      },
    );
  }

  sendMessage({String chatRoomId}) {
    print("Mahdi sendMessage1");
    if (sendTxt.text.isEmpty) {
      return;
    }
    Map<String, String> messageMap = {
      "message": sendTxt.text,
      "sendBy": Constants.myName,
      "time": DateTime.now().millisecondsSinceEpoch.toString(),
    };
    databaseMethods.addConversationMessages(
      chatRoomId: chatRoomId,
      messageMap: messageMap,
    );
    sendTxt.text = "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context).settings.arguments;

      databaseMethods.getConversationMessages(chatRoomId: args).then((val) {
        setState(() {
          chatMessagesStream = val;
        });
      });
    });
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
            // height: deviceSize(context).height * 0.75,
            child: chatMessageList(),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Text(
                          "SEND",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () => sendMessage(chatRoomId: args),
                      ),
                      Icon(Icons.send, color: Colors.white)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: MyBottomNavigation(),
    );
  }
}

class MyChatItems extends StatelessWidget {
  final bool isMe;
  final String message;

  const MyChatItems({
    Key key,
    @required this.isMe,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        children: [
          SizedBox(height: deviceSize(context).height * 0.04),
          Text("Monday, 25 Sep"),
          SizedBox(height: deviceSize(context).height * 0.02),
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
              Expanded(
                child: Container(
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
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                            minHeight: deviceSize(context).height * 0.1,
                            maxHeight: deviceSize(context).height,
                            minWidth: deviceSize(context).width * 0.6,
                            maxWidth: deviceSize(context).width * 0.7,
                          ),
                          child: AutoSizeText(
                            message == null ? loremIpsum : message,
                            textDirection: TextDirection.ltr,
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
                          "06:45",
                          textAlign: TextAlign.end,
                          textScaleFactor: 0.9,
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
