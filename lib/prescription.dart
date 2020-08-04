
import 'package:dms/treatPatient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'dart:async';
import 'prescription_table.dart';
import 'package:path_provider/path_provider.dart';
import 'PdfPreviewScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:http/http.dart'as http;
import 'uploadModal.dart';



var timeDilation1 = timeDilation;
var timeDilation2 = timeDilation;
var timeDilation3 = timeDilation;
var timeDilation4 = timeDilation;

class Prescription extends StatefulWidget {
  @override
  _PrescriptionState createState() => _PrescriptionState(phone,token);
  String phone;
  String token;
  Prescription(this.phone,this.token);
}

Future<UploadModal>  uploadRecord(String phone,PdfDocument document,String token,String fileName)async{

  final String aurl = "http://10.0.2.2:8000/upload-record/$phone/$fileName.pdf";
  final uri = Uri.parse(aurl);
  var request = new http.MultipartRequest("PUT", uri);

  request.headers['Authorization'] = "Token "+token;

  request.files.add(new http.MultipartFile.fromBytes('file', document.save()));
  request.send().then((response) {
    if (response.statusCode == 200) print(response.statusCode);
    else{
      print(response.statusCode);
    }
  });
}

class _PrescriptionState extends State<Prescription> {

  String phone,token;
  _PrescriptionState(this.phone,this.token);
  TextEditingController _fileName = new TextEditingController();


  _onAlertWithCustomImagePressed1(context){
    Alert(
        context: context,
        title: "DONE",
        image: Image.asset('images/greentick.png'),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: (){
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TreatPatient(phone,token)
              )
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

  _onAlertWithCustomContentPressed(context) {
    Alert(
        context: context,
        title: 'File Name',
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'patientName_patientPhone',
              ),
              controller: _fileName,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: ()async{
              uploadRecord(phone, document,token,_fileName.text);
              _onAlertWithCustomImagePressed1(context);
            },
            child: Text(
              "okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),

          )
        ]).show();
  }

  @override

  bool Treat = false;
  var mediController = TextEditingController();
  var dayController = TextEditingController();
  var medifocus = FocusNode();
  bool morningcheck;
  bool afternooncheck;
  bool eveningcheck;
  bool nightcheck;
  PdfDocument document = PdfDocument();
  PdfGrid grid = PdfGrid();
  var records = <prescription_table>[];
  DataTable gentable(){
    return DataTable(
      dataRowHeight: 100.0,
      columnSpacing: 23.0,
      columns: precriptionColumns
          .map(
            (String column) => DataColumn(
          label: Text(column),
        ),
      )
          .toList(),
      rows: records
          .map((prescription_table table) => DataRow(
        cells: [
          DataCell(
            Text(table.Medicine),
            showEditIcon: false,
            placeholder: false,
          ),
          DataCell(
            Text(table.Days),
            showEditIcon: false,
            placeholder: false,
          ),
          DataCell(
            Text(table.Morning.toString()),
            showEditIcon: false,
            placeholder: false,
          ),
          DataCell(
            Text(table.Afternoon.toString()),
            showEditIcon: false,
            placeholder: false,
          ),
          DataCell(
            Text(table.Evening.toString()),
            showEditIcon: false,
            placeholder: false,
          ),
          DataCell(
            Text(table.Night.toString()),
            showEditIcon: false,
            placeholder: false,
          ),

        ],
      ))
          .toList(),
    );
  }
  void tabeldata(){
    String myTableAsString = gentable().toString();
    print(myTableAsString);
  }


  Future previewpdf(PdfDocument document) async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath");

