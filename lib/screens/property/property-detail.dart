import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanua/constants/FadeAnimation.dart';
import 'package:fanua/constants/colors.dart';
import 'package:fanua/screens/messaging/search-users.dart';
import 'package:fanua/screens/property/user-interest.dart';
import 'package:fanua/services/constants.dart';
import 'package:fanua/services/database.dart';
import 'package:fanua/services/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'edit-note.dart';

class Detail extends StatefulWidget {
  final String image;
  final String address;
  final int beds;
  final int baths;
  final int lotSize;
  final String city;
  final String state;
  final int buildingSize;
  final bool openHouse;
  final int bathsFull;
  final String officeName;
  final String agentName;
  Detail(
      this.image,
      this.address,
      this.beds,
      this.baths,
      this.lotSize,
      this.city,
      this.state,
      this.buildingSize,
      this.openHouse,
      this.bathsFull,
      this.officeName,
      this.agentName);

  @override
  _DetailState createState() => _DetailState();
}

String _username = '';

class _DetailState extends State<Detail> {

  QuerySnapshot searchSnapshot;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool showUsers = false;

  initiateSearch(){
    databaseMethods.getNotes(widget.address)
        .then((val){
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  getUserInfo() async{
    _username = await HelperFunctions.getUserNameSharedPreference();
    setState(() {});
  }

  Widget userList(){
    return searchSnapshot.docs.length != 0 ? ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: searchSnapshot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return UserTile(
            username: searchSnapshot.docs[index].data()["name"],
            money: searchSnapshot.docs[index].data()["money"],
            plan: searchSnapshot.docs[index].data()["plan"],
            experience: searchSnapshot.docs[index].data()["experience"],
            contact: searchSnapshot.docs[index].data()["contact"],
            index: index,
          );
        }
    ) :
    Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,),
        child: ListView(
          children: [
            Text("No One is Currently Interested in this Property", style: TextStyle(
              color: secondaryText,
              fontSize:17,
            ),),
          ],
        ),
      ),
    );
  }

  Widget UserTile({String username, String money, String plan, String experience, String contact, int index}){
    return Container(
      margin: EdgeInsets.only(left: 17, right: 17, bottom: 20),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(15.0),
        border: Border.all(width: 1.5, color: blueText),
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.6),
          blurRadius: 15,
          offset: Offset(0,8),
        )],
      ),
      child: ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(username, style: TextStyle(
              fontFamily: "OpenSans",
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 20,
            ),),
            SizedBox(height: 7,),
            Text("Desired Investment:  "+r"$" + money, style: TextStyle(
              fontFamily: "OpenSans",
                color: Colors.white,
                fontSize: 16,
            ),),
          ],
        ),
        trailing: Icon(Icons.arrow_drop_down, color: Colors.white,),
        expandedCrossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, bottom: 3, right: 16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Plan: " + plan, style: TextStyle(
                  fontFamily: "OpenSans",
                    color: Colors.white,
                    fontSize: 16,
                ),),
                SizedBox(height: 5,),
                Text("Experience: " + experience, style: TextStyle(
                  fontFamily: "OpenSans",
                    color: Colors.white,
                    fontSize: 16,
                ),),
                SizedBox(height: 5,),
                Text("Contact Info: " + contact, style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.white,
                    fontSize: 16,
                ),),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    username == _username ? Container(
                      height: 40,
                      width: 100,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditNote(searchSnapshot.docs[index], widget.address)));
                        },
                        child: Text("Edit Note", style: TextStyle(
                          fontSize: 16,
                          color: gradientGreen,
                        ),),
                      ),
                    ): Container(),

                    username == _username ? Container(
                      height: 40,
                      width: 100,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        onPressed: (){
                          searchSnapshot.docs[index].reference.delete();
                          initiateSearch();
                        },
                        child: Text("Delete", style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFff6961),
                        ),),
                      ),
                    ) : ExpansionButton("Message", gradientGreen),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override void initState() {
    initiateSearch();
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.image,
            child: Container(
              height: size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 48,
            left: 26,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.3225,
            left: 25,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11, vertical:7),
              decoration: BoxDecoration(
                color: thirdBackground.withOpacity(0.9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text("FOR SALE", style: TextStyle(
                  fontSize: 17,
                  color: blueText,
                  fontWeight: FontWeight.bold
              )),
            ),
          ),
          Positioned(
            top: size.height * 0.3225,
            right: 25,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11, vertical:7),
              decoration: BoxDecoration(
                color: widget.openHouse ? Color(0xFFe0ffe0).withOpacity(0.9) : Color(0xFFffc4c4).withOpacity(0.9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text("OPEN HOUSE", style: TextStyle(
                  fontSize: 17,
                  color: widget.openHouse ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold
              )),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.62,
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: showUsers ? userInterest() : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FadeAnimation(0.6, Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.address, style: TextStyle(
                                color: Colors.white,
                                fontSize: 27.5,
                                fontWeight: FontWeight.bold,
                              ),),
                              Row(
                                children: [
                                  Icon(MdiIcons.mapMarkerOutline, color: blueText, size: 18,),
                                  Text("${widget.city}" + "," + " ${widget.state}", style: TextStyle(
                                    color: secondaryText,
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              color: Colors.blue[100].withOpacity(0.175),
                              shape: BoxShape.circle
                          ),
                          child: IconButton(
                              onPressed: (){
                                setState(() {
                                  showUsers = true;
                                });
                              },
                              icon: Icon(MdiIcons.accountSupervisor, color: blueText, size: 27,)
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeAnimation(0.7, Padding(
                      padding: EdgeInsets.only(right: 24, left: 24, bottom: 24,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          buildFeature(MdiIcons.bedKingOutline, "${widget.beds}" + " Bedroom"),
                          buildFeature(MdiIcons.shower, "${widget.baths}" + " Bathroom"),
                          buildFeature(MdiIcons.officeBuilding, "${widget.buildingSize}" + " sqft"),
                          buildFeature(MdiIcons.arrowExpandAll, "${widget.lotSize}" + " sqft"),

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 2, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation(0.8, Text("Description", style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                        SizedBox(height: 6,),
                        FadeAnimation(0.9, Text("This property has "+"${widget.baths}"+" bathrooms, "+"${widget.bathsFull}"+" being full sized bathrooms. "
                              "The building size is "+"${widget.buildingSize}"+" sqft with "+"${widget.beds}"+" bedrooms. "
                              "The lot size is "+"${widget.lotSize}"+" sqft.",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              color: secondaryText,
                              fontSize: 15.5,
                            ),),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 20,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeAnimation(1, Text("Listing Office", style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                            SizedBox(height: 1,),
                            FadeAnimation(1.1, SizedBox(
                                width: 180,
                                child: Text(widget.officeName,
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: secondaryText,
                                    fontSize: 14.5,
                                  ),),
                              ),
                            ),
                            SizedBox(height: 15,),
                            FadeAnimation(1.2, Text("Agent", style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                            SizedBox(height: 1,),
                            FadeAnimation(1.3, SizedBox(
                              width: 180,
                              child: Text(widget.agentName,
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: secondaryText,
                                    fontSize: 14.5,
                                  ),),
                            ),
                            ),
                          ],
                        ),
                      ),
                      FadeAnimation(1.175, Container(
                          margin: EdgeInsets.only(right: 25, top: 22),
                          height: 135,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage('assets/property-map.png'),
                              fit: BoxFit.cover
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFeature(IconData iconData, String text){
    return Column(
      children: [

        Icon(
          iconData,
          color: blueText,
          size: 28,
        ),

        SizedBox(
          height: 8,
        ),

        Text(
          text,
          style: TextStyle(
            color: secondaryText,
            fontSize: 14,
          ),
        ),

      ],
    );
  }


  Widget userInterest(){
    Size size = MediaQuery.of(context).size;
    String addressCode = widget.address;

    return Stack(
      children: [
        Container(
          height: size.height*0.51,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeAnimation(0.8, Text("Property Interest", style: TextStyle(
                      color: Colors.white,
                      fontSize: 27.5,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: Colors.blue[100].withOpacity(0.175),
                        shape: BoxShape.circle
                    ),
                    child: IconButton(
                        onPressed: (){
                          setState(() {
                            showUsers = false;
                          });
                        },
                        icon: Icon(MdiIcons.accountSupervisor, color: blueText, size: 27,)
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: FadeAnimation(0.9, RefreshIndicator(
                onRefresh: (){
                  initiateSearch();
                  return Future.value(false);
                },
                child: userList()))
            ),
          ],
        ),
        Positioned(
          right: 12,
          bottom: 12,
          child: FadeAnimation(1, Container(
            height: MediaQuery.of(context).size.width/6.5,
            width: MediaQuery.of(context).size.width/6.5,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  blurRadius: 10,
                  offset: Offset(0,3),
                )],
                gradient: buttonGradient,
                borderRadius: BorderRadius.circular(50)
            ),
            child: FloatingActionButton(
                elevation: 0.0,
                child: Icon(MdiIcons.plusBoxMultipleOutline, color: secondaryBackground, size: 32),
                backgroundColor: Colors.transparent,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserInterest(addressCode)));
                }
            ),
          ),
          ),
        ),
      ],
    );
  }

  Widget ExpansionButton(String title, Color color){
    return Container(
      height: 40,
      width: 100,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchUsers()));
        },
        child: Text(title, style: TextStyle(
          fontSize: 16,
          color: color,
        ),),
      ),
    );
  }
}
