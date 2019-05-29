import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
  Color _cbground2 = Colors.lightGreen;
  Color _ctext = Colors.white;
  final _edDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _setColorTheme();
    });
    _readFile().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  void _toDoAdd() {
    setState(() {
      Map<String, dynamic> newTodo = Map();
      newTodo["title"] = _edDescription.text.toString();
      _edDescription.text = "";
      newTodo["ok"] = false;
      _toDoList.add(newTodo);
      _saveFile(false);
    });
  }

  void _deleteAll(bool del) => setState(() {
        _saveFile(del);
      });

  void _setColorTheme() {
    setState(() {
      var random = Random.secure();
      int count = random.nextInt(6);
      switch (count) {
        case 0:
          _cbground = Colors.greenAccent;
          _cbground2 = Colors.lightGreen;
          _ctext = Colors.white;
          break;
        case 1:
          _cbground = Colors.blueAccent;
          _cbground2 = Colors.lightBlue;
          _ctext = Colors.white;
          break;
        case 2:
          _cbground = Colors.deepPurple;
          _cbground2 = Colors.purple;
          _ctext = Colors.white;
          break;
        case 3:
          _cbground = Colors.redAccent;
          _cbground2 = Colors.orangeAccent;
          _ctext = Colors.white;
          break;
        case 4:
          _cbground = Colors.black;
          _cbground2 = Colors.grey;
          _ctext = Colors.white;
          break;
        case 5:
          _cbground = Colors.black45;
          _cbground2 = Colors.black38;
          _ctext = Colors.black87;
          break;
        case 6:
          _cbground = Colors.black38;
          _cbground2 = Colors.black26;
          _ctext = Colors.cyan;
          break;
      }
    });
  }

  SimpleDialog dialog(String title) {
    return SimpleDialog(
      backgroundColor: _cbground,
      title: Text(title),
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(child: Text("")),
            RaisedButton(
              color: _cbground,
              child: Text("Sim"),
              textColor: _ctext,
              onPressed: _pressedSim,
            ),
            RaisedButton(
              color: _cbground,
              child: Text("Não"),
              textColor: _ctext,
              onPressed: _pressedNao,
            ),
          ],
        )
      ],
    );
  }

  void _pressedSim() => _deleteAll(true);
  void _pressedNao() => _deleteAll(false);

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
                  onPressed: _toDoAdd,
                ),
              ],
            )),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: _toDoList.length,
              itemBuilder: buildItem),
        ),
        Row(
          children: <Widget>[
            RaisedButton(
              color: _cbground,
              child: Text("ChangeColor"),
              textColor: _ctext,
              onPressed: _setColorTheme,
            ),
            RaisedButton(
              color: _cbground,
              child: Text("Delete All"),
              textColor: _ctext,
              onPressed: () => dialog("Delete All").build(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildItem(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: _cbground2,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: _ctext),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoList[index]["title"]),
        value: _toDoList[index]["ok"],
        activeColor: _cbground,
        secondary: CircleAvatar(
          child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),
          foregroundColor: _ctext,
          backgroundColor: _cbground,
        ),
        onChanged: (bool value) {
          setState(() {
            _toDoList[index]["ok"] = value;
            _saveFile(false);
          });
        },
      ),
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveFile(bool delall) async {
    if (delall) _toDoList = List();
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
