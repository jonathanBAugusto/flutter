import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:slidy_learning/src/shared/models/sentimento_model.dart';

class SentimentoBloc extends BlocBase {
  
  final SentimentoModel model = SentimentoModel();

  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
