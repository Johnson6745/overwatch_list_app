import 'package:flutter/material.dart';
import '../models/hero_model.dart';
import '../models/map_model.dart';
import '../services/local_database.dart';
import 'hero_detail_screen.dart';
import 'map_detail_screen.dart';
import 'character_screen.dart';
import 'maps_screen.dart';
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final LocalDatabase _localDb = LocalDatabase();
  List<HeroModel> _favoriteHeroes = [];
  List<MapModel> _favoriteMaps = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    final heroNames = _localDb.getFavoriteHeroNames();
    final mapNames = _localDb.getFavoriteMapNames();

    final allHeroes = _localDb.getHeroes().map((e) => HeroModel.fromJson(e as Map)).toList();
    final allMaps = _localDb.getMaps().map((e) => MapModel.fromJson(e as Map)).toList();

    setState(() {
      _favoriteHeroes = allHeroes.where((h) => heroNames.contains(h.name)).toList();
      _favoriteMaps = allMaps.where((m) => mapNames.contains(m.name)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ulubione')),
      body: (_favoriteHeroes.isEmpty && _favoriteMaps.isEmpty)
          ? const Center(child: Text('Brak ulubionych.', style: TextStyle(fontSize: 16)))
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_favoriteHeroes.isNotEmpty) ...[
            const Text('Postacie', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._favoriteHeroes.map((hero) => _buildTile(
              title: hero.name,
              subtitle: hero.role.toUpperCase(),
              imageUrl: hero.portrait,
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (_) => HeroDetailScreen(hero: hero)));
                _loadFavorites(); // odśwież po powrocie
              },
            )),
            const SizedBox(height: 16),
          ],
          if (_favoriteMaps.isNotEmpty) ...[
            const Text('Mapy', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._favoriteMaps.map((map) => _buildTile(
              title: map.name,
              subtitle: map.gamemode.toUpperCase(),
              imageUrl: map.screenshot,
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (_) => MapDetailScreen(map: map)));
                _loadFavorites();
              },
            )),
          ],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HeroesScreen()));
          };
          if (index == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MapScreen()));
          }
          if(index == 2){
            return;
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

  Widget _buildTile({
    required String title,
    required String subtitle,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: onTap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}