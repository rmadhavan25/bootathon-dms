import 'dart:convert';
import 'package:flutter/material.dart';
import 'design.dart';
import 'usergetrecord.dart';
import 'package:http/http.dart'as http;
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

String tokens1;
String patientphone;

class View extends StatefulWidget{
  View(String tokens,String phone){
    tokens1 = tokens;
    patientphone = phone;
  }
  @override
  Viewstate createState() => Viewstate(); 
}



Future<List<UserRecord>> records()async{
  final response = await http.get("http://10.0.2.2:8000/get-record/"+patientphone,
  headers: {
    "Authorization":"Token "+tokens1,
  },
  );
  List<UserRecord> users = [];
  print(response.body);
  print(response.statusCode);
  if(response.statusCode==200)
  {
    print("Accepted");
    var data = json.decode(response.body) as List;
    users = data.map((i) => UserRecord.fromJson(i)).toList();
    print("BYE");
    print(users);
    return users;

  }
  else
  {
    print("HI");
    return List<UserRecord>();
  }
}



 Future<PDFDocument> loadPdf() async{
   if(await canLaunch(mainurl)){
     await launch(mainurl,headers: {
       "Authorization":"Token "+tokens1
     }
     );
   }
}

List<UserRecord> users;
String mainurl;
bool _isLoading = true;
PDFDocument doc;
String localpath;

class Viewstate extends State<View>{

  String localpath;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new Design().topBar("PATIENT HISTORY"),
      body: SafeArea(
          child: Container(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: records(),
              builder: (BuildContext context,AsyncSnapshot snapshot){
               if(snapshot.data==null){
                  print("EMPTY");
                  return Container(
                    child: Center(
                      child: Text("EMPTY",style: TextStyle(color: Colors.black,fontSize: 40)
                    ),
                  )
                );
               }
               else
               {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context,int index){
                        return Card(
                            child: ListTile(
                              title:Text(snapshot.data[index].recordName),
                              subtitle: Text(snapshot.data[index].doctorId.doctor.name),
                              enabled: true,onTap: ()async{
                                print("SUCCESS");
                                mainurl = "http://10.0.2.2:8000"+snapshot.data[index].record;
                                await loadPdf();
                          },
                        ),
                        );
                      }
                  );
               }
              }
            )
            ),
        ),
      ),
    );
  }
}
