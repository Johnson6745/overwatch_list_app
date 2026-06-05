import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

class LocalDatabase {
  
  static const String mapsBoxName = 'maps_box';
  static const String heroesBoxName = 'heroes_box';
  
  
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
}