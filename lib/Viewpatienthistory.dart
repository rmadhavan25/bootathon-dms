import 'dart:convert';
import 'package:flutter/material.dart';
import 'design.dart';
import 'usergetrecord.dart';
import 'package:http/http.dart'as http;
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'pdfpreview.dart';
String tokens1;
String patientphone;
int flag;
String urlPDFPath="";
class ViewPatient extends StatefulWidget{
  ViewPatient(String tokens,String phone){
    tokens1 = tokens;
    patientphone = phone;
  }
  @override
  ViewPatientstate createState() => ViewPatientstate(tokens1);
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
    if(data.length<1)
      {
        flag = 1;
      }
    else{
      flag = 0;
    }
    users = data.map((i) => UserRecord.fromJson(i)).toList();
    print(users);
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
PDFDocument doc;
class ViewPatientstate extends State<ViewPatient>{
  String toke;
  ViewPatientstate(this.toke);
  String localpath;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new Design().topBar("MY HISTORY"),
      body: SafeArea(
          child: FutureBuilder(
            future: records(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
             if(snapshot.data==null){
                print("Loading");
                return Container(
                  child: Center(
                      child: Text('loading')
                  ),
                );
             }
             else
             {
                  if(flag==1){
                    return Container(
                      child: Center(
                          child: Text('no records')
                      ),
                    );
                  }
                  else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(snapshot.data[index].recordName),
                              subtitle: Text(snapshot.data[index].doctorId
                                  .doctor.name),
                              enabled: true, onTap: () async {
                              print("SUCCESS");
                              mainurl = "http://10.0.2.2:8000" +
                                  snapshot.data[index].record;
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
                          );
                        }
                    );
                  }
             }
            }
          ),
        ),
    );
  }
}
