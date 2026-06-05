import 'package:flutter/material.dart';
import 'package:overwatch_list_app/screens/favourites_screen.dart';
import '../models/hero_model.dart';
import '../services/local_database.dart';
import '../widgets/grid.dart';
import 'hero_filter_screen.dart';
import 'maps_screen.dart';
import 'hero_detail_screen.dart';
class HeroesScreen extends StatefulWidget {
  const HeroesScreen({super.key});

  @override
  State<HeroesScreen> createState() => _HeroesScreenState();
}

class _HeroesScreenState extends State<HeroesScreen> {
  final LocalDatabase _localDb = LocalDatabase();
  List<HeroModel> _allHeroes = [];
  List<HeroModel> _filteredHeroes = [];

  @override
  void initState() {
    super.initState();

    final rawData = _localDb.getHeroes();
    _allHeroes = rawData.map((e) => HeroModel.fromJson(e as Map)).toList();
    _filteredHeroes = _allHeroes;
  }


  Future<void> _openFilter() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HeroFilterScreen()),
    );
    if (!mounted) return;

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _filteredHeroes = _allHeroes.where((hero) {
          final name = result['name'] ?? '';
          final role = result['role'];

          final nameMatch = hero.name.toLowerCase().contains(name.toLowerCase());
          final roleMatch = role == null || role.isEmpty || hero.role.toLowerCase() == role.toLowerCase();

          return nameMatch && roleMatch;
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Postacie'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _openFilter,
          ),
        ],
      ),
      body: CustomGridView<HeroModel>(
        items: _filteredHeroes,
        getTitle: (hero) => hero.name,
        getSubtitle: (hero) => hero.role.toUpperCase(),
        getImageUrl: (hero) => hero.portrait,
        onTap: (hero) => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HeroDetailScreen(hero: hero)),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) return;
          if (index == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MapScreen()));
          }
          if(index ==2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FavoritesScreen()));
          }

        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Postacie'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapy'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Ulubione'),
        ],
      ),
    );
  }
}