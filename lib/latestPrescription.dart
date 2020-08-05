import 'dart:convert';
import 'package:dms/design.dart';
import 'package:flutter/material.dart';
import 'usergetrecord.dart';
import 'package:http/http.dart'as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'pdfpreview.dart';
String tokens1;
String patientphone;
UserRecord userlast;
String urlPDFPath="";
int flag = 0;
class ViewPatientlatest extends StatefulWidget{
  ViewPatientlatest(String tokens,String phone){
    tokens1 = tokens;
    patientphone = phone;
  }
  @override
  ViewPatientlateststate createState() => ViewPatientlateststate(tokens1);
}



Future<List<UserRecord>> records()async{
  final response = await http.get("http://10.0.2.2:8000/get-record",
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
    if(data.length==0)
      {
        flag = 1;
      }
    users = data.map((i) => UserRecord.fromJson(i)).toList();
    print(users);
    for(var i in users){
      userlast = i;
      print(userlast);
    }

    return users;
  }
  else
  {
    return List<UserRecord>();
  }
}



Future<File> loadPdf(String mainurl) async{
  final response = await http.get(mainurl,headers: {
    'Authorization' : 'Token '+tokens1
  });
  var bytes = response.bodyBytes;
  var dir = await getApplicationDocumentsDirectory();
  File file = File("${dir.path}/mypdfonline.pdf");

  File urlFile = await file.writeAsBytes(bytes);
  return urlFile;
}

List<UserRecord> users;
String mainurl;
bool _isLoading = true;

class ViewPatientlateststate extends State<ViewPatientlatest>{
  String tok;
  ViewPatientlateststate(this.tok);
  String localpath;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new Design().topBar("LAST PRESCRIPTION"),
      body: SafeArea(
          child: FutureBuilder(
            future: records(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              return
               flag==1?
                  Container(
                    child: Center(
                        child: Text('No records')
                    ),
                  ):
                    ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: <Widget>[
                        Card(
                          child:ListTile(
                              title:Text(userlast.recordName),
                              subtitle: Text(userlast.doctorId.doctor.name),
                              enabled: true,
                              onTap: ()async{
                                mainurl = "http://10.0.2.2:8000" + userlast.record;
                                print(mainurl);
                                await loadPdf(mainurl).then((f){
                                  setState(() {
                                    urlPDFPath = f.path;
                                  });
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PDFView(urlPDFPath)),
                                );
                              },
                        ),
                        )
                      ],
                  );
              }
          ),
        ),
    );
  }
}
