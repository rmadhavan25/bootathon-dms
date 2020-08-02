import 'dart:developer';
import 'dart:io';
import 'userRegister.dart';
import 'package:flutter/material.dart';

class Design{

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
      currentIndex: 0, // this will be set when a new tab is tapped
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