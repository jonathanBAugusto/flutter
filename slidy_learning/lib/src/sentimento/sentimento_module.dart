import 'package:slidy_learning/src/sentimento/pages/descricao/descricao_bloc.dart';
import 'package:slidy_learning/src/sentimento/pages/status/status_bloc.dart';
import 'package:slidy_learning/src/sentimento/sentimento_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:slidy_learning/src/sentimento/sentimento_page.dart';

class SentimentoModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => DescricaoBloc()),
        Bloc((i) => StatusBloc()),
        Bloc((i) => SentimentoBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => SentimentoPage();

  static Inject get to => Inject<SentimentoModule>.of();
}
