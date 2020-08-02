import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'design.dart';
import'attendingModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:io';


class MyAttendingHistory extends StatefulWidget {
  @override
  _MyAttendingHistoryState createState() => _MyAttendingHistoryState(token);
  String token;
  MyAttendingHistory(this.token);
}

class _MyAttendingHistoryState extends State<MyAttendingHistory> {

  String token;
  _MyAttendingHistoryState(this.token);


  Future<List<AttendingModel>> _getRecords()async{
    final response = await http.get("http://10.0.2.2:8000/get-history",headers:{
      'Authorization': 'Token '+token
    });
    if(response.statusCode==200)
      {
        List<AttendingModel> history = [];
        var data = json.decode(response.body) as List;
        history = data.map((i) => AttendingModel.fromJson(i)).toList();
        return history;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new Design().topBar('My Attending History'),
      body: SafeArea(
        child: Center(
          child: Container(
            child: FutureBuilder(
              future: _getRecords(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.data == null){
                  return Container(
                    child: Center(
                      child: Text('loading...')
                    ),
                  );
                }
                else{
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        return ListTile(
                          leading: Icon(
                            Icons.insert_drive_file
                          ),
                          title: Text(snapshot.data[index].recordName),
                          subtitle: Text(snapshot.data[index].createdAt.toString()),
                        );
                      }
                  );
                }
              }
            ),
          ),
        ),
      ),
    );
  }
}

