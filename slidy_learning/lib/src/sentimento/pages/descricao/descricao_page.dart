import 'package:flutter/material.dart';
import 'package:slidy_learning/src/sentimento/pages/descricao/descricao_bloc.dart';
import 'package:slidy_learning/src/sentimento/sentimento_bloc.dart';
import 'package:slidy_learning/src/sentimento/sentimento_module.dart';

class DescricaoPage extends StatefulWidget {
  @override
  _DescricaoPageState createState() => _DescricaoPageState();
}

class _DescricaoPageState extends State<DescricaoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Escreva seu pensamento:'),
            SizedBox(
              height: 30,
            ),
            TextField(
              maxLines: 5,
              onChanged: (value) {
                var model = SentimentoModule.to.bloc<SentimentoBloc>().model;
                model.subtitle = value != null ? value : model.subtitle;
              },
            ),
            SizedBox(
              height: 30,
            ),
            OutlineButton(
              onPressed: () {
                SentimentoModule.to.bloc<DescricaoBloc>().addModel();
                Navigator.pop(context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "SALVAR",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
