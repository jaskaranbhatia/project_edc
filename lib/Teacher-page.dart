import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_collections/model/models.dart';
import 'package:flutter_ui_collections/utils/utils.dart';
import 'package:flutter_ui_collections/widgets/widgets.dart';
import 'package:flutter_ui_collections/firebase.dart';
import './ui/page_login.dart';
import 'package:flutter_ui_collections/takeAttd.dart';

class teacherPage extends StatefulWidget {
  @override
  _teacherPageState createState() => _teacherPageState();
}

class _teacherPageState extends State<teacherPage> {
  Screen size;
  int _selectedIndex = 0;
  List<Property> premiumList = List();
  List<Property> featuredList = List();
  var citiesList = [
    "COE 21-24",
    "COE 5-8",

  ];

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery
        .of(context)
        .size);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Present", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(97, 10, 165, 0.6),),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(child: Text('Present', style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700
              ),
              ),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(97, 10, 165, 0.6),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Timetable'),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log Out'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ),
          ],
        ),
      ),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: backgroundColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: backgroundColor),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                upperPart(),
                SizedBox(
                  height: 8.0,
                ),
//                RaisedButton(
//                  onPressed: () {
//                    Navigator.push(context,
//                        MaterialPageRoute(builder: (context) => Firebase()));
//                    print("Hello");
//                  },
//                  elevation: 8.0,
//                  shape: RoundedRectangleBorder(
//                      borderRadius: new BorderRadius.circular(30.0)),
//                  padding: EdgeInsets.all(size.getWidthPx(12)),
//                  child: Text(
//                    "Show Time Table",
//                    style: TextStyle(
//                        fontFamily: 'Exo2', color: Colors.white, fontSize: 15.0),
//                  ),
//                  color: Color.fromRGBO(97, 10, 165, 0.8),
//                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget upperPart() {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: UpperClipper(),
          child: Container(
            height: size.getWidthPx(240),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorCurve, colorCurveSecondary],
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: size.getWidthPx(36)),
              child: Column(
                children: <Widget>[
                  titleWidget(),
                  SizedBox(height: size.getWidthPx(10)),
                  upperBoxCard(),
                ],
              ),
            ),
            leftAlignText(
                text: "",
                leftPadding: size.getWidthPx(16),
                textColor: textPrimaryColor,
                fontSize: 16.0),
//            HorizontalList(
//              children: <Widget>[
//                for (int i = 0; i < premiumList.length; i++)
//                  propertyCard(premiumList[i])
//              ],
//            ),
            leftAlignText(
                text: "",
                leftPadding: size.getWidthPx(16),
                textColor: textPrimaryColor,
                fontSize: 16.0),
//            HorizontalList(
//              children: <Widget>[
//                for (int i = 0; i < premiumList.length; i++)
//                  propertyCard(premiumList.reversed.toList()[i])
//
//              ],
//            )
          ],
        ),
      ],
    );
  }

  Text titleWidget() {
    return Text("\nWelcome, \nManage Student attendance",
        style: TextStyle(
            fontFamily: 'Exo2',
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            color: Colors.white));
  }

  Card upperBoxCard() {
    return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(
            horizontal: size.getWidthPx(20), vertical: size.getWidthPx(16)),
        borderOnForeground: true,
        child: Container(
            height: size.getWidthPx(150),
            child: Column(
              children: <Widget>[
                _searchWidget(),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => takeAttendance()));
                    print("Hello");
                  },
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  padding: EdgeInsets.all(size.getWidthPx(6)),
                  child: Text(
                    "Take Attendance",
                    style: TextStyle(
                        fontFamily: 'Exo2',
                        color: Colors.white,
                        fontSize: 15.0),
                  ),
                  color: Color.fromRGBO(97, 10, 165, 0.8),
                ),
                leftAlignText(
                    text: "Upcoming Classes :",
                    leftPadding: size.getWidthPx(16),
                    textColor: textPrimaryColor,
                    fontSize: 16.0),
                HorizontalList(
                  children: <Widget>[
                    for(int i = 0; i < citiesList.length; i++)
                      buildChoiceChip(i, citiesList[i])
                  ],
                ),
              ],
            )
        ));
  }


  Widget _searchWidget() {
    return Container(child: Center(child: Text("\nOperating Systems",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,)));
  }


  Padding leftAlignText({text, leftPadding, textColor, fontSize, fontWeight}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text ?? "",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Exo2',
                fontSize: fontSize,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor)),
      ),
    );
  }


//  Card propertyCard(Property property) {
//    return Card(
//        elevation: 4.0,
//        margin: EdgeInsets.all(8),
//        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//        borderOnForeground: true,
//        child: Container(
//            height: size.getWidthPx(150),
//            width: size.getWidthPx(170),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: <Widget>[
//                ClipRRect(
//                    borderRadius: BorderRadius.only(
//                        topLeft: Radius.circular(12.0),
//                        topRight: Radius.circular(12.0)),
//                    child: Image.asset('assets/${property.image}',
//                        fit: BoxFit.fill)),
//                SizedBox(height: size.getWidthPx(8)),
//                leftAlignText(
//                    text: property.propertyName,
//                    leftPadding: size.getWidthPx(8),
//                    textColor: colorCurve,
//                    fontSize: 14.0),
//                leftAlignText(
//                    text: property.propertyLocation,
//                    leftPadding: size.getWidthPx(8),
//                    textColor: Colors.black54,
//                    fontSize: 12.0),
//                SizedBox(height: size.getWidthPx(4)),
//                leftAlignText(
//                    text: property.propertyPrice,
//                    leftPadding: size.getWidthPx(8),
//                    textColor: colorCurve,
//                    fontSize: 14.0,
//                    fontWeight: FontWeight.w800),
//              ],
//            )));
//  }

  Padding buildChoiceChip(index, chipName) {
    return Padding(
      padding: EdgeInsets.only(left: size.getWidthPx(8)),
      child: ChoiceChip(
        backgroundColor: backgroundColor,
        selectedColor: colorCurve,
        labelStyle: TextStyle(
            fontFamily: 'Exo2',
            color:
            (_selectedIndex == index) ? backgroundColor : textPrimaryColor),
        elevation: 4.0,
        padding: EdgeInsets.symmetric(
            vertical: size.getWidthPx(4), horizontal: size.getWidthPx(12)),
        selected: (_selectedIndex == index) ? true : false,
        label: Text(chipName),
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },

      ),

    );
  }

}