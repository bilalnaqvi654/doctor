import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/Screens/Appointmentile.dart';
import 'package:doctorsportal/Screens/VideoAppointtile.dart';
import 'package:flutter/material.dart';

class VideoCalling extends StatefulWidget {
  @override
  _VideoCallingState createState() => _VideoCallingState();
}

class _VideoCallingState extends State<VideoCalling> {
  var dbref = FirebaseFirestore.instance
      .collection("VideoAppointMent")
      .where('Docotrs_Email', isEqualTo: '$email')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('Video Calling Appointment '),
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
                return VideoAppountTile(snapshot: snapshot.data, index: index);
              },
            );
          }),
    );
  }
}
