import 'dart:developer';
import 'dart:io';
import 'userHome.dart';
import 'doctorHome.dart';
import 'chooseToRegister.dart';
import 'design.dart';
import 'userLoginModel.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override

  _LoginPageState createState() => _LoginPageState();
}


String Response;

int flag = 0;


Future<UserLoginModel> loginUser(String phone , String password)async{
  final String apiUrl = "http://10.0.2.2:8000/login";
  final response = await http.post(apiUrl,body:{
    'phone' : phone,
    'password' : password,
  }
  );
  print(response.body);
  print(response.statusCode);
  if(response.statusCode == 200)
  {
    flag = 0;
    final String responseString = response.body;
    return userLoginModelFromJson(responseString);
  }
  if(response.statusCode==400)
    {
      flag = 1;
      Response = response.body;
      print(Response);
      print(flag);

    }

}

class _LoginPageState extends State<LoginPage> {
  final _userLoginKey = GlobalKey<FormState>();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  UserLoginModel _user;
  String token;
  int f = flag;
  @override

  _onAlertWithCustomContentPressed(context) {
    Alert(
        context: context,
        title: 'Invalid Login Credential',
        desc: Response,
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
        ]).show();
  }


  FlatButton setLoginButton(String action)
  {
    return FlatButton(
      onPressed: () async{
        if(action=='Sign in')
        {
          if(_userLoginKey.currentState.validate()){
            final String phone = _phone.text;
            final String password = _pass.text;

            final UserLoginModel user = await loginUser(phone,password);
            setState(() {
              _user = user;
              f = flag;
            });

            if(f==1){
              setState(() {
                f = 0;
              });
              print("something wrong");
              _onAlertWithCustomContentPressed(context);
            }
            else{
              this.token = _user.token;
              if(_user.user.userType=='Doctor'){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorHomePage(token)),
                );
              }
              if(_user.user.userType=='Patient'){
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserHomePage(phone,token)),
                );
              }
            }

          }
        }
        else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ChooseToRegister()),
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

  TextFormField setLoginFormField(String labelTxt,String regx,String fieldName)
  {
    TextEditingController control;
    bool hide;
    if(fieldName=='password' )
    {
      hide = true;
      control = _pass;
    }
    else{
      hide = false;
    }
    if(fieldName=='phone'){
      control = _phone;
    }
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelTxt,
      ),
      obscureText: hide,
      controller: control,
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
  Design login = new Design();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _userLoginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Tab(
                      icon: Image.asset('images/medical-record.png'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    setLoginFormField('phone number',r'^\d{10}$','phone'),
                    SizedBox(
                      height: 40,
                    ),
                    setLoginFormField('Enter your password', r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$', 'password'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        setLoginButton('Register'),
                        setLoginButton('Sign in'),
                      ],
                    )//buttons
                  ],
                ),//loginFields
              ),
            ),
          ),
        ),
      ),
    );
  }
}