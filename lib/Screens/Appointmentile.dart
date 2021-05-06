import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/Screens/Appointmentdetails.dart';
import 'package:flutter/material.dart';

class AppointmentTile extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;
  AppointmentTile({this.snapshot, this.index});
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentDetails(
                patientEmail: patientEmail,
                problem: problem,
                previousRecord: previousRecord,
                patientName: patientName,
                id: id,
              ),
            ),
          );
        },
        leading: Image.asset('images/doctor.jpeg'),
        title: Text('$patientName'),
        subtitle: Text('$problem '),
      ),
    );
  }
}
