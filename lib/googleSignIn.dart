import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ifeel/homepage.dart';

class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn=GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogin(context) async{
    final googleUser = await googleSignIn.signIn();
    if(googleUser==null)return;
    _user=googleUser;
    final googleAuth=await googleUser.authentication;
    final credential=GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
    CircularProgressIndicator();
    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (BuildContext context){
      return homepage();
    }), (route) => false);
  }
}