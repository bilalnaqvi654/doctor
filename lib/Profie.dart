import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/ProfileDisplay.dart';
import 'package:doctorsportal/Screens/FirstScreen.dart';
import 'package:doctorsportal/Screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class View extends StatefulWidget {
  @override
  _ViewState createState() => _ViewState();
}

@override
class _ViewState extends State<View> {
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
              child: Icon(Icons.home)),
        ],
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: dbref,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, int index) {
              return Profile(snapshot: snapshot.data, index: index);
            },
          );
        },
      ),
    );
  }
}
