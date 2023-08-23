import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ArgvsAfr extends StatefulWidget {
  const ArgvsAfr({Key? key}) : super(key: key);

  @override
  State<ArgvsAfr> createState() => _ArgvsAfrState();
}

class _ArgvsAfrState extends State<ArgvsAfr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Arg vs Afr'),),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Football_match')
              .doc('_ARG_VS_AFR')
              .snapshots(),
          builder:
              (context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
            print(snapshot.data?.data());
            if (snapshot.hasData) {
              final score = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container (
                width: 380,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white, // Container background color
                  borderRadius: BorderRadius.circular(15), // Border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 7, // Blur radius
                      offset: Offset(0, 3), // Offset in x and y direction
                    ),
                  ],
                ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 48,
                      ),
                      Text(
                        'Argentina vs Africa',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                score.get('AFR_Score').toString(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                           Text(':',
                            style: Theme.of(context).textTheme.titleLarge,),
                          Column(
                            children: [
                              Text(
                                score.get('ARG_Score').toString(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text('Time :${score.get('Time')}',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(
                        height: 12,
                      ),
                      Text('Total Time :${score.get('Total_time')}',
                          style: Theme.of(context).textTheme.headlineSmall)
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
