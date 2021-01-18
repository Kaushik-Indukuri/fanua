import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanua/constants/FadeAnimation.dart';
import 'package:fanua/constants/LoadingAnimation.dart';
import 'package:fanua/constants/colors.dart';
import 'package:fanua/onboarding/signup.dart';
import 'package:fanua/onboarding/welcome.dart';
import 'package:fanua/screens/home.dart';
import 'package:fanua/services/auth.dart';
import 'package:fanua/services/database.dart';
import 'package:fanua/services/helperfunctions.dart';
import 'package:flutter/material.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  QuerySnapshot snapshotUserInfo;

  signMeIn() async{

    if(formKey.currentState.validate()){
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);

      databaseMethods.getUserByEmail(emailTextEditingController.text)
          .then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo.docs[0].data()["name"]);
        print("${snapshotUserInfo.docs[0].data()["name"]}");
      });

      setState(() {
        loading = true;
      });

      authMethods.signInWithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text).then((val) {
        if (val != null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);
        }
      });

      dynamic result = await authMethods.signInWithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text);

      if(result == null){
        setState(() {
          error = 'Your email or password seems to be incorrect';
          loading = false;
        });
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
        print('signed in');
      }
    }
  }

  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  bool loading = false;
  bool secureText = true;

  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: background,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome()));
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: secondaryText),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FadeAnimation(1, Container(
                      height: MediaQuery.of(context).size.height / 6,
                      //margin: EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        //color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage('assets/fanua-logo.png')
                          )
                      ),
                    )),
                    Stack(
                      overflow: Overflow.visible,
                      children: [
                        Card(
                        color: secondaryBackground,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17)
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          child: Column(
                            children: [
                              FadeAnimation(1.1,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MaterialButton(
                                      onPressed: () async{},
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Text('LOGIN', style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: blueText,
                                      ),),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Text('SIGN UP', style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: secondaryText,
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                              FadeAnimation(1.2,
                                 Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 25),
                                      height: 2,
                                      color: Colors.grey[400].withOpacity(0.3),
                                    ),
                                    Positioned(
                                      left: MediaQuery.of(context).size.width / 7.25,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 25),
                                        height: 3,
                                        width: 50,
                                        color: blueText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //login
                              Form(
                                key: formKey,
                                child: Column(
                                  children: <Widget>[
                                    FadeAnimation(1.3, Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Email', style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: secondaryText
                                        ),),
                                        SizedBox(height: 7,),
                                        TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          cursorColor: Colors.white,
                                          controller: emailTextEditingController,
                                          obscureText: false,
                                          validator: (val){
                                            return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                                            null : "Enter a valid email";
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.email, color: blueText,),
                                            hintText: "Email",
                                            hintStyle: TextStyle(color: Colors.grey[400].withOpacity(0.3)),
                                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(50),
                                                borderSide: BorderSide(color: Colors.grey[400].withOpacity(0.3))
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(50),
                                                borderSide: BorderSide(color: Colors.grey[400].withOpacity(0.3))
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                      ],
                                    ),),
                                    FadeAnimation(1.4, Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Password', style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: secondaryText
                                        ),),
                                        SizedBox(height: 7,),
                                        TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          cursorColor: Colors.white,
                                          controller: passwordTextEditingController,
                                          obscureText: secureText,
                                          validator: (val) {
                                            return val.length > 6 ? null : "Enter a password with 6+ characters";
                                          },
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: (){
                                                 setState(() {
                                                   secureText = !secureText;
                                                 });
                                              },
                                              icon: Icon(
                                                secureText ? Icons.visibility_off : Icons.visibility, color: secondaryText.withOpacity(0.5)
                                              ),
                                            ),
                                            hintText: "Password",
                                            hintStyle: TextStyle(color: Colors.grey[400].withOpacity(0.3)),
                                            prefixIcon: Icon(Icons.lock_outline, color: blueText,),
                                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(50),
                                                borderSide: BorderSide(color: Colors.grey[400].withOpacity(.3))
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(50),
                                                borderSide: BorderSide(color: Colors.grey[400].withOpacity(.3))
                                            ),
                                          ),
                                        ),
                                        //SizedBox(height: 2,),
                                      ],
                                    ),),
                                  ],
                                ),
                              ),

                              //forgot you pwd
                              FadeAnimation(1.5,
                                Container(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: MaterialButton(
                                      onPressed: () async{

                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Text('Forgot your password?', style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: secondaryText,
                                      ),),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 24,),
                            ],
                          ),
                        ),
                      ),

                       Positioned(
                          left: MediaQuery.of(context).size.width/6,
                          bottom: -25,
                          child: FadeAnimation(1.6,
                            Container(
                              decoration: BoxDecoration(
                                gradient: primaryGradient,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width/1.5,
                                height: 52,
                                onPressed: () async{
                                  signMeIn();
                                },
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Text("Login", style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                ),),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ),
                  ],
                ),
              ),
              FadeAnimation(1.7, Text(error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15.0,
                ),),
              ),
              SizedBox(height: 120,)
            ],
          ),
        ),
      ),
    );
  }
}

