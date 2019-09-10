import 'package:flutter/material.dart';

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
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _info = "";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _info = "Informe seus dados";
    });
  }

  void _calcularIMC() {
    setState(() {
      double w = double.parse(weightController.text);
      double h = double.parse(
          heightController.text.replaceAll(".", "").replaceAll(",", ".")) / 100;
      double imc = w / (h * h);
      if (imc < 18.6) {
        _info = "Abaixo do Peso! (${imc.toStringAsFixed(2)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _info = "Peso Ideal (${imc.toStringAsFixed(2)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _info = "Levemente acima do Peso (${imc.toStringAsFixed(2)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _info = "Obesidade Grau I (${imc.toStringAsFixed(2)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _info = "Obesidade Grau II  (${imc.toStringAsFixed(2)})";
      } else if (imc >= 40) {
        _info = "Obesidade Grau III (${imc.toStringAsFixed(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFields();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120,
                    color: Colors.purple,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (Kg)",
                        labelStyle: TextStyle(color: Colors.purple)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.purple, fontSize: 25),
                    controller: weightController,
                    validator: (value) => value.isEmpty ? "Insira seu Peso" : null,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.purple)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.purple, fontSize: 25),
                    controller: heightController,
                    validator: (value) => value.isEmpty ? "Insira sua Altura" : null,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if(_formKey.currentState.validate())
                            _calcularIMC();
                        },
                        child: Text("Calcular",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  Text(
                    _info,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.purple, fontSize: 20),
                  )
                ],
              ))),
    );
  }
}
