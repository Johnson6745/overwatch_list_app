import 'package:flutter/material.dart';
import '../models/map_model.dart';
import '../services/local_database.dart';
import '../widgets/grid.dart';
import 'map_filter_screen.dart';
import 'character_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LocalDatabase _localDb = LocalDatabase();
  List<MapModel> _allMaps = [];
  List<MapModel> _filteredMaps = [];

  @override
  void initState() {
    super.initState();

    final rawData = _localDb.getMaps();
    _allMaps = rawData.map((e) => MapModel.fromJson(e as Map)).toList();
    _filteredMaps = _allMaps;
  }


  Future<void> _openFilter() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapFilterScreen()),

    );
    if (!mounted) return;

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _filteredMaps = _allMaps.where((map) {
          final name = result['name'] ?? '';
          final gamemode = result['gamemode'];

          final nameMatch = map.name.toLowerCase().contains(name.toLowerCase());
          final gamemodeMatch = gamemode == null || gamemode.isEmpty || map.gamemode.toLowerCase() == gamemode.toLowerCase();

          return nameMatch && gamemodeMatch;
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _openFilter,
          ),
        ],
      ),
      body: CustomGridView<MapModel>(
        items: _filteredMaps,
        getTitle: (map) => map.name,
        getSubtitle: (map) => map.gamemode.toUpperCase(),
        getImageUrl: (map) => map.screenshot,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HeroesScreen()));
          }
          if (index == 1) {
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
}