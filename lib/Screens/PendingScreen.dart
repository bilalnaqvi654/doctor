import 'dart:ui';

import 'package:flutter/material.dart';

class PendingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100.0,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('images/pending.jpg'),
            radius: 80.0,
          ),
          SizedBox(
            height: 24.0,
          ),
          Text('Account Pending For approval',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 24.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text('Appointments will be shown once your account is approved',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    )),
          ),
        ],
      ),
    );
  }
}
