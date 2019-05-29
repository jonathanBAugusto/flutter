import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class TodoItem {
  String task;
  bool ok;

  TodoItem(String task, bool ok) {
    this.task = task;
    this.ok = ok;
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = [];
  Color _cbground = Colors.greenAccent;
  Color _ctext = Colors.white;
  int count = 0;
  final _edDescription = TextEditingController();

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newTodo = Map();
      newTodo["title"] = _edDescription.text;
      _edDescription.text = "";
      newTodo["ok"] = false;
      _toDoList.add(newTodo);
    });
    // _saveFile();
  }

  void setColorTheme() {
    setState(() {
      switch (count) {
        case 0:
          _cbground = Colors.greenAccent;
          _ctext = Colors.white;
          break;
        case 1:
          _cbground = Colors.blueAccent;
          _ctext = Colors.white;
          break;
        case 2:
          _cbground = Colors.purpleAccent;
          _ctext = Colors.white;
          break;
        case 3:
          _cbground = Colors.redAccent;
          _ctext = Colors.white;
          break;
      }
      if (count < 3)
        count++;
      else
        count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return scaf("Todo List ;)", true);
  }

  //Body
  Scaffold scaf(String title, bool centertitle) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: _cbground,
        centerTitle: centertitle,
      ),
      body: columnBody(),
    );
  }

  //-Body
  Column columnBody() {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(17, 1, 1, 7),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                    labelText: "New task",
                    labelStyle: TextStyle(color: _cbground),
                  ),
                  controller: _edDescription,
                )),
                RaisedButton(
                  color: _cbground,
                  child: Text("ADD"),
                  textColor: _ctext,
                  onPressed: _addToDo,
                ),
              ],
            )),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: _toDoList.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_toDoList[index].task),
                  value: _toDoList[index].ok,
                  secondary: CircleAvatar(
                    child:
                        Icon(_toDoList[index].ok ? Icons.check : Icons.error),
                  ),
                  onChanged: (bool value) {
                    setState(() {
                      _toDoList[index]["ok"] = value;
                    });
                  },
                );
              }),
        ),
        RaisedButton(
          color: _cbground,
          child: Text("ChangeColor"),
          textColor: _ctext,
          onPressed: setColorTheme,
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
