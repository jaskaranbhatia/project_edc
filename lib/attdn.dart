import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class markAttendance extends StatefulWidget {
  @override
  _markAttendanceState createState() => _markAttendanceState();
}

class _markAttendanceState extends State<markAttendance> {
  @override
  double longitude;
  double latitude;
  String result = "";

  void getlocation() async {
    GeolocationStatus geolocationStatus = await Geolocator()
        .checkGeolocationPermissionStatus();
    Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    longitude = position.longitude;
    latitude = position.latitude;


    Firestore.instance.collection('location').document('loc').setData(
        {'latitude': latitude, 'longitude': longitude});
    // Firestore.instance.collection('location').document('loc').setData({});


  }

  @override
  Widget build(BuildContext context) {
    String userinput = "Initial";
    return MaterialApp(
      home: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.arrow_back_ios),
            backgroundColor: Color.fromRGBO(97, 10, 165, 0.8),
            title: Text("Submit Your Attendance"),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background_curve.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
//              BoxField(
//                  hintText: "Enter Teacher ID",
//                  lableText: "Email",
//                  obscureText: false,
//                  onChanged: (val) {
//                    userinput = val;
//                  },
//                  icon: Icons.forward,
//                  iconColor: colorCurve)
                  Container(
                    height: 60,
                    width: 245,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple),
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                          hintText: ' Enter Session ID',
                          hintStyle: TextStyle(fontSize: 20)
                      ),
                      onChanged: (val) {
                        userinput = val;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      DocumentReference documentReference = Firestore.instance
                          .collection("sessions")
                          .document(userinput);
                      documentReference.get().then((datasnapshot) {
                        if (datasnapshot.exists) {
                          //Text('Bravo\nAttendance Marked',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),);
                          print("present");
                          setState(() {
                            result = "Present";
                          });
                          //print("Attendance Marked");
                          getlocation();
                        } else {
                          print("wrong session");
                          //Text('Opps!\n Something Went Wrong',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),);
                          setState(() {
                            result = "Wrong Session Id";
                          });
                        }
                      });
                    },

//                if(checkinput == userinput)
//                  print('present');
//                else
//                  print('Absent');

                    child: Text("Submit",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(child: Text(result, style: TextStyle(fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(97, 10, 165, 0.8),),)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
