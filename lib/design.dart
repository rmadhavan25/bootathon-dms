
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

}