import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class markAttendance extends StatefulWidget {
  @override
  _markAttendanceState createState() => _markAttendanceState();
}

class _markAttendanceState extends State<markAttendance> {
  @override
  Widget build(BuildContext context) {
    String userinput = "";

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              TextField(
                decoration: InputDecoration.collapsed(
                  hintText: ' Enter Session ID',
                ),
                onChanged: (val) {
                  userinput = val;
                },
              ),
              RaisedButton(
                onPressed: () {
                  DocumentReference documentReference = Firestore.instance
                      .collection("sessions")
                      .document(userinput);
                  documentReference.get().then((datasnapshot) {
                    if (datasnapshot.exists) {
                      print("Attendance Marked");
                    } else {
                      print("Wrong Session ID Entered");
                    }
                  });
                },

//                if(checkinput == userinput)
//                  print('present');
//                else
//                  print('Absent');

                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
