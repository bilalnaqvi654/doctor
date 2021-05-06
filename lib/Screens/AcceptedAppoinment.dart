import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/Screens/AcceptedAppointmenttile.dart';
import 'package:doctorsportal/Screens/FirstScreen.dart';
import 'package:flutter/material.dart';

class AcceptedAppointment extends StatefulWidget {
  @override
  _AcceptedAppointmentState createState() => _AcceptedAppointmentState();
}

class _AcceptedAppointmentState extends State<AcceptedAppointment> {
  @override
  var dbref = FirebaseFirestore.instance
      .collection("Appoinments")
      .where("Docotrs_Email", isEqualTo: "$email")
      .where("status", isEqualTo: "approved")
      .snapshots();
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
        title: Text('Approved Appoinmets'),
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
              return AppecptedAppointmentTile(
                  snapshot: snapshot.data, index: index);
            },
          );
        },
      ),
    );
  }
}
