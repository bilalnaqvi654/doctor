import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:doctorsportal/Dialogue.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/Profie.dart';
import 'package:doctorsportal/Screens/AddHospital.dart';
import 'package:doctorsportal/Screens/FirstScreen.dart';
import 'package:doctorsportal/Screens/Home.dart';
import 'package:doctorsportal/Widgets/Button.dart';
import 'package:doctorsportal/Widgets/TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  BuildContext scaffoldContext;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  String UserImageUrl;
  File _image;
  String password;
  String fee;
  String pmdcNumber;
  String hspital;
  String statday;
  String endDay;
  TimeOfDay startTime;
  TimeOfDay endtime;
  String phoneNumber;
  String status = 'pending';
  String specialist;
  String bio;
  String experience;
  String address;

  var _queryCat;

  var category;
  var value1;
  @override
  void initState() {
    super.initState();
    setState(() {
      startTime = TimeOfDay.now();
      endtime = TimeOfDay.now();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register '),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 14.0,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Hospitals')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return const Center(
                      child: const CupertinoActivityIndicator(),
                    );
                  var length = snapshot.data.docs.length;
                  DocumentSnapshot ds = snapshot.data.docs[length - 1];
                  _queryCat = snapshot.data.docs;
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
                              "Select Hospital",
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
                              hintText: 'Select Hospital',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            isEmpty: category == null,
                            child: DropdownButton(
                              onChanged: (value1) {
                                setState(() {
                                  category = value1;
                                  var dropDown = false;
                                  print(category);
                                });
                              },
                              value: category,
                              isDense: true,
                              isExpanded: true,
                              items: snapshot.data.docs
                                  .map((DocumentSnapshot document) {
                                return new DropdownMenuItem<String>(
                                    value: document.data()['HospitalName'],
                                    child: new Text(
                                      document.data()['HospitalName'],
                                    ));
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
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
            textField(
              obsecure: false,
              onChangedValue: (val) {
                email = val;
              },
              title: 'Email',
              placeHolder: 'Enter your Email',
              icon: Icon(Icons.email),
            ),
            SizedBox(
              height: 14.0,
            ),
            textField(
              maxLines: 1,
              obsecure: true,
              onChangedValue: (val) {
                password = val;
              },
              title: 'Password',
              placeHolder: 'Enter your Password',
              icon: Icon(Icons.lock),
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
              obsecure: false,
              onChangedValue: (val) {
                experience = val;
              },
              title: 'Experince',
              placeHolder: 'Enter your Experience in Years',
              icon: Icon(Icons.email),
            ),
            SizedBox(
              height: 14.0,
            ),
            textField(
              obsecure: false,
              onChangedValue: (val) {
                fee = val;
              },
              title: 'Fee',
              placeHolder: 'Enter Your Fees',
              icon: Icon(Icons.email),
            ),
            SizedBox(
              height: 14.0,
            ),
            textField(
              obsecure: false,
              onChangedValue: (val) {
                address = val;
              },
              title: 'Clinic Address',
              placeHolder: 'Enter your Clinic Address',
              icon: Icon(Icons.email),
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
              icon: Icon(Icons.local_hospital_sharp),
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
            SizedBox(
              height: 14.0,
            ),
            textField(
              maxLines: 4,
              obsecure: false,
              onChangedValue: (val) {
                bio = val;
              },
              title: 'Bio',
              placeHolder: 'Enter your Bio (education experiance etc)',
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
              title: 'Register',
              ontap: () async {
                print(startTime);
                print(endtime);
                print(statday);
                print(endDay);
                print(status);
                var conectivityResult =
                    await Connectivity().checkConnectivity();
                if (conectivityResult != ConnectivityResult.mobile &&
                    conectivityResult != ConnectivityResult.wifi) {
                  showSnackBar('Check internet connectivity ');
                  return;
                }
                if (email.isEmpty && !email.contains('@')) {
                  showSnackBar('Enter Valid Email');
                  return;
                }
                if (password.isEmpty && password.length < 8) {
                  showSnackBar('Enter Valid Password');
                  return;
                }
                if (category.isEmpty && category.length < 5) {
                  showSnackBar('Enter Valid Password');
                  return;
                }
                if (category.isEmpty && category.length < 5) {
                  showSnackBar('Enter Valid Hospital Name');
                  return;
                }
                if (phoneNumber.isEmpty && phoneNumber.length < 11) {
                  showSnackBar('Enter Valid Phone Number');
                  return;
                }
                if (pmdcNumber.isEmpty && pmdcNumber.length < 4) {
                  showSnackBar('Enter Valid PMDC Number');
                  return;
                }
                if (statday.isEmpty) {
                  showSnackBar('Select Start Day ');
                  return;
                }
                if (specialist.isEmpty && specialist.length < 8) {
                  showSnackBar('Enter Valid Qualification ');
                  return;
                }
                if (endDay.isEmpty) {
                  showSnackBar('Select End  Day ');
                  return;
                }
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => Dialogue(
                    status: 'Registering you',
                  ),
                );
                await _register();

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 75.0,
        width: 150.0,
        child: FloatingActionButton(
          backgroundColor: Colors.blue[100],
          isExtended: true,
          child: Text(
            'Add a Hospital',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddHospital(),
              ),
            );
          },
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

  void _register() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    // ignore: unnecessary_statements
    (await _auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((_) {
      UploadTOFireBase(context);
    }).catchError((ex) {
      Exception exception = ex;
      showSnackBar(exception.toString());
    }));
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

  // void addDoctor() async {
  //   FirebaseFirestore.instance.collection('Users').add(
  //     {
  //       "Name": "$name",
  //       "Hospital Name": "$hspital",
  //       "Email": "$email",
  //       "PMDC Number": "$pmdcNumber",
  //       "Phone Number": "$phoneNumber",
  //       "Start Day": "$statday",
  //       "End Day": "$endDay",
  //       "Start Time": "${startTime.toString()}",
  //       "End time": "${endtime.toString()}",
  //       "Status": "$status",
  //       "Specialist": "$specialist"
  //     },
  //   ).then(
  //     (_) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => HomePage(),
  //         ),
  //       );
  //     },
  //   );
  // }

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
          .collection('Docotors')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set(
        {
          "Name": "$name",
          "Hospital Name": "$category",
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
          "BioData": "$bio",
          "Experience": "$experience",
          "Fee": "$fee",
          "Address": "$address",
        },
      ).then(
        (_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FirstScreen(),
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
