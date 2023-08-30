import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/pages/login.dart';

import '../pages/register_page.dart';
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  /// intially show the login page

  bool showLoginPage = true;

  void togglescreen(){
    setState(() {
      showLoginPage =!showLoginPage;
    });
}
  @override
  Widget build(BuildContext context) {
    if(showLoginPage ){
      return LogIn(showRegisterPage:togglescreen );
    }else{
      return RegisterPage(ShowLogInPage: togglescreen);
    }
  }
}
