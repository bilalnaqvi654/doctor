import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/Screens/FirstScreen.dart';
import 'package:doctorsportal/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class WelcomeScrren extends StatefulWidget {
  @override
  _WelcomeScrrenState createState() => _WelcomeScrrenState();
}

class _WelcomeScrrenState extends State<WelcomeScrren> {
  var dbref = FirebaseFirestore.instance
      .collection("Docotors")
      .where('Email', isEqualTo: '$email')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FirstScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.home),
            ),
          ),
        ],
        title: Text('My Appoinments'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: dbref,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, int index) {
              return HomeScreen(snapshot: snapshot.data, index: index);
            },
          );
        },
      ),
    );
  }
}
