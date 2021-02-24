import 'package:fanua/constants/FadeAnimation.dart';
import 'package:fanua/constants/LoadingAnimation.dart';
import 'package:fanua/constants/colors.dart';
import 'package:fanua/onboarding/signin.dart';
import 'package:fanua/onboarding/welcome.dart';
import 'package:fanua/screens/home.dart';
import 'package:fanua/services/auth.dart';
import 'package:fanua/services/database.dart';
import 'package:fanua/services/helperfunctions.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  bool loading = false;
  bool secureText = true;

  signMeUp(){

    if(formKey.currentState.validate()){

      Map<String,String> userInfoMap = {
        "name" : userNameTextEditingController.text,
        "email" : emailTextEditingController.text
      };

      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);


      setState(() {
        loading = true;
      });

      authMethods.signUpWithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text).then((val){

        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false,
        );
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.grey[300],
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
                    SizedBox(height: 40),
                    FadeAnimation(
                        1,
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              color: blueText,
                              fontWeight: FontWeight.bold,
                              fontSize: 34),
                        )),
                    SizedBox(height: 35,),
                    Stack(
                        overflow: Overflow.visible,
                        children: [
                          Card(
                            color: Colors.grey[300],
                            //elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17)
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 15),
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
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                                child: Column(
                                  children: [
                                    FadeAnimation(1.1,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MaterialButton(
                                            onPressed: () async{
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50)
                                            ),
                                            child: Text('LOGIN', style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: secondaryText,
                                            ),),
                                          ),
                                          MaterialButton(
                                            onPressed: () async{

                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50)
                                            ),
                                            child: Text('SIGN UP', style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: blueText,
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
                                            right: MediaQuery.of(context).size.width / 6,
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
                                              Text('Full Name', style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: secondaryText
                                              ),),
                                              SizedBox(height: 7,),
                                              TextFormField(
                                                //style: TextStyle(color: Colors.white),
                                                //cursorColor: Colors.white,
                                                controller: userNameTextEditingController,
                                                validator: (val){
                                                  return val.isEmpty ? "Please provide your name" : null;
                                                },
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.person_outline, color: blueText,),
                                                  hintText: "Full Name",
                                                  hintStyle: TextStyle(color: Colors.grey[500].withOpacity(0.9)),
                                                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                      borderSide: BorderSide(color: Colors.grey[500].withOpacity(0.7))
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                      borderSide: BorderSide(color: Colors.grey[500].withOpacity(0.7))
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                            ],
                                          ),),
                                          FadeAnimation(1.4, Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('Email', style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: secondaryText
                                              ),),
                                              SizedBox(height: 7,),
                                              TextFormField(
                                                //style: TextStyle(color: Colors.white),
                                                //cursorColor: Colors.white,
                                                controller: emailTextEditingController,
                                                validator: (val){
                                                  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                                                  null : "Enter a valid email";
                                                },
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.email, color: blueText,),
                                                  hintText: "Email",
                                                  hintStyle: TextStyle(color: Colors.grey[500].withOpacity(0.9)),
                                                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                      borderSide: BorderSide(color: Colors.grey[500].withOpacity(0.7))
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                      borderSide: BorderSide(color: Colors.grey[500].withOpacity(0.7))
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                            ],
                                          ),),
                                          FadeAnimation(1.5, Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('Password', style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: secondaryText
                                              ),),
                                              SizedBox(height: 7,),
                                              TextFormField(
                                                //style: TextStyle(color: Colors.white),
                                                //cursorColor: Colors.white,
                                                controller: passwordTextEditingController,
                                                validator: (val) {
                                                  return val.length > 6 ? null : "Enter a password with 6+ characters";
                                                },
                                                obscureText: secureText,
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
                                                  hintStyle: TextStyle(color: Colors.grey[500].withOpacity(0.9)),
                                                  prefixIcon: Icon(Icons.lock_outline, color: blueText,),
                                                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                      borderSide: BorderSide(color: Colors.grey[500].withOpacity(.7))
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                      borderSide: BorderSide(color: Colors.grey[500].withOpacity(.7))
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 24,),
                                            ],
                                          ),),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 22,),
                                  ],
                                ),
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
                                child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width/1.5,
                                  height: 52,
                                  onPressed: () async{
                                    signMeUp();
                                  },
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Text("Sign Up", style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.grey[300],
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                    Expanded(
                        child: SizedBox(height: 180,)
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}

