import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?key=fef40778";

int count = 0;

void main() async {
  await getData();
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.white70, primaryColor: Colors.white),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realCtrl = TextEditingController();
  final dolarCtrl = TextEditingController();
  final euroCtrl = TextEditingController();

  void _realChanged(String t) {
    if (t == "") {
      _clear();
      return;
    }
    double real = double.parse(t);
    dolarCtrl.text = (real / dolar).toStringAsFixed(2);
    euroCtrl.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String t) {
    if (t == "") {
      _clear();
      return;
    }
    double dolar = double.parse(t);
    realCtrl.text = (dolar * this.dolar).toStringAsFixed(2);
    euroCtrl.text = ((dolar * this.dolar) / euro).toStringAsFixed(2);
  }

  void _euroChanged(String t) {
    if (t == "") {
      _clear();
      return;
    }
    double euro = double.parse(t);
    realCtrl.text = (euro * this.euro).toStringAsFixed(2);
    dolarCtrl.text = ((euro * this.euro) / dolar).toStringAsFixed(2);
  }

  void _clear() {
    realCtrl.text = "";
    dolarCtrl.text = "";
    euroCtrl.text = "";
  }

  double dolar = 0;
  double euro = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: Text("\$Coin Converter\$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              String texto = "";
              if (count == 0) {
                count++;
                texto = "Carregando.";
              } else if (count == 1) {
                count++;
                texto = "Carregando..";
              } else if (count == 2) {
                count = 0;
                texto = "Carregando...";
              }
              return Center(
                child: Text(
                  texto,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao Carregar Dados",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on,
                            size: 150, color: Colors.white),
                        buildTextField("Real", "R\$", realCtrl, _realChanged),
                        Divider(),
                        buildTextField("Dólar", "\$", dolarCtrl, _dolarChanged),
                        Divider(),
                        buildTextField("Euro", "€", euroCtrl, _euroChanged),
                      ]),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(),
        prefixText: prefix,
      ),
      style: TextStyle(color: Colors.white, fontSize: 25),
      onChanged: f,
      keyboardType: TextInputType.numberWithOptions(decimal: true));
}
