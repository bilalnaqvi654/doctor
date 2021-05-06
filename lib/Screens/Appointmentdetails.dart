import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Screens/AppoinmmentAcceptance.dart';
import 'package:doctorsportal/Screens/FirstScreen.dart';
import 'package:doctorsportal/Widgets/Button.dart';
import 'package:flutter/material.dart';

class AppointmentDetails extends StatelessWidget {
  final String patientEmail;
  final String previousRecord;
  final String problem;
  final String patientName;
  final String id;
  AppointmentDetails({
    this.patientEmail,
    this.previousRecord,
    this.problem,
    this.patientName,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('$patientName'),
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
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 14.0,
          ),
          Card(
            color: Colors.blue[200],
            borderOnForeground: true,
            elevation: 12.0,
            margin: EdgeInsets.all(14.0),
            child: Container(
              height: 48.0,
              width: double.infinity,
              child: Center(
                child: Text(
                  '$problem ',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Open Sans',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          Card(
            color: Colors.blue[200],
            borderOnForeground: true,
            elevation: 12.0,
            margin: EdgeInsets.all(14.0),
            child: Container(
              height: 48.0,
              width: double.infinity,
              child: Center(
                child: Text(
                  '$previousRecord ',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Open Sans',
                  ),
                ),
              ),
            ),
          ),
          buttonWidget(
            title: 'Approve',
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppceptAppointment(
                    name: patientName,
                    problem: problem,
                    id: id,
                  ),
                ),
              );
            },
          ),
          SizedBox(
            width: 14.0,
          ),
          buttonWidget(
            title: 'Reject',
            ontap: () {
              DeleteAppointment();
            },
          )
        ],
      ),
    );
  }

  DeleteAppointment() {
    FirebaseFirestore.instance
        .collection("Appoinments")
        .doc(id)
        .delete()
        .then((_) {
      print('deleted');
    });
  }
}
