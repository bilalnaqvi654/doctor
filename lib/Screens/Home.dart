import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/Screens/Appointmentdetails.dart';
import 'package:doctorsportal/Screens/Appointmentile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dbref = FirebaseFirestore.instance
      .collection("Appoinments")
      .where('Docotrs_Email', isEqualTo: '$email')
      .where('status', isEqualTo: 'pending')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('Pending Appointments'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: dbref,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('No appointment Pending'));
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, int index) {
                return AppointmentTile(snapshot: snapshot.data, index: index);
              },
            );
          }),
    );
  }
}
