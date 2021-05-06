import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:flutter/material.dart';

class VideoAppountTile extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;
  VideoAppountTile({this.snapshot, this.index});
  @override
  Widget build(BuildContext context) {
    String patientName = "${snapshot.docs[index].data()["Name"].toString()}";
    String previousRecord =
        "${snapshot.docs[index].data()["PreviousRecord"].toString()}";
    String problem = "${snapshot.docs[index].data()["Problem"].toString()}";

    String patientEmail =
        "${snapshot.docs[index].data()["userEmail"].toString()}";
    token = "${snapshot.docs[index].data()["Token"].toString()}";
    String id = snapshot.docs[index].id;
    return Card(
      color: Colors.white,
      borderOnForeground: true,
      elevation: 12.0,
      margin: EdgeInsets.all(14.0),
      child: ListTile(
        onTap: () {},
        leading: Image.asset('images/doctor.jpeg'),
        trailing: Icon(
          Icons.video_call,
          size: 50.0,
        ),
        title: Text('$patientName'),
        subtitle: Text('$problem '),
      ),
    );
  }
}
