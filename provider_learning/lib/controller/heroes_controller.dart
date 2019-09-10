import 'package:flutter/material.dart';
import 'package:provider_learning/model/hero_model.dart';

class HeroesController extends ChangeNotifier {

  List<HeroModel> heroes = [
    HeroModel(name: "Bob Esponja"),
    HeroModel(name: "Pratric Estrela"),
    HeroModel(name: "Sandy"),
    HeroModel(name: "Sr. Siri Queijo"),
    HeroModel(name: "Lula Molusco"),
  ];

  checkFavorite(HeroModel hero){
    hero.isFavorite = !hero.isFavorite;
    notifyListeners();
  }

  notify(){
    notifyListeners();
  }
}
