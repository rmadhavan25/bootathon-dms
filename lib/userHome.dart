import 'dart:developer';
import 'dart:io';
import 'package:dms/latestprescription.dart';
import 'package:dms/userLogin.dart';
import 'Viewpatienthistory.dart';
import 'design.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState(phone,token);
  String phone,token;

  UserHomePage(this.phone,this.token);
}

class _UserHomePageState extends State<UserHomePage> {
  String phone,token;

  _UserHomePageState(this.phone,this.token);
  @override

  Design uh = new Design();
  FlatButton setFunctionButton(String watsIn,double ht, double wd,double fontSize) {
    return FlatButton(
      onPressed: () {
        if(watsIn=='Latest Prescription'){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewPatientlatest(token,phone)),
          );
        }
        else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewPatient(token,phone)),
          );
        }
      },
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.redAccent,
              ),
            ),
            title: new Text(
                'Home',
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: new IconButton(
              icon: Image.asset('images/exit.png'),
              onPressed: (){
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },

            ),
            title: new Text('logout'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                setFunctionButton('My Medical History',150,320,20),
                //setFunctionButton('My Medicines',130,130,18),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                setFunctionButton('Latest Prescription',300,150,20),

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
