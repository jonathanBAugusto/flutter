import 'package:flutter/material.dart';
import 'package:slidy_learning/src/sentimento/sentimento_bloc.dart';
import 'package:slidy_learning/src/sentimento/sentimento_module.dart';
import 'package:slidy_learning/src/shared/widgets/smiley.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  double valueRange = 0;

  _getRangedText(valueRange) {
    if (valueRange <= 0)
      return "Feliz";
    else if (valueRange > 0 && valueRange < 0.25)
      return "Animado";
    else if (valueRange > 0.25 && valueRange < 0.35)
      return '"Hehe"';
    else if (valueRange > 0.35 && valueRange < 0.55)
      return "Indiferente";
    else if (valueRange > 0.55 && valueRange < 0.75)
      return "Desanimado";
    else
      return "Triste";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Como está se sentindo agora?"),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 200,
            width: 200,
            child: Smiley(
              range: valueRange,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _getRangedText(valueRange),
            style: TextStyle(
              color: Color.lerp(Colors.blue, Colors.red, valueRange),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Slider(
            onChanged: (value) {
              setState(() => valueRange = value);
            },
            value: valueRange,
            min: 0,
            max: 1,
          ),
          OutlineButton(
            onPressed: () {
              var model = SentimentoModule.to.bloc<SentimentoBloc>().model;
              model.sentimento = valueRange;
              model.title = _getRangedText(valueRange);
              SentimentoModule.to.bloc<SentimentoBloc>().pageController.jumpToPage(1);
            },
            color: Color.lerp(Colors.blue, Colors.red, valueRange),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.lerp(BorderRadius.circular(3),
                    BorderRadius.circular(22), valueRange)),
            child: Text(
              "PRÓXIMO",
              style: TextStyle(
                color: Color.lerp(Colors.blue, Colors.red, valueRange),
              ),
            ),
          )
        ],
      ),
    );
  }
}
