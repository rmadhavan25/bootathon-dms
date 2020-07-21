import 'dart:developer';
import 'dart:io';
import 'userRegister.dart';
import 'package:flutter/material.dart';

class Design{
  TextFormField setLoginFormField(String labelTxt,String regx,String fieldName)
  {
    bool hide;
    if(fieldName=='password' )
    {
      hide = true;
    }
    else{
      hide = false;
    }
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelTxt,
      ),
      obscureText: hide,
      validator: (value){
        Pattern pattern = regx;
        RegExp regex = new RegExp(pattern);
        if(value.isEmpty){
          return 'please enter a $fieldName';
        }
        if (!regex.hasMatch(value)){
          return 'Enter a valid $fieldName ';
        }
        else {
          return null;
        }
      },
    );
  }
  TextStyle expStyle(Color color,double size){
    return TextStyle(
      letterSpacing: 1,
      color: color,
      fontSize: size,
      fontFamily: 'Questrial',
      fontWeight: FontWeight.bold,
    );
  }

  AppBar topBar(String text){
    return AppBar(
      title: Text(
        text,
        style: expStyle(Colors.white, 20),
      ),
      backgroundColor: Colors.redAccent,
    );
  }

  BottomNavigationBar bottomNav()
  {
    return BottomNavigationBar(
      backgroundColor: Colors.red.shade200,
      currentIndex: 1, // this will be set when a new tab is tapped
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.settings),
          title: new Text('settings'),
        ),
      ],
    );
  }


}