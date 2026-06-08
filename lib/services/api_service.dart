import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'local_database.dart'; 

class ApiService {
  final LocalDatabase _localDb = LocalDatabase();

  static const String _mapsUrl = 'https://overfast-api.tekrop.fr/maps';
  static const String _heroesUrl = 'https://overfast-api.tekrop.fr/heroes?locale=en-us';
  static const String _heroDetailUrl = 'https://overfast-api.tekrop.fr/heroes/{key}?locale=pl-pl';
  Future<void> fetchAndSaveData() async {
    try {
      log('Rozpoczynam pobieranie danych...', name: 'API');

      final responseMaps = await http.get(Uri.parse(_mapsUrl));
      final responseHeroes = await http.get(Uri.parse(_heroesUrl));

      if (responseMaps.statusCode == 200) {
        final decodedMaps = jsonDecode(responseMaps.body);
       
        await _localDb.saveMaps(decodedMaps);
      } else {
        log('Błąd pobierania Map: ${responseMaps.statusCode}', name: 'API');
      }

      if (responseHeroes.statusCode == 200) {
        final decodedHeroes = jsonDecode(responseHeroes.body);
       
        await _localDb.saveHeroes(decodedHeroes);
      } else {
        log('Błąd pobierania Bohaterów: ${responseHeroes.statusCode}', name: 'API');
      }

    } catch (e) {
      log('Wystąpił błąd sieci: $e', name: 'API');
      rethrow;
    }
  }
  Future<Map<String, dynamic>?> fetchHeroDetail(String heroKey) async {

    final cached = _localDb.getHeroDetail(heroKey);
    if (cached != null) {
      log('Szczegóły herosa $heroKey z cache', name: 'API');
      return cached;
    }


    try {
      final url = _heroDetailUrl.replaceAll('{key}', heroKey);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        await _localDb.saveHeroDetail(heroKey, data);
        return data;
      } else {
        log('Błąd pobierania szczegółów: ${response.statusCode}', name: 'API');
        return null;
      }
    } catch (e) {
      log('Błąd sieci (detail): $e', name: 'API');
      return null;
    }
  }
}