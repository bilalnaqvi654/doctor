import 'package:doctorsportal/Profie.dart';
import 'package:doctorsportal/Screens/AppointmentChoiceScrren.dart';
import 'package:doctorsportal/Screens/Login.dart';
import 'package:doctorsportal/Screens/WelcomeScreen.dart';
import 'package:doctorsportal/Widgets/Button.dart';
import 'package:doctorsportal/Widgets/CustomCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('Doctorls Portal'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Custom_Card(
                    title: "View Appointments",
                    custom_Icon: Icon(
                      Icons.local_hospital_sharp,
                      size: 60.0,
                    ),
                    myFunction: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AppselectScreen(),
                      ));
                    }),
                SizedBox(
                  width: 25.0,
                ),
                Custom_Card(
                    title: "My Profile ",
                    custom_Icon: Icon(
                      Icons.person,
                      size: 60.0,
                    ),
                    myFunction: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => View(),
                      ));
                    }),
              ],
            ),
            SizedBox(
              width: 14.0,
            ),
            Custom_Card(
                title: "Log Out",
                custom_Icon: Icon(
                  Icons.local_hospital_sharp,
                  size: 60.0,
                ),
                myFunction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => View(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
