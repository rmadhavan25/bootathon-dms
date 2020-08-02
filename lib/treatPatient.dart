
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'design.dart';
import 'Viewhistorydoctor.dart';
import 'prescription.dart';


Design dh = new Design();

// ignore: camel_case_types
class TreatPatient extends StatefulWidget {
  @override
  _TreatPatientState createState() => _TreatPatientState(phone,token);
  String phone,token;
  TreatPatient(this.phone,this.token);

}



class _TreatPatientState extends State<TreatPatient> {
  String phone,token;
  _TreatPatientState(this.phone,this.token);


  FlatButton setFunctionButton(String watsIn,double ht, double wd,double fontSize) {
    return FlatButton(
      onPressed: () {
        if(watsIn=='Write Prescription'){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Prescription(phone,token)),
          );
        }
        else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => View(token,phone)),
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
      appBar: dh.topBar('Treat Patient'),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                setFunctionButton('Write Prescription',150,320,20),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                setFunctionButton('Get History',150,320,20),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}