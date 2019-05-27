import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Pessoas",
      home: Home()));
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _countPessoas = 0;
  String _textInfo = "";
  void changeP(int d) {
      setState(() {
        if((_countPessoas < 10 && _countPessoas >= 0) && d > 0) {
          _countPessoas += d;
          _textInfo = "Pode Entrar";
        }else if(d < 0 && (_countPessoas <= 10 && _countPessoas > 0)) {
          _textInfo = "Pode Entrar";
          _countPessoas += d;
        }
      });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Image.asset(
            "images/fundo.jpg",
            fit: BoxFit.fitWidth,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Pessoas: $_countPessoas",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: FlatButton(
                      child: Text(
                        "+1",
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 30),
                      ),
                      onPressed: () {
                        changeP(1);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: FlatButton(
                      child: Text(
                        "-1",
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 30),
                      ),
                      onPressed: () {
                        changeP(-1);
                      },
                    ),
                  ),
                ],
              ),
              Text(
                _textInfo,
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 30),
              )
            ],
          )
        ],
      );
  }
}
