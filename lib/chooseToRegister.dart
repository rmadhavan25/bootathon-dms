import 'dart:developer';
import 'dart:io';
import 'doctorRegister.dart';
import 'design.dart';
import 'userRegister.dart';

import 'package:flutter/material.dart';

class ChooseToRegister extends StatefulWidget {
  @override


  _ChooseToRegisterState createState() => _ChooseToRegisterState();
}

class _ChooseToRegisterState extends State<ChooseToRegister> {
  @override

  Design ctr = new Design();
  Column setIconImage(String iconName,String iconDescription,double iconDescriptionSize){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Image.asset('images/$iconName.png'),
          iconSize: 100,
          onPressed: () {
            if(iconName=='maledoctor') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoctorRegister()),
              );
            }
            else{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserRegister()),
              );
            }
          },
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          iconDescription,
          style: ctr.expStyle(Colors.black,iconDescriptionSize),
        ),
      ],

    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ctr.topBar('CHOOSE ONE'),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              setIconImage('maledoctor', 'I am a doctor!',20),
              setIconImage('malepatient','I am a patient!',20),
            ],
          ),
        ),
      ),
    );
  }
}
