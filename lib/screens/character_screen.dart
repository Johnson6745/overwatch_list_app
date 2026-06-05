import 'package:flutter/material.dart';
import '../models/hero_model.dart';
import '/services/local_database.dart';
import '/models/hero_model.dart';
import '/widgets/grid.dart';

class HeroesScreen extends StatefulWidget {
  const HeroesScreen({super.key});

  @override
  State<HeroesScreen> createState() => _HeroesScreenState();
}

class _HeroesScreenState extends State<HeroesScreen> {
  final LocalDatabase _localDb = LocalDatabase();
  List<HeroModel> _heroes = [];

  @override
  void initState() {
    super.initState();

    final rawData = _localDb.getHeroes();
    _heroes = rawData.map((e) => HeroModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Postacie')),
      body: CustomGridView<HeroModel>(
        items: _heroes,
        getTitle: (hero) => hero.name,
        getSubtitle: (hero) => hero.role.toUpperCase(),
        getImageUrl: (hero) => hero.portrait,
      ),
    );
  }
}