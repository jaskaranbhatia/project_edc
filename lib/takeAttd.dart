import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class takeAttendance extends StatefulWidget {
  @override
  _takeAttendanceState createState() => _takeAttendanceState();
}

class _takeAttendanceState extends State<takeAttendance> {
  int rand;


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    var Rand = new Random();
    rand = Rand.nextInt(10000);
    Firestore.instance
        .collection('sessions')
        .document(rand.toString())
        .setData({'sessionid ': rand});

    Timer(Duration(seconds: 40), () {
      //print("Yeah, this line is printed after 3 seconds");
      Firestore.instance
          .collection('sessions')
          .document(rand.toString()).delete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(leading: Icon(Icons.arrow_back_ios),
            title: Text('Sessoin ID'),
            backgroundColor: Color.fromRGBO(97, 10, 165, 0.8)),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background_curve.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Your Sessoin ID is:\n\n", style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold)),
              Center(
                child: Text(rand.toString(), style: TextStyle(
                    fontSize: 40.0, color: Color.fromRGBO(97, 10, 165, 0.8))),
              ),
              Text('\n\nThe curernt session expires in 40 seconds',
                  style: TextStyle(color: Colors.red, fontSize: 16.0)),
            ],
          ),
        ),
      ),
    );
  }
}
