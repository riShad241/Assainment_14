import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/pages/homePage.dart';
import 'package:flutter_firebase_practice/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';
class RegisterPage extends StatefulWidget {
  final VoidCallback ShowLogInPage;
  const RegisterPage({Key? key, required this.ShowLogInPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _ConfpasswordController = TextEditingController();
  TextEditingController _FirstNameController = TextEditingController();
  TextEditingController _LastNameController = TextEditingController();
  TextEditingController _AgeController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _FirstNameController.dispose();
    _LastNameController.dispose();
    _AgeController.dispose();
    super.dispose();
  }
  Future <void> SingUp()async{
    try {
      ///Circullar indecatter add in here
      showDialog(context: context, builder: (context){
        return Center(child: CircularProgressIndicator(),);
      });
      if (confirmpassword()) {
        ///create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Navigator.of(context).pop();
        /// add user details
         addUserDetails(
             _FirstNameController.text.trim(),
             _LastNameController.text.trim(),
             _emailController.text.trim(),
             int.parse(_AgeController.text.trim()));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const HomePage()),(route) => false,);
        if (mounted) {
          setState(() {
            _emailController.clear();
            _passwordController.clear();
            _ConfpasswordController.clear();
          });
        }
      }
    }
    catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This Email already register')));
    }

  }
  Future addUserDetails(String fstName, String lstName, String email, int age)async{
    await FirebaseFirestore.instance.collection('User').add({
      'first Name': fstName,
      'last Name': lstName,
      'email': email,
      'age': age,
    });
  }
  bool confirmpassword(){
    if(_passwordController.text.trim() == _ConfpasswordController.text.trim()){
      return true;
    }else{
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(
                  height: 100,
                ),
                /// Application some text in here
                Center(
                  child: Text('Hello There!',
                      style: GoogleFonts.bebasNeue(fontSize: 52)),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: const Text(
                    'Register below with your details',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                /// FirstName textfield in here..
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child:  TextFormField(
                        validator: (String? value){
                          if(value?.isEmpty ?? true){
                            return 'Enter First Name';
                          }
                          return null;
                        },
                        controller: _FirstNameController,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'First Name'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                /// Last Name textfield in here..
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child:  TextFormField(
                        validator: (String? value){
                          if(value?.isEmpty ?? true){
                            return 'Enter Last Name';
                          }
                          return null;
                        },
                        controller: _LastNameController,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Last Name'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                /// Age textfield in here..
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child:  TextFormField(
                        validator: (String? value){
                          if(value?.isEmpty ?? true){
                            return 'Enter Your Age';
                          }
                          return null;
                        },
                        controller: _AgeController,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Age'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                /// Email textfield in here..
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child:  TextFormField(
                        validator: (String? value){
                          if(value?.isEmpty ?? true){
                            return 'Enter email';
                          }
                          return null;
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Email'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                /// Password Textfield in here..
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child:  TextFormField(
                        validator: (String? value){
                          if(value?.isEmpty ?? true){
                            return 'Enter password';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Password'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                ///Confirm password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child:  TextFormField(
                        validator: (String? value){
                          if(value?.isEmpty ?? true){
                            return 'Enter ConfirmPassword';
                          }
                          return null;
                        },
                        controller: _ConfpasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Confirm Password'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                /// sing in button
                GestureDetector(
                  onTap: (){
                    if(!_globalKey.currentState!.validate()){
                      return;
                    }
                    SingUp();

                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                            child: const Text(
                              'Sing up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                /// Register text button in here.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I am a member?',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LogIn(showRegisterPage: (){})));
                      },
                      child: Text(
                        'Log in now',
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

