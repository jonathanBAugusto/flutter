import 'package:flutter/material.dart';
import 'package:slidy_learning/src/app_module.dart';
import 'package:slidy_learning/src/sentimento/sentimento_module.dart';
import 'package:slidy_learning/src/shared/blocs/shared_bloc.dart';
import 'package:slidy_learning/src/shared/models/sentimento_model.dart';
import 'package:slidy_learning/src/shared/widgets/smiley.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final blocSentimento = AppModule.to.getBloc<SharedBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pensamentos"),
      ),
      body: StreamBuilder<List<SentimentoModel>>(
        stream: blocSentimento.listOut,
        builder: (_, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          final List<SentimentoModel> models = snapshot.data;

          if (models.length == 0) {
            return Container(
              color: Colors.grey[300],
              child: Center(
                child: Text("Não há nenhum pensamento cadastrado"),
              ),
            );
          }

          return ListView.separated(
            itemCount: models.length,
            itemBuilder: (BuildContext _, int index) {
              return ListTile(
                leading: Container(
                  height: 100,
                  width: 100,
                  child: Smiley(
                    range: models[index].sentimento,
                  ),
                ),
                title: Text(models[index].title),
                subtitle: Text(models[index].subtitle),
              );
            },
            separatorBuilder: (BuildContext _, int __) => Divider(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SentimentoModule(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
