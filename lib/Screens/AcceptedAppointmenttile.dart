import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/Screens/AcceptedAppointmentdetails.dart';
import 'package:flutter/material.dart';

class AppecptedAppointmentTile extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;
  AppecptedAppointmentTile({this.snapshot, this.index});
  @override
  Widget build(BuildContext context) {
    String patientName = "${snapshot.docs[index].data()["Name"].toString()}";
    String problem = "${snapshot.docs[index].data()["Problem"].toString()}";
    String patientEmail =
        "${snapshot.docs[index].data()["userEmail"].toString()}";
    String id = snapshot.docs[index].id;
    String token1 = "${snapshot.docs[index].data()["Token"].toString()}";
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
              builder: (context) => AcceptedAppointmentDetais(
                patientEmail: patientEmail,
                patientName: patientName,
                id: id,
                token2: token1,
              ),
            ),
          );
        },
        title: Text('$patientName'),
        subtitle: Text('$problem '),
        leading: Image.asset('images/doctor.jpeg'),
      ),
    );
  }
}
