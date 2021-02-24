import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanua/constants/LoadingAnimation.dart';
import 'package:fanua/constants/background-painter.dart';
import 'package:fanua/constants/colors.dart';
import 'package:fanua/onboarding/signin.dart';
import 'package:fanua/screens/dashboard/similar-users.dart';
import 'package:fanua/services/auth.dart';
import 'package:fanua/services/database.dart';
import 'package:fanua/services/helperfunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'line-chart.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

String _username = "";

class _DashboardState extends State<Dashboard> {

  User user;
  bool loading = false;
  QuerySnapshot searchSnapshot;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  String email = "";

  getUserInfo() async{
    _username = await HelperFunctions.getUserNameSharedPreference();
    initiateSearch();
  }

  initiateSearch(){
    databaseMethods.getInterestNotes(_username)
        .then((val){
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget interestedProperty (index){
    return Container(
      padding: EdgeInsets.only(top: 25),
      height: 30,
      //color: Colors.redAccent,
      child: Column(
        children: [
          Text(searchSnapshot.docs[index].data()["address"], style: TextStyle(
            color: secondaryText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          Text("Investment: " + r"$"+searchSnapshot.docs[index].data()["money"], style: TextStyle(
            color: secondaryText,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),)
        ],
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width =  MediaQuery.of(context).size.width;

    return searchSnapshot == null  ? Loading() : Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[600],
        toolbarHeight: height/5.2,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome,", style: TextStyle(
                      fontFamily: "OpenSansLight",
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w300
                    )),
                    Text(_username, style: TextStyle(
                      fontFamily: "OpenSans",
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    )),
                  ],
                ),
                IconButton(
                  onPressed: (){
                    authMethods.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  icon: Icon(MdiIcons.logout, color: Colors.white, size: 23,),
                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Your Property Summary", style: TextStyle(
                  fontFamily: "OpenSans",
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w300
                )),
                MaterialButton(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SimilarUsers()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Network", style: TextStyle(
                          fontSize: 16,
                          color: secondaryText,
                          fontWeight: FontWeight.w400
                      )),
                      SizedBox(width: 10,),
                      RadiantGradientMask(
                        child: Icon(Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 22,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            //SizedBox(height: 25,)
          ],
        ),
      ),

      body: Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 28,
              color: Colors.grey[600],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        color: Colors.grey[300],
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)
                        ),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: (){},
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: RadiantGradientMask(
                                          child: Icon(MdiIcons.currencyUsd, size: 37,
                                          color: Colors.white,)
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text("Cash Flow", style: TextStyle(
                                        fontSize: 16,
                                        color: secondaryText,
                                        fontWeight: FontWeight.w500
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.grey[300],
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)
                        ),
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: RadiantGradientMask(
                                        child: Icon(MdiIcons.percent, size: 30,
                                        color: Colors.white,)
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text("Break Even", style: TextStyle(
                                      fontSize: 16,
                                      color: secondaryText,
                                      fontWeight: FontWeight.w500
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.grey[300],
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)
                        ),
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: RadiantGradientMask(
                                        child: Icon(Icons.calculate_outlined, size: 37,
                                        color: Colors.white,)
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(" Financing ", style: TextStyle(
                                      fontSize: 16,
                                      color: secondaryText,
                                      fontWeight: FontWeight.w500
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 11, top: 10, bottom: 8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Your Interested Properties", style: TextStyle(
                        fontFamily: "OpenSans",
                        color: paletteBlue,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.grey[300],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)
                    ),
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(17),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[500],
                                offset: Offset(4.0, 4.0),
                                blurRadius: 15.0,
                                spreadRadius: 1.0),
                            BoxShadow(
                                color: Colors.white,
                                offset: Offset(-4.0, -4.0),
                                blurRadius: 15.0,
                                spreadRadius: 1.0),
                          ],
                        ),
                        height: 125,
                        child: Stack(
                          overflow: Overflow.clip,
                          children: [
                            Positioned(
                              top: 12,
                              left: 12,
                              child: RadiantGradientMask(
                                child: Icon(MdiIcons.chevronUp,
                                  size: 28,
                                  color: Colors.white,),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              left: 12,
                              child: RadiantGradientMask(
                                child: Icon(MdiIcons.chevronDown,
                                  size: 28,
                                  color: Colors.white,),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 9,
                              child: RadiantGradientMask(
                                child: Icon(MdiIcons.dotsVertical,
                                  size: 33,
                                  color: Colors.white,),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: searchSnapshot.docs.length != 0 ? ListWheelScrollView(
                                itemExtent: 100,
                                diameterRatio: 1.75,
                                children: List.generate(searchSnapshot.docs.length, (index) =>
                                    interestedProperty(index),
                                ),
                              ) :
                                  Text("Currently No Interested Properties", style: TextStyle(
                                    color: secondaryText,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 11, top: 20, bottom: 8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nearby Housing Trends", style: TextStyle(
                            fontFamily: "OpenSans",
                            color: paletteBlue,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.grey[300],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[500],
                              offset: Offset(4.0, 4.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0),
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(-4.0, -4.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0, right: 3.0, top: 8.0),
                        child: LineChartSample2(),
                      ),
                    ),
                  ),
                  SizedBox(height: 75,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Color(0xFF34ae97), Color(0xFF2986a4)],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}