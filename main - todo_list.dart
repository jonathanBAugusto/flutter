import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = [];

  @override
  Widget build(BuildContext context) {
    return scaf("Todo List ;)", Colors.greenAccent, true);
  }

  //Body
  Scaffold scaf(String title, Color bGround, bool center_title){
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: bGround,
        centerTitle: center_title,
      ),
      body: column_Body(),
    );
  }
  //-Body
  Column column_Body(){
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(17, 1, 1, 7),
          child: Row(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "New task",
                  labelStyle: TextStyle(color: Colors.greenAccent),
                ),
              )
            ],
          )
        )
      ],
    );
  }
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveFile() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readFile() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
