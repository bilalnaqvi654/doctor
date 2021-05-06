import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsportal/Globals.dart';
import 'package:doctorsportal/UpdateScreen.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  final QuerySnapshot snapshot;
  final int index;

  Profile({this.snapshot, this.index});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 100.0,
        ),
        CircleAvatar(
          radius: 100.0,
          backgroundImage: NetworkImage(
            snapshot.docs[index].data()["imageUrl"].toString(),
          ),
        ),
        SizedBox(
          height: 14.0,
        ),
        Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                ('${snapshot.docs[index].data()["Name"].toString()}'),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Open Sans',
                    fontSize: width / 9),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                '${snapshot.docs[index].data()["Hospital Name"].toString()}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Open Sans',
                    fontSize: width / 20),
              ),
            ),
            SizedBox(
              height: height / 6,
            ),
            Container(
              width: width * .8,
              height: height / 8,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.black,
                child: Text(
                  "Update",
                  style: TextStyle(
                      fontSize: width / 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateScreen(),
                    ),
                  );
                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
            )
          ],
        ),
        // Row(
        //   children: <Widget>[
        //     Align(
        //       alignment: Alignment.topCenter,
        //       child: Text(
        //         'Email:',
        //         style: TextStyle(
        //             color: Colors.white,
        //             fontWeight: FontWeight.w900,
        //             fontStyle: FontStyle.italic,
        //             fontFamily: 'Open Sans',
        //             fontSize: width / 12),
        //       ),
        //     ),
        //     SizedBox(
        //       width: 24,
        //     ),
        //     Align(
        //       alignment: Alignment.topCenter,
        //       child: Text(
        //         ('${snapshot.docs[index].data()["Email"].toString()}'),
        //         style: TextStyle(
        //             color: Colors.white,
        //             fontWeight: FontWeight.w900,
        //             fontStyle: FontStyle.italic,
        //             fontFamily: 'Open Sans',
        //             fontSize: width / 12),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
