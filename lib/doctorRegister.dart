import 'dart:developer';
import 'dart:io';
import 'userLogin.dart';
import 'design.dart';
import 'package:flutter/material.dart';

class DoctorRegister extends StatefulWidget {
  @override
  _DoctorRegisterState createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
  final _doctorRegisterKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  @override

  Design dr = new Design();
  FlatButton setDoctorRegisterButton(String action)
  {
    return FlatButton(
      onPressed: () {
        if(action=='Sign up')
        {
          if (_doctorRegisterKey.currentState.validate()) {
            final snackBar = SnackBar(
              content: Text('Registered Successfully'),
              duration: Duration(seconds: 5),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          }
        }
        else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      },
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Text(
          action,
          style: TextStyle(
            letterSpacing: 1,
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Bangers',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  TextFormField setFormField(String labelTxt, String regx, String fieldName) {
    String suffixText;
    TextEditingController control;
    bool hide;
    if (fieldName == 'password' || fieldName=='repassword') {
      suffixText = null;
      hide = true;
      control = null;
      if(fieldName == 'password')
        {
          control = _pass;
        }
    } else {
      suffixText = null;
      hide = false;
    }
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelTxt,
        suffixText: suffixText,
      ),
      obscureText: hide,
      controller: control,
      validator: (value) {
        Pattern pattern = regx;
        RegExp regex = new RegExp(pattern);
        if(fieldName=='repassword'){
          if(value!=_pass.text){
            return 'passwords didnt match!!';
          }
        }
        if (value.isEmpty) {
          return 'please enter a $fieldName';
        }
        if (!regex.hasMatch(value)) {
          return 'Enter a valid $fieldName ';
        } else {
          return null;
        }
      },
    );
  }
  Column createTextFormField(double bottomSpace, String labelTxt, String regx, String fieldName) {
    return Column(
      children: <Widget>[
        setFormField(labelTxt, regx, fieldName),//calling setFormField Function
        SizedBox(
          height: bottomSpace,
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:dr.topBar('REGISTER'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _doctorRegisterKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    createTextFormField(20, 'Enter your name', r'[A-Z]', 'name'),
                    createTextFormField(20, 'Phone.no', r'^\d{10}$', 'phone'),
                    createTextFormField(20, 'email@example.com', r'^(\w)+@[a-z]+.com$', 'email'),
                    createTextFormField(20, 'Doctor License ID', r'^[0-9]+$', 'doctorID'),
                    createTextFormField(20, 'password', r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$', 'password'),
                    createTextFormField(20, 'Re-type password', r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$', 'repassword'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'aleady an user?',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Builder(
                          builder: (context) => setDoctorRegisterButton('Sign up'),
                        ),
                        setDoctorRegisterButton('Go to login page'),
                      ],
                    ) //buttons
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
