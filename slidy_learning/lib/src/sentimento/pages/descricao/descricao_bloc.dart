import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:slidy_learning/src/app_module.dart';
import 'package:slidy_learning/src/sentimento/sentimento_bloc.dart';
import 'package:slidy_learning/src/sentimento/sentimento_module.dart';
import 'package:slidy_learning/src/shared/blocs/shared_bloc.dart';

class DescricaoBloc extends BlocBase {
  addModel() {
    var model = SentimentoModule.to.bloc<SentimentoBloc>().model;
    AppModule.to.bloc<SharedBloc>().addNewFell(model);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
