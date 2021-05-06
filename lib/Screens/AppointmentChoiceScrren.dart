import 'package:doctorsportal/Screens/AcceptedAppoinment.dart';
import 'package:doctorsportal/Screens/Home.dart';
import 'package:doctorsportal/Screens/VideoAppointments.dart';
import 'package:doctorsportal/Widgets/Button.dart';
import 'package:doctorsportal/Widgets/CustomCard.dart';
import 'package:flutter/material.dart';

class AppselectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('Welcome '),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Custom_Card(
                title: "Pending Appointment",
                custom_Icon: Image.asset('images/pending.jpg'),
                myFunction: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
                }),
            SizedBox(
              height: 12.0,
            ),
            Custom_Card(
                title: " Approved Appointment  ",
                custom_Icon: Image.asset('images/done.jpg'),
                myFunction: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AcceptedAppointment(),
                  ));
                }),
            Custom_Card(
                title: "Online Video Appt",
                custom_Icon: Icon(
                  Icons.video_call,
                  size: 75.0,
                ),
                myFunction: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VideoCalling(),
                  ));
                }),
          ],
        ),
      ),
    );
  }
}
