import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_learning/controller/heroes_controller.dart';
import 'package:provider_learning/model/hero_model.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _buildList() {
    HeroesController heroesController = Provider.of<HeroesController>(context);
    return ListView.builder(
      itemCount: heroesController.heroes.length,
      itemBuilder: (context, index) =>
          _buildItems(heroesController.heroes[index]),
    );
  }

  _buildItems(
    HeroModel hero,
  ) {
    HeroesController heroesController = Provider.of<HeroesController>(context);
    return ListTile(
      title: Text(hero.name),
      trailing: GestureDetector(
        onTap: () {
          heroesController.checkFavorite(hero);
        },
        child: Icon(
          hero.isFavorite ? Icons.star : Icons.star_border,
          color: hero.isFavorite ? Colors.yellow : Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider'),
        leading: Consumer<HeroesController>(
          builder: (context, heroesController, widget) {
            return Center(
              child: Text(
                  'Favoritados: ${heroesController.heroes.where((h) => h.isFavorite).length}'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          HeroesController heroesController =
              Provider.of<HeroesController>(context);
          heroesController.heroes.add(
            HeroModel(name: "Item ${heroesController.heroes.length}"),
          );
          heroesController.notify();
        },
      ),
      body: Consumer<HeroesController>(
          builder: (context, heroesController, widget) => _buildList()),
    );
  }
}
