import 'dart:developer';
import 'dart:io';
import 'userLogin.dart';
import 'design.dart';
import 'usermodel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DoctorRegister extends StatefulWidget {
  @override
  _DoctorRegisterState createState() => _DoctorRegisterState();
}
String Response;

int flag = 0;
Future<UserModel>  verifyUser(String phone,String email,String licence)async{
  final String apiUrl = "http://10.0.2.2:8000/verify-user";

  final response = await http.post(apiUrl,body: {
    "phone": phone,
    "email": email,
    "licence_no" : licence,
    "user_type": 'Doctor',
  }
  );
//  print(response.body);
//  print(response.statusCode);
  if(response.statusCode == 200)
  {
    flag = 0;
    final String responseString = response.body;
    return userModelFromJson(responseString);
  }
  print(response.statusCode);
  if(response.statusCode==400)
  {
    flag = 1;
    Response = response.body;
    print(Response);
    print(flag);

  }
}

Future<UserModel> registerUser(String phone , String password , String otp, String name, String licence, String gender,String email)async{
  final String apiUrl = "http://10.0.2.2:8000/create-user";
  final response = await http.post(apiUrl,body:{
    'phone' : phone,
    'password' : password,
    'OTP' : otp,
    'user_type' : 'Doctor',
    'gender' : gender,
    'name' : name,
    'licence_no' : licence,
    'email' : email,
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

class _DoctorRegisterState extends State<DoctorRegister> {
  final _doctorRegisterKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _phno = TextEditingController();
  final TextEditingController _otpValue = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _licence_no = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  UserModel _user;
  String selectGender="";
  List<String> gender =[
    'Male',
    'Female',
  ];
  int f = flag;

  @override



 _onAlertWithCustomImagePressed1(context) {
    Alert(
        context: context,
        title: 'REGISTERED SUCCESSFULLY',
        image: Image.asset('images/greentick.png'),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: (){
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage()),
              );
            },
            child: Text(
              "close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),

          )
        ]
    ).show();
  }
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
        title: '${_user.detail}',
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'enter otp',
              ),
              controller: _otpValue,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: ()async{
              final String phone = _phno.text;
              final String password = _pass.text;
              final String otp = _otpValue.text;
              final String name = _name.text;
              final String licence = _licence_no.text;
              final String gender = _gender.text;
              final String email = _email.text;

              final UserModel user = await registerUser(phone,password,otp,name,licence,gender,email);
              setState(() {
                _user = user;
              });
              Navigator.pop(context);
              if(_user!=null){
                _onAlertWithCustomImagePressed1(context);
              }
              else{
                _onAlertWithCustomImagePressed2(context);
              }
            },
            child: Text(
              "verify",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),

          )
        ]).show();
  }
  _onAlertWithCustomContentPressed1(context) {
    Alert(
        context: context,
        title: 'Invalid credentials',
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

  Design dr = new Design();

  FlatButton setDoctorRegisterButton(String action)
  {
    return FlatButton(
      onPressed: ()async {
        if(action=='Sign up')
        {
          if (_doctorRegisterKey.currentState.validate()) {
            final String phone = _phno.text;
            final String email = _email.text;
            final String licence = _licence_no.text;

            final UserModel user = await verifyUser(phone,email,licence);
            setState(() {
              _user = user;
              f = flag;
            });
            if(f==1){
              setState(() {
                flag = 0;
                f = 0;
              });
              print("something wrong");
              _onAlertWithCustomContentPressed1(context);
            }
            else{
              if(_user!=null){
                _onAlertWithCustomContentPressed(context);
              }
            }


          }
        }
        else{
          Navigator.of(context).popUntil((route) => route.isFirst);

          Navigator.pushReplacement(
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
    if(fieldName=='phone')
    {
      control = _phno;
    }
    if(fieldName == 'name')
    {
      control = _name;
    }
    if(fieldName=='doctorID')
    {
      control = _licence_no;
    }
    if(fieldName=='email')
      {
        control = _email;
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    createTextFormField(20, 'Enter your name', r'[A-Z]', 'name'),
                    createTextFormField(20, 'Phone.no', r'^\d{10}$', 'phone'),
                    createTextFormField(20, 'email@example.com', r'^(\w)+@[a-z]+.com$', 'email'),
                    createTextFormField(20, 'Doctor License ID', r'^[0-9]+$', 'doctorID'),
                    createTextFormField(20, 'password', r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$', 'password'),
                    createTextFormField(20, 'Re-type password', r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$', 'repassword'),
                    DropDownField(
                      controller: _gender,
                      labelText: 'Gender',
                      enabled: true,
                      hintText: 'choose a Gender',
                      items: gender,
                      onValueChanged: (value){
                        setState(() {
                          selectGender = value;
                        });
                      },
                    ),
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
                    ), //buttons

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