    File('record.pdf').writeAsBytes(document.save());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 6,
                child:SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0,top: 20.0,bottom: 10.0),
                          child: TextFormField(
                            focusNode: medifocus,
                            onChanged: (text){print(text);},
                            controller: mediController,
                            decoration: InputDecoration(
                              labelText: "Medicine Name",
                              labelStyle: TextStyle(
                                  fontFamily: "CenturyGothic",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 30.0,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0,bottom: 10.0),
                          child: TextFormField(

                            controller: dayController,
                            decoration: InputDecoration(
                              labelText: "Days",
                              labelStyle: TextStyle(
                                  fontFamily: "CenturyGothic",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 10.0,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                            ),

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0,bottom: 10.0),
                          child: CheckboxListTile(
                            title: Text('Morning'),
                            value: timeDilation1 != 1.0,
                            onChanged: (bool value) {
                              setState((){
                                timeDilation1 = value ? 2.0 : 1.0;
                                morningcheck = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0,bottom: 10.0),
                          child: CheckboxListTile(
                            activeColor: Colors.red,
                            title: Text('Afternoon'),
                            value: timeDilation2 != 1.0,
                            onChanged: (bool value) {
                              setState(() {
                                timeDilation2 = value ? 2.0 : 1.0;
                                afternooncheck = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0,bottom: 10.0),
                          child: Container(
                            decoration: BoxDecoration(

                            ),
                            child: CheckboxListTile(
                              activeColor: Colors.orange,
                              title: Text('Evening'),
                              value: timeDilation3 != 1.0,
                              onChanged: (bool value) {
                                setState(() {
                                  timeDilation3 = value ? 2.0 : 1.0;
                                  eveningcheck = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0,bottom: 10.0),
                          child: CheckboxListTile(
                            activeColor: Colors.black,
                            title: Text('Night'),
                            value: timeDilation4 != 1.0,
                            onChanged: (bool value) {
                              setState(() {
                                timeDilation4 = value ? 2.0 : 1.0;
                                nightcheck = value;

                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                ),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                            height: 50.0,
                            width: 120.0,
                            child: RaisedButton(
                              onPressed: () {
                                medifocus.requestFocus();
                                setState(() {
                                  records.add(prescription_table(Medicine: mediController.text,Days: dayController.text,Morning: morningcheck,Afternoon: afternooncheck,Evening: eveningcheck,Night: nightcheck));
                                  mediController.clear();
                                  dayController.clear();
                                  timeDilation1 = 1.0;
                                  timeDilation2 = 1.0;
                                  timeDilation3 = 1.0;
                                  timeDilation4 = 1.0;

                                });
                              },

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                    color: Colors.black,
                                    // width: 10.0,
                                  )),
                              child: Text(
                                'Add Row',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "CenturyGothic",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              textColor: Colors.white,
                              elevation: 5,
                            )

                        ),
                        SizedBox(
                          height : 50.0,
                          width: 30.0,
                        ),
                        SizedBox(
                            height: 50.0,
                            width: 120.0,
                            child: RaisedButton(
                              onPressed: () async{
                                document = PdfDocument();
                                grid = PdfGrid();
                                grid.dataSource = gentable();
                                grid.draw(
                                    page: document.pages.add(),
                                    bounds:
                                    const Rect.fromLTWH(0, 0, 0, 0));
                                await previewpdf(document);
                                Directory documentDirectory = await getApplicationDocumentsDirectory();
                                String documentPath = documentDirectory.path;
                                File file = File("$documentPath/record.pdf");
                                file.writeAsBytes(document.save());
                                String fullPath = "$documentPath/record.pdf";
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => PdfPreviewScreen(path:fullPath)
                                )
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                    color: Colors.black,
                                  )),
                              child: Text(
                                'Preview',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "CenturyGothic",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              textColor: Colors.white,
                              elevation: 5,
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 50.0,
                        width: 120.0,
                        child: RaisedButton(
                          onPressed: () async{
                            document = PdfDocument();
                            grid = PdfGrid();
                            grid.dataSource = gentable();
                            grid.draw(
                                page: document.pages.add(),
                                bounds:
                                const Rect.fromLTWH(0, 0, 0, 0));
                            _onAlertWithCustomContentPressed(context);
                          },

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: Colors.black,
                              )),
                          child: Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "CenturyGothic",
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          textColor: Colors.white,
                          elevation: 5,
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

