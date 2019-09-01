import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(rand.toString()),
        ),
      ),
    );
  }
}
