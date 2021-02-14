import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanua/constants/FadeAnimation.dart';
import 'package:fanua/constants/background-painter.dart';
import 'package:fanua/constants/colors.dart';
import 'package:fanua/screens/property/property-detail.dart';
import 'package:fanua/services/helperfunctions.dart';
import 'package:flutter/material.dart';

String _username = '';

class UserInterest extends StatefulWidget {
  final String addressCode;
  UserInterest(this.addressCode);

  @override
  _UserInterestState createState() => _UserInterestState();
}

class _UserInterestState extends State<UserInterest> {

  TextEditingController money = new TextEditingController();
  TextEditingController plan = new TextEditingController();
  TextEditingController experience = new TextEditingController();
  TextEditingController contact = new TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SafeArea(
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SafeArea(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            border: Border.all(
                              width: 1.5,
                              color: blueText,
                            )
                        ),
                        child: Center(
                          child: MaterialButton(
                            onPressed: () {
                              ref.add({
                                'name': _username,
                                'money': money.text,
                                'plan': plan.text,
                                'experience': experience.text,
                                'contact': contact.text,
                                'address': widget.addressCode,
                              }).whenComplete(() => Navigator.pop(context));
                              setState(() {});
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text('Save', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: blueText,
                            ),),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 17, right: 17),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      FadeAnimation(0.9, Text("Interest Form", style: TextStyle(
                          color: Colors.white,
                          fontFamily: "OpenSansEB",
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),),
                      ),
                      SizedBox(height: 15,),
                      FadeAnimation(1, Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Investment Amount', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.75),
                            ),),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Icon(Icons.attach_money, size: 25, color: Colors.white.withOpacity(.7),),
                                SizedBox(width: 4,),
                                Container(
                                  width: size.width*0.835,
                                  child: TextFormField(
                                    controller: money,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                      hintText: "Amount",
                                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.white.withOpacity(.7), width: 2)
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.white.withOpacity(.7), width: 2)
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      FadeAnimation(1.1, buildForm('Describe Your Plans for the Property', 'Your Plan...', 5, plan)),
                      SizedBox(height: 20,),
                      FadeAnimation(1.2, buildForm('What is Your Real Estate Experience', 'Your Experience...', 3, experience)),
                      SizedBox(height: 20,),
                      FadeAnimation(1.3, buildForm('List Your Contact Info', 'Phone number, Email, Portfolio, etc...', 2, contact)),
                      SizedBox(height: 25,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildForm(String title, String hint, int lines, TextEditingController controller){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white.withOpacity(0.75),
        ),),
        SizedBox(height: 8,),
        TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          maxLines: lines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white.withOpacity(.7), width: 2)
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white.withOpacity(.7), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
