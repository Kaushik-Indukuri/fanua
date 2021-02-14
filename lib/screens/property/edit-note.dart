import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanua/constants/FadeAnimation.dart';
import 'package:fanua/constants/background-painter.dart';
import 'package:fanua/constants/colors.dart';
import 'package:fanua/screens/property/property-detail.dart';
import 'package:fanua/services/helperfunctions.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {

  DocumentSnapshot docToEdit;
  final String addressCode;
  EditNote(this.docToEdit, this.addressCode);

  @override
  _EditNoteState createState() => _EditNoteState();
}

String _username = '';

class _EditNoteState extends State<EditNote> {

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
    money = TextEditingController(text: widget.docToEdit.data()["money"]);
    plan = TextEditingController(text: widget.docToEdit.data()["plan"]);
    experience = TextEditingController(text: widget.docToEdit.data()["experience"]);
    contact = TextEditingController(text: widget.docToEdit.data()["contact"]);
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
                              widget.docToEdit.reference.update({
                                'name': _username,
                                'money': money.text,
                                'plan': plan.text,
                                'experience': experience.text,
                                'contact': contact.text,
                                'address': widget.addressCode,
                              }).whenComplete(() => Navigator.pop(context));
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
                      Text("Interest Form", style: TextStyle(
                        color: Colors.white,
                        fontFamily: "OpenSansEB",
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),),
                      SizedBox(height: 15,),
                      Column(
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
                      SizedBox(height: 20,),
                      buildForm('Describe Your Plans for the Property', 'Your Plan...', 5, plan),
                      SizedBox(height: 20,),
                      buildForm('What is Your Real Estate Experience', 'Your Experience...', 3, experience),
                      SizedBox(height: 20,),
                      buildForm('List Your Contact Info', 'Contact Info...', 2, contact),
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
