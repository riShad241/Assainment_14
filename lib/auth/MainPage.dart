import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/auth/Auth_page.dart';
import 'package:flutter_firebase_practice/pages/homePage.dart';
import 'package:flutter_firebase_practice/pages/login.dart';

/// This page mainly use kora hoi se jodi app er sign in kore tahole bar bar sing
/// in page e  na jawer jonnoo direct mainpage er jawer jonno.
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            return HomePage();
          }else{
            return AuthPage();
          }
        },)
    );
  }
}
