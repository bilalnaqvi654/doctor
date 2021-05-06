import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/Screens/Home.dart';
import 'package:doctorsportal/Screens/PendingScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final QuerySnapshot snapshot;
  final int index;
  HomeScreen({this.snapshot, this.index});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String status1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onPressed();
  }

  void _onPressed() {
    FirebaseFirestore.instance
        .collection("Docotors")
        .where('Email', isEqualTo: '$email')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        status1 = (result.data()['Status']);
        print(status1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (status1 == "pending") ? PendingScreen() : HomePage(),
    );
  }
}
