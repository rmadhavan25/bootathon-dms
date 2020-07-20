import 'dart:developer';
import 'dart:io';
import 'design.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override

  Design uh = new Design();
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
      backgroundColor: Colors.white,
      appBar: uh.topBar('Home'),
      bottomNavigationBar: uh.bottomNav(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                setFunctionButton('My Medical History',130,130,18),
                setFunctionButton('My Medicines',130,130,18),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                setFunctionButton('Latest Prescription',130,130,18),

                Container(
                  child: Text(
                    'Hope you are doing well !',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  height: 190,
                  width: 130,
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 10),
                ),
              ],
            ),//button and welcome text
          ],
        ),
      ),
    );
  }
}
