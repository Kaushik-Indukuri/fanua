import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanua/constants/colors.dart';
import 'package:fanua/services/constants.dart';
import 'package:fanua/services/database.dart';
import 'package:fanua/services/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'conversation-screen.dart';

class SearchUsers extends StatefulWidget {
  @override
  _SearchUsersState createState() => _SearchUsersState();
}

String _myName;

class _SearchUsersState extends State<SearchUsers> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot;

  initiateSearch(){
    databaseMethods.getUserByUsername(searchTextEditingController.text)
        .then((val){
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return SearchTile(
            userName: searchSnapshot.docs[index].data()["name"],
            userEmail: searchSnapshot.docs[index].data()["email"],
          );
        }
    ) : Container();
  }

  /// create chatroom, send user to conversation screen
  createRoomAndStartConversation(String userName){

    if(userName != Constants.myName){
      String chatRoomId = getChatRoomId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];

      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId" : chatRoomId,
      };

      databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ConversationScreen(chatRoomId)));
    } else{
      print("You can't send a message to yourself");
    }
  }

  Widget SearchTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName, style: TextStyle(
                    color: secondaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  )),
                  Text(userEmail, style: TextStyle(
                    color: secondaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  )),
                ],
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  gradient: primaryGradient,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: MaterialButton(
                  onPressed: (){
                    createRoomAndStartConversation(userName);
                  },
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60)
                  ),
                  child: Text("Message", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            height: 1,
            color: secondaryText.withOpacity(0.6),
          )
        ],
      ),
    );
  }

  getUserInfo() async{
    _myName = await HelperFunctions.getUserNameSharedPreference();
    setState(() {});
  }

  @override void initState() {
    getUserInfo();
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
              alignment: Alignment.topRight,
              child: Container(
                  margin: const EdgeInsets.only(left: 85),
                  child: Text('Chats', style: TextStyle(
                    fontFamily: "OpenSans",
                      fontSize: 26,
                      fontWeight: FontWeight.w400
                  ),)),
            ),
            Icon(MdiIcons.accountCircleOutline, size: 37, color: blueText,),
          ],
        ),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.grey[600],
        toolbarHeight: height/10.5,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              color: thirdBackground,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                          hintText: "search username...",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            gradient: greyGradient,
                            borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.search, size: 23, color: Colors.white,)),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
