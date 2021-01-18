import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanua/constants/colors.dart';
import 'package:fanua/onboarding/signin.dart';
import 'package:fanua/services/auth.dart';
import 'package:fanua/services/database.dart';
import 'package:fanua/services/helperfunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

String _username = "";

class _DashboardState extends State<Dashboard> {

  User user;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  String email = "";

  getUserInfo() async{
    _username = await HelperFunctions.getUserNameSharedPreference();
    setState(() {});
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
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkBackground,
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
                Text("Your Market Summary", style: TextStyle(
                  fontFamily: "OpenSans",
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w300
                )),
                MaterialButton(
                  color: secondaryBackground,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  onPressed: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("January", style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w300
                      )),
                      SizedBox(width: 10,),
                      Icon(Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 22,
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
              color: darkBackground,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        color: secondaryBackground,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 9,
                              right: 0,
                              child: RadiantGradientMask(
                                child: Icon(MdiIcons.dotsVertical,
                                  size: 33,
                                  color: Colors.white,),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: thirdBackground,
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: secondaryBackground,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 9,
                              right: 0,
                              child: RadiantGradientMask(
                                child: Icon(MdiIcons.dotsVertical,
                                  size: 33,
                                  color: Colors.white,),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: thirdBackground,
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: secondaryBackground,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 9,
                              right: 0,
                              child: RadiantGradientMask(
                                child: Icon(MdiIcons.dotsVertical,
                                size: 33,
                                color: Colors.white,),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: thirdBackground,
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
                                      color: Colors.white,
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