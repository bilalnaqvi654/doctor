import 'package:connectivity/connectivity.dart';
import 'package:doctorsportal/Dialogue.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/Profie.dart';
import 'package:doctorsportal/ProfileDisplay.dart';
import 'package:doctorsportal/Screens/FirstScreen.dart';
import 'package:doctorsportal/Screens/Home.dart';
import 'package:doctorsportal/Screens/Signup.dart';
import 'package:doctorsportal/Widgets/Button.dart';
import 'package:doctorsportal/Widgets/TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class LogIN extends StatefulWidget {
  @override
  _LogINState createState() => _LogINState();
}

class _LogINState extends State<LogIN> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Log in '),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
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
              placeHolder: 'Enter your password',
              icon: Icon(OMIcons.lock),
              SuffixIcon: Icon(FontAwesomeIcons.eye),
            ),
            SizedBox(
              height: 14.0,
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forget Password',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            buttonWidget(
              ontap: () async {
                print(email);
                print(password);
                var conectivityResult =
                    await Connectivity().checkConnectivity();
                if (conectivityResult != ConnectivityResult.mobile &&
                    conectivityResult != ConnectivityResult.wifi) {
                  showSnackBar('Check internet connectivity ');
                  return;
                }
                if (email.isEmpty) {
                  showSnackBar('Enter Your Email ');
                  return;
                }
                if (password.isEmpty) {
                  showSnackBar('Enter Password');
                  return;
                }
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => Dialogue(
                    status: 'Logging You in  you',
                  ),
                );
                // ignore: await_only_futures
                Login();
                Navigator.pop(context);
              },
              title: 'Log in ',
            ),
            SizedBox(
              height: 8.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Signup(),
                  ),
                );
              },
              child: Text(
                'Dont have a account? Sign up for free ',
                style: TextStyle(color: Colors.black, fontSize: 15.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  void Login() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // ignore: unnecessary_statements
    (await _auth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FirstScreen(),
        ),
      );
    }).catchError((error) {
      //check error and display message
      print(error);
      String errorMessage;
      setState(() {
        errorMessage = error.toString();
      });

      showSnackBar(errorMessage);
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
      backgroundColor: Colors.red,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
