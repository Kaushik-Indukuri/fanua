import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';

class AuthMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User1 _userFromFirebaseUser(User user) {
    return user != null ? User1(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, password) async{

    try{
      UserCredential result = await _auth.signInWithEmailAndPassword
        (email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch(e){
      print(e.toString());
    }
  }


  Future signUpWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword
        (email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }


  Future resetPassword(String email) async{
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }


  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}