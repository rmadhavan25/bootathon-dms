import 'dart:developer';
import 'dart:io';
import 'design.dart';
import 'package:flutter/material.dart';

class DoctorHomePage extends StatefulWidget {
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override

  Design dh = new Design();
  FlatButton setFunctionButton(String watsIn,double ht, double wd,double fontSize) {
    return FlatButton(
      onPressed: () {},
      child: Container(
        child: Center(
          child: Text(
            watsIn,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ),
        height: ht,
        width: wd,
        padding: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.redAccent,
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: dh.topBar('Home'),
      bottomNavigationBar:dh.bottomNav(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                setFunctionButton('Treat Patient',150,320,20),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                setFunctionButton('My Attending History',300,150,20),
                Container(
                  child: Text(
                    'It\'s a beautiful day to save lives!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  height: 190,
                  width: 150,
                  padding: EdgeInsets.fromLTRB(25,20,25,10),
                ),
              ],
            ),
              ],
            ),
        ),
      );
  }
}