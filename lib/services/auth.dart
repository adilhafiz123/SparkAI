import 'package:firebase_auth/firebase_auth.dart';
import 'package:Spark/models/user.dart';
import 'package:Spark/services/profile_data.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFireBaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map((_userFromFireBaseUser));
  }
  // Sign in annon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  // Sign in with email + Password
  Future signinWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password); 
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    } 
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Register email + password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password); 
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData("NewMember", 0, "NewMemberProfession");
      return _userFromFireBaseUser(user);
    } 
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}