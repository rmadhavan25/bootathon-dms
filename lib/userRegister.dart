import 'dart:developer';
import 'dart:io';
import 'package:dms/usermodel.dart';

import 'design.dart';
import 'package:dms/userLogin.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

//FlutterOtp otp = FlutterOtp();
Future<UserModel>  createUser(String phone)async{
  final String apiUrl = "http://10.0.2.2:8000/verify-user";

  final response = await http.post(apiUrl,body: {
    "phone": phone
  }
  );
  print(response.body);
  print(response.statusCode);
  if(response.statusCode == 200)
    {
      final String responseString = response.body;
      return userModelFromJson(responseString);
    }
  else{
    return null;
  }
}

class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _userRegisterKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _phno = TextEditingController();
  //final TextEditingController _otpValue = TextEditingController();
  final TextEditingController _email = TextEditingController();
  UserModel _user;

  @override

//  _onAlertWithCustomImagePressed1(context) {
//    Alert(
//      context: context,
//      title: "REGISTRATION SUCCESS",
//      desc: '${_user.token}',
//      //image: Image.asset('images/greentick.png'),
//      buttons: [
//        DialogButton(
//          color: Colors.black,
//          onPressed: (){
//            Navigator.pop(context);
//          },
//          child: Text(
//            "close",
//            style: TextStyle(color: Colors.white, fontSize: 20),
//          ),
//
//        )
//      ]
//    ).show();
//  }
  _onAlertWithCustomImagePressed2(context) {
    Alert(
        context: context,
        title: "REGISTRATION FAILED",
        desc: 'invalid OTP',
        image: Image.asset('images/redcross.png'),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text(
              "close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),

          )
        ]
    ).show();
  }

  _onAlertWithCustomContentPressed(context) {
    Alert(
        context: context,
        title: "check inbox for OTP",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: '${_user.detail}',
              ),
              //controller: _otpValue,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: (){
                Navigator.pop(context);
                //_onAlertWithCustomImagePressed1(context);
              },
            child: Text(
              "verify",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),

          )
        ]).show();
  }
  FlatButton setUserRegisterButton(String action){
    return FlatButton(
      onPressed: () async {
        if(action=='sign up'){
          if (_userRegisterKey.currentState.validate()) {
//            otp.sendOtp(_phno.text);
          final String email = _email.text;
          final String password = _pass.text;
          final String phone = _phno.text;

          final UserModel user = await createUser(phone);
          setState(() {
            _user = user;
          });
          _onAlertWithCustomContentPressed(context);


          }
        }
        else{
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage()),
          );
        }

      },
      color: Colors.black,
      child: Text(
        action,
        style: TextStyle(
          letterSpacing: 0.5,
          color: Colors.white,
          fontSize: 15,
          fontFamily: 'Bangers',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Design ur = new Design();

  TextFormField setFormField(String labelTxt, String regx, String fieldName) {
    TextEditingController control;
    bool hide;
    if (fieldName == 'password' || fieldName=='repassword') {
      hide = true;
      control = null;
      if(fieldName == 'password')
      {
        control = _pass;
      }
    } else {
      hide = false;
    }
    if(fieldName=='phone')
      {
        control = _phno;
      }
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelTxt,
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
      appBar: ur.topBar('REGISTER'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _userRegisterKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    createTextFormField(20, 'Enter your name', r'[A-Z]', 'name'),
                    createTextFormField(20, 'Phone.no', r'^\d{10}$', 'phone'),
                    createTextFormField(20, 'email@example.com', r'^(\w)+@[a-z]+.com$', 'email'),
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
                          builder: (context) => setUserRegisterButton('sign up'),
                        ),
                        setUserRegisterButton('go to login page'),
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
