import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/Screens/AppointmentChoiceScrren.dart';
import 'package:doctorsportal/Widgets/Button.dart';
import 'package:flutter/material.dart';

class AppceptAppointment extends StatefulWidget {
  final String problem;
  final String name;
  final String id;
  AppceptAppointment({this.problem, this.name, this.id});
  @override
  _AppceptAppointmentState createState() => _AppceptAppointmentState();
}

class _AppceptAppointmentState extends State<AppceptAppointment> {
  @override
  void initState() {
    super.initState();
  }

  String day;
  TimeOfDay time11 = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('${widget.name}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 24.0,
            ),
            Card(
              elevation: 14.0,
              margin: EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Assign day',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(15.0, 15.0),
                            ),
                            border: Border.all(width: 3.0),
                          ),
                          height: 40.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: DropdownButton(
                              hint: day == null
                                  ? Text('Slect Day')
                                  : Text(
                                      day,
                                      style: TextStyle(color: Colors.lightBlue),
                                    ),
                              iconSize: 30.0,
                              style: TextStyle(color: Colors.black),
                              items: [
                                'Monday',
                                'Tuesday',
                                'Wednesday',
                                'Thursday',
                                'Friday',
                                'Saturday',
                                'Sunday',
                              ].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    day = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 14.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            Card(
              borderOnForeground: true,
              elevation: 12.0,
              margin: EdgeInsets.all(14.0),
              child: Container(
                height: 48.0,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Select Time ',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: InkWell(
                      onTap: _pickTimestart,
                      child: Row(
                        children: [
                          Center(
                            child: Icon(
                              Icons.lock_clock,
                              size: 50.0,
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text('${time11.hour}:${time11.minute}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            buttonWidget(
              title: 'Accept Appointment',
              ontap: () {
                upDateAppointment();
              },
            ),
          ],
        ),
      ),
    );
  }

  _pickTimestart() async {
    TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: time11,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(),
            child: child,
          );
        });
    if (time != null) {
      setState(() {
        time11 = time;
      });
    }
  }

  void upDateAppointment() {
    FirebaseFirestore.instance
        .collection("Appoinments")
        .doc('${widget.id}')
        .update({
      "Time": "$time11",
      "Day": "$day",
      "status": "approved",
    }).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppselectScreen(),
        ),
      );
    });
  }
}
