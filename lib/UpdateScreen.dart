import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Dialogue.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/Profie.dart';
import 'package:doctorsportal/Screens/FirstScreen.dart';
import 'package:doctorsportal/Widgets/Button.dart';
import 'package:doctorsportal/Widgets/TextField.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  String UserImageUrl = '';
  File _image;
  String password;
  String name;
  String pmdcNumber;
  String hspital;
  String statday;
  String endDay;
  TimeOfDay startTime;
  TimeOfDay endtime;
  String phoneNumber;
  String status = 'pending';
  String specialist;
  @override
  void initState() {
    super.initState();
    setState(() {
      startTime = TimeOfDay.now();
      endtime = TimeOfDay.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Update '),
        centerTitle: true,
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 14.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Align(
                alignment: Alignment(0, -1),
                child: GestureDetector(
                  onTap: () {
                    GallerImagePicker();
                  },
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: (_image != null)
                              ? FileImage(_image)
                              : AssetImage('images/dummy.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            SizedBox(
              height: 14.0,
            ),
            SizedBox(
              height: 14.0,
            ),
            textField(
              keyboradtype: TextInputType.number,
              obsecure: false,
              onChangedValue: (val) {
                pmdcNumber = val;
              },
              title: 'PMDC Number',
              placeHolder: 'Enter your PMDC Number',
              icon: Icon(Icons.confirmation_number),
            ),
            SizedBox(
              height: 14.0,
            ),
            textField(
              keyboradtype: TextInputType.number,
              obsecure: false,
              onChangedValue: (val) {
                phoneNumber = val;
              },
              title: 'Mobile Number',
              placeHolder: 'Enter your Mobile Number',
              icon: Icon(Icons.phone),
            ),
            SizedBox(
              height: 14.0,
            ),
            textField(
              obsecure: false,
              onChangedValue: (val) {
                specialist = val;
              },
              title: 'Speciality',
              placeHolder: 'Enter your Qualification',
              icon: Icon(Icons.phone),
            ),
            SizedBox(
              height: 14.0,
            ),
            textField(
              obsecure: false,
              onChangedValue: (val) {
                name = val;
              },
              title: 'Name',
              placeHolder: 'Enter your Name',
              icon: Icon(Icons.person),
            ),
            SizedBox(
              height: 14.0,
            ),
            textField(
              obsecure: false,
              onChangedValue: (val) {
                hspital = val;
              },
              title: 'Hospital',
              placeHolder: 'Enter your Hospital Name',
              icon: Icon(Icons.local_hospital),
            ),
            SizedBox(
              height: 14.0,
            ),
            Text(
              'Select Your Day',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 14.0,
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
                      border: Border.all(color: Colors.black, width: 3.0),
                    ),
                    height: 50.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: DropdownButton(
                        hint: statday == null
                            ? Text('Slect Day')
                            : Text(
                                statday,
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
                              statday = val;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14.0,
                  ),
                  Text(
                    'TO',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 14.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(15.0, 15.0),
                      ),
                      border: Border.all(color: Colors.black, width: 3.0),
                    ),
                    height: 50.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: DropdownButton(
                        hint: endDay == null
                            ? Text('Slect Day')
                            : Text(
                                endDay,
                                style: TextStyle(color: Colors.black),
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
                              endDay = val;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            Text(
              'Select Your Time',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
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
                          Icon(Icons.lock_clock),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text('${startTime.hour}:${startTime.minute}'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 68.0,
                  ),
                  Text(
                    'TO',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: InkWell(
                      onTap: _pickTimestartend,
                      child: Row(
                        children: [
                          Icon(Icons.lock_clock),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text('${endtime.hour}:${endtime.minute}'),
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
              title: 'Update',
              ontap: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => Dialogue(
                    status: 'UPDATING YOUR DATA',
                  ),
                );
                await UploadTOFireBase(context);

                Navigator.pop(context);
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
        initialTime: startTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(),
            child: child,
          );
        });
    if (time != null) {
      setState(() {
        startTime = time;
      });
    }
  }

  _pickTimestartend() async {
    TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: endtime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(),
            child: child,
          );
        });
    if (time != null) {
      setState(() {
        endtime = time;
      });
    }
  }

  void showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future GallerImagePicker() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
    print(_image);
  }

  Future UploadTOFireBase(BuildContext context) async {
    String fileName = path.basename(_image.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('UserImage/$fileName');
    UploadTask uploadTask = ref.putFile(_image);

    uploadTask.then((res) async {
      UserImageUrl = await ref.getDownloadURL();
      print(path.url);

      FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseAuth.currentUser.uid)
          .update(
        {
          "Name": "$name",
          "Hospital Name": "$hspital",
          "Email": "$email",
          "PMDC Number": "$pmdcNumber",
          "Phone Number": "$phoneNumber",
          "Start Day": "$statday",
          "End Day": "$endDay",
          "Start Time": "${startTime.toString()}",
          "End time": "${endtime.toString()}",
          "Status": "$status",
          "Specialist": "$specialist",
          "imageUrl": "$UserImageUrl",
        },
      ).then(
        (_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => View(),
            ),
          );
        },
      );
      print(" Picture uploaded");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(' Picture Uploaded')));
    });
  }
}
