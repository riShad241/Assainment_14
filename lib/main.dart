import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_practice/argvsafg.dart';
import 'package:flutter_firebase_practice/itavsspa.dart';

/// Let's an App that will show our basketball live score

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const BasketBallLiveScoreApp());
}

class BasketBallLiveScoreApp extends StatelessWidget {
  const BasketBallLiveScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Live score app'),
        ),
        body: Column(
          children: [
            ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ArgvsAfr()));
                },
                title: Text('Argentina vs Africa'),
                trailing: Icon(Icons.arrow_circle_right_outlined)),
            ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ItavsSpa()));
                },
                title: Text('Italy vs Span'),
                trailing: Icon(Icons.arrow_circle_right_outlined)),
          ],
        ));
  }
}
