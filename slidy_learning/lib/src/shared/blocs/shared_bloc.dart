import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:slidy_learning/src/shared/models/sentimento_model.dart';

class SharedBloc extends BlocBase {
  BehaviorSubject<List<SentimentoModel>> _listController = BehaviorSubject.seeded([]);

  Observable<List<SentimentoModel>> get listOut => _listController.stream;

  addNewFell(SentimentoModel model){
    _listController.value.add(model);
    _listController.add(_listController.value);
  }
  @override
  void dispose() {
    _listController.close();
    super.dispose();
  }
}
