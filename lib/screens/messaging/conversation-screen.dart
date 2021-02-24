import 'package:fanua/constants/LoadingAnimation.dart';
import 'package:fanua/constants/colors.dart';
import 'package:fanua/services/constants.dart';
import 'package:fanua/services/database.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  Stream chatMessagesStream;

  Widget ChatMessageList(){
    return StreamBuilder(
      stream: chatMessagesStream,
        builder: (context, snapshot){
          if(snapshot.data == null) return Loading();
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return MessageTile(snapshot.data.documents[index].data()["message"],
                    snapshot.data.documents[index].data()["sendBy"] == Constants.myName
                );
              });
        },
    );
  }

  sendMessage() {
    if(messageController.text.isNotEmpty){
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy" : Constants.myName,
        "time" : DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((val){
      setState(() {
        chatMessagesStream = val;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width =  MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              child: Container(
                  margin: const EdgeInsets.only(left: 58),
                  child: Text('Messaging', style: TextStyle(
                    fontFamily: "OpenSans",
                      fontSize: 25,
                      fontWeight: FontWeight.w400
                  ),)),
            ),
            Icon(MdiIcons.messageReplyText, size: 35, color: blueText)
          ],
        ),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.grey[600],
        toolbarHeight: height/12,
      ),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                color: thirdBackground,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        decoration: InputDecoration(
                            hintText: "Message...",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(width: 16,),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: greyGradient,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.send, size: 17, color: Colors.white,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 55 : 12, right: isSendByMe ? 12 : 55),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: isSendByMe ? BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomLeft: Radius.circular(23)
          ) : BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23)
          ),
          gradient: isSendByMe ? blueMessage : greyMessage,
        ),
        child: Text(message, style: TextStyle(
          color: isSendByMe? Colors.white : Colors.black,
          fontSize: 18,
        ),),
      ),
    );
  }
}

