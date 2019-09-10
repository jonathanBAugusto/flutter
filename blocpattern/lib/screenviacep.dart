import 'package:blocpattern/endereco_model.dart';
import 'package:blocpattern/screenviacep_bloc.dart';
import 'package:flutter/material.dart';

class ScreenViaCep extends StatefulWidget {
  final String title;
  ScreenViaCep({@required this.title, Key key}) : super(key: key);

  _ScreenViaCepState createState() => _ScreenViaCepState();
}

class _ScreenViaCepState extends State<ScreenViaCep> {
  ScreenViaCepBloc blocViaCep = ScreenViaCepBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  hintText: "Digite seu cep aqui",
                  border: OutlineInputBorder()),
              onChanged: (value) {
                blocViaCep.input.add(value);
              },
            ),
            StreamBuilder<EnderecoModel>(
              stream: blocViaCep.output,
              initialData: EnderecoModel(bairro: "Sem bairro"),
              builder: (context, snapshot) {
                if(snapshot.hasError)
                  return Text('Erro na pesquisa\n${snapshot.error}', style: TextStyle(color: Colors.red),);
                return Text(snapshot.data.toString());
              }
            ),
          ],
        ),
      ),
    );
  }
}
