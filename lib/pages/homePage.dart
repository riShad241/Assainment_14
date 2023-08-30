import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_practice/pages/login.dart';
import 'package:flutter_firebase_practice/read%20data/get_user_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  ///document IDs
  List<String> docId = [];

  ///get docId
  Future getdocId() async {
    await FirebaseFirestore.instance
        .collection('User')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docId.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( user.email!),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => LogIn(
                      showRegisterPage: () {},
                    )),(route) => false,);
          }, icon:Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: FutureBuilder(
              future: getdocId(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: docId.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: GetUserName(documentId: docId[index]),
                          ),
                        ),
                      );
                    });
              },
            ))
          ],
        ),
      ),
    );
  }
}
