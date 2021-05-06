import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Screens/Signup.dart';
import 'package:doctorsportal/Widgets/Button.dart';
import 'package:doctorsportal/Widgets/TextField.dart';
import 'package:flutter/material.dart';

class AddHospital extends StatefulWidget {
  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
  String hospitalName;
  String address;
  String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('Add Hospitals'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 24.0,
            ),
            textField(
              title: 'Hospital Name',
              placeHolder: 'Enter Your Hospital Name',
              maxLines: 1,
              obsecure: false,
              onChangedValue: (val) {
                hospitalName = val;
              },
              icon: Icon(Icons.local_hospital),
            ),
            SizedBox(
              height: 14.0,
            ),
            textField(
              title: 'Phone Number',
              placeHolder: 'Enter Hospital Phone Number',
              maxLines: 1,
              obsecure: false,
              onChangedValue: (val) {
                phoneNumber = val;
              },
              icon: Icon(Icons.phone),
            ),
            SizedBox(
              height: 14.0,
            ),
            textField(
              title: 'Address',
              placeHolder: 'Enter the address of Your Hospital',
              onChangedValue: (val) {
                address = val;
              },
              maxLines: 3,
              obsecure: false,
              icon: Icon(Icons.streetview),
            ),
            SizedBox(
              height: 14.0,
            ),
            buttonWidget(
              title: 'Register',
              ontap: () {
                safeHospital();
              },
            )
          ],
        ),
      ),
    );
  }

  void safeHospital() {
    FirebaseFirestore.instance.collection('Hospitals').add({
      "HospitalName": "$hospitalName",
      "Address": "$address",
      "PhoneNumber": "$phoneNumber",
    }).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Signup(),
        ),
      );
    });
  }
}
