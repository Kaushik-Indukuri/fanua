import 'package:fanua/constants/FadeAnimation.dart';
import 'package:fanua/constants/colors.dart';
import 'package:fanua/screens/messaging/search-users.dart';
import 'package:fanua/services/constants.dart';
import 'package:fanua/services/database.dart';
import 'package:fanua/services/helperfunctions.dart';
import 'package:flutter/material.dart';
import '../home.dart';
import 'conversation-screen.dart';

class Chatroom extends StatefulWidget {
  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomsStream;

  Widget chatroomList(){
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return ChatRoomTile(
              snapshot.data.documents[index].data()["chatRoomId"]
                  .toString().replaceAll("_", "")
                  .replaceAll(Constants.myName, ""),
                snapshot.data.documents[index].data()["chatRoomId"]
            );
          }) : Container();
      },
    );
  }

  getRecipientInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    databaseMethods.getChatRooms(Constants.myName).then((val){
      setState(() {
        chatRoomsStream = val;
      });
    });
    setState(() {});
  }

  @override void initState() {
    getRecipientInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width =  MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                  margin: const EdgeInsets.only(left: 85),
                  child: Text('Chats', style: TextStyle(
                    fontFamily: "OpenSans",
                      fontSize: 26,
                      fontWeight: FontWeight.w400
                  ),)),
            ),
            Image.asset(
              'assets/fanua-logo.png',
              fit: BoxFit.contain,
              height: 35,
            ),
          ],
        ),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: secondaryBackground,
        toolbarHeight: height/10.5,
      ),

      body: chatroomList(),

      floatingActionButton: Container(
          height: MediaQuery.of(context).size.width/6.3,
          width: MediaQuery.of(context).size.width/6.3,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                blurRadius: 3,
                offset: Offset(0,1),
              )],
              gradient: buttonGradient,
              borderRadius: BorderRadius.circular(50)
          ),
          child: FloatingActionButton(
              elevation: 0.0,
              child: Icon(Icons.search, color: secondaryBackground, size: 32),
              backgroundColor: Colors.transparent,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchUsers()));
              }
          ),
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationScreen(chatRoomId)));
      },
      child: Container(
        padding: EdgeInsets.only(left: 22, right: 22, top: 22),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: gradientGreen,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text("${userName.substring(0,1).toUpperCase()}", style:
                    TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )),
                ),
                SizedBox(width: 15,),
                Text(userName, style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),),
              ],
            ),
            SizedBox(height: 22,),
            Container(
              height: 1,
              color: secondaryText,
            )
          ],
        ),
      ),
    );
  }
}

