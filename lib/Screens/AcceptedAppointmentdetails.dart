import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/Screens/FirstScreen.dart';
import 'package:doctorsportal/Widgets/Button.dart';
import 'package:doctorsportal/Widgets/TextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AcceptedAppointmentDetais extends StatefulWidget {
  final String patientName;
  final String patientEmail;
  final String id;
  final String token2;
  AcceptedAppointmentDetais(
      {this.patientName, this.patientEmail, this.id, this.token2});
  @override
  _AcceptedAppointmentDetaisState createState() =>
      _AcceptedAppointmentDetaisState();
}

class _AcceptedAppointmentDetaisState extends State<AcceptedAppointmentDetais> {
  String pharmacy;
  String prescribtion;
  String doctorfee;
  String my_token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onPressed();
    setState(() {
      my_token = '${widget.token2}';
    });
    print(serverKey);
  }

  void _onPressed() {
    FirebaseFirestore.instance
        .collection("Docotors")
        .where('Email', isEqualTo: '$email')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        doctorfee = '${result.data()['Fee']}';
        print(doctorfee);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('${widget.patientName}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Pharmacy')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const Center(
                        child: const CupertinoActivityIndicator(),
                      );
                    var length = snapshot.data.docs.length;
                    DocumentSnapshot ds = snapshot.data.docs[length - 1];
                    var _queryCat = snapshot.data.docs;
                    return new Container(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            flex: 2,
                            child: new Container(
                              padding:
                                  EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 10.0),
                              child: new Text(
                                "Select Pharmacy",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          new Expanded(
                            flex: 4,
                            child: new InputDecorator(
                              decoration: const InputDecoration(
                                //labelText: 'Activity',
                                hintText: 'Select Pharmacy',
                                hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              isEmpty: pharmacy == null,
                              child: DropdownButton(
                                onChanged: (value1) {
                                  setState(() {
                                    pharmacy = value1;
                                    var dropDown = false;
                                    print(pharmacy);
                                  });
                                },
                                value: pharmacy,
                                isDense: true,
                                isExpanded: true,
                                items: snapshot.data.docs
                                    .map((DocumentSnapshot document) {
                                  return new DropdownMenuItem<String>(
                                      value: document.data()['Name'],
                                      child: new Text(
                                        document.data()['Name'],
                                      ));
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              SizedBox(
                height: 24.0,
              ),
              textField(
                maxLines: 4,
                obsecure: false,
                onChangedValue: (val) {
                  prescribtion = val;
                },
                title: 'Write Prescibtion',
                placeHolder: 'Write Medicines for the patient',
                icon: Icon(Icons.local_hospital),
              ),
              buttonWidget(
                  title: 'Give Prescribtion',
                  ontap: () async {
                    await Addprescription();
                    sendNotification(widget.token2, context);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Addprescription() {
    FirebaseFirestore.instance.collection("Prescribtons").add({
      "PatienEmail": "${widget.patientEmail}",
      "PatientName": "${widget.patientName}",
      "Pharmacy": "$pharmacy",
      "Fee": "$doctorfee",
      "Prescribtion": "$prescribtion",
      "Docotrsemail": "$email",
    }).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FirstScreen(),
        ),
      );
    }).then((_) => {
          FirebaseFirestore.instance
              .collection('Appoinments')
              .doc(widget.id)
              .delete()
              .then((_) => print('Success'))
        });
  }

  static sendNotification(
    String token,
    context,
  ) async {
    Map<String, String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization': '$serverKey',
    };

    Map notificationMap = {
      'title': 'Notification ',
      'body': 'Your Presciption is ready'
    };

    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
    };

    Map bodyMap = {
      'notification': notificationMap,
      'data': dataMap,
      'priority': 'high',
      'to': token,
    };
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var response =
        await http.post(url, headers: headerMap, body: jsonEncode(bodyMap));

    print(response.body);
    print('$serverKey');
  }
}
