import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'local_database.dart'; 

class ApiService {
  final LocalDatabase _localDb = LocalDatabase();

  static const String _mapsUrl = 'https://overfast-api.tekrop.fr/maps';
  static const String _heroesUrl = 'https://overfast-api.tekrop.fr/heroes?locale=en-us';

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
    }
  }
}