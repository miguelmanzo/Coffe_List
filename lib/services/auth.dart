import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_flutter_app2/models/user.dart';

import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create a user objecgt
  User _userFromFireBase(FirebaseUser user){
    return user != null ? User(uid:  user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map(_userFromFireBase);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      print('Got anon user');
      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password

  Future signInWithEmailAndPassword (String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(password: password, email: email);
      FirebaseUser user = result.user;


      print(email +" "+ password);
      return _userFromFireBase(user);
    } catch (e) {
      print(e);
    }
  }

  //register with email and password

  Future registerWithEmailAndPassword (String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(password: password, email: email);
      FirebaseUser user = result.user;

      print('User auth: ' + user.toString());
      print('User auth uid: ' + user.uid);

      //create a new database entry for the user uid
      await DatabaseService(uid : user.uid).updateUserData('0', 'New Crew Member', 100);

      return _userFromFireBase(user);
    } catch (e) {
      print(e);
    }
  }

  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }

  }

}
