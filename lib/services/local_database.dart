import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

class LocalDatabase {
  
  static const String mapsBoxName = 'maps_box';
  static const String heroesBoxName = 'heroes_box';
  static const String favoritesBoxName = 'favorites_box';
  
  Future<void> saveMaps(List<dynamic> maps) async {
    final box = Hive.box(mapsBoxName);
    await box.put('data', maps);
   log('Zapisano ${maps.length} map.', name: 'LocalDB');
  }

  Future<void> saveHeroes(List<dynamic> heroes) async {
    final box = Hive.box(heroesBoxName);
    await box.put('data', heroes);
    log('Zapisano ${heroes.length} bohaterów.', name: 'LocalDB');
  }


  List<dynamic> getMaps() {
    final box = Hive.box(mapsBoxName);
    return box.get('data', defaultValue: []);
  }

  List<dynamic> getHeroes() {
    final box = Hive.box(heroesBoxName);
    return box.get('data', defaultValue: []);
  }
  Future<void> addFavoriteHero(String heroName) async {
    final box = Hive.box(favoritesBoxName);
    final List<String> favs = List<String>.from(box.get('heroes', defaultValue: []));
    if (!favs.contains(heroName)) {
      favs.add(heroName);
      await box.put('heroes', favs);
    }
  }

  Future<void> removeFavoriteHero(String heroName) async {
    final box = Hive.box(favoritesBoxName);
    final List<String> favs = List<String>.from(box.get('heroes', defaultValue: []));
    favs.remove(heroName);
    await box.put('heroes', favs);
  }

  bool isFavoriteHero(String heroName) {
    final box = Hive.box(favoritesBoxName);
    final List<String> favs = List<String>.from(box.get('heroes', defaultValue: []));
    return favs.contains(heroName);
  }

  List<String> getFavoriteHeroNames() {
    final box = Hive.box(favoritesBoxName);
    return List<String>.from(box.get('heroes', defaultValue: []));
  }

  Future<void> addFavoriteMap(String mapName) async {
    final box = Hive.box(favoritesBoxName);
    final List<String> favs = List<String>.from(box.get('maps', defaultValue: []));
    if (!favs.contains(mapName)) {
      favs.add(mapName);
      await box.put('maps', favs);
    }
  }

  Future<void> removeFavoriteMap(String mapName) async {
    final box = Hive.box(favoritesBoxName);
    final List<String> favs = List<String>.from(box.get('maps', defaultValue: []));
    favs.remove(mapName);
    await box.put('maps', favs);
  }

  bool isFavoriteMap(String mapName) {
    final box = Hive.box(favoritesBoxName);
    final List<String> favs = List<String>.from(box.get('maps', defaultValue: []));
    return favs.contains(mapName);
  }

  List<String> getFavoriteMapNames() {
    final box = Hive.box(favoritesBoxName);
    return List<String>.from(box.get('maps', defaultValue: []));
  }
}