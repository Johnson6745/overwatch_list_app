import 'api_service.dart';
import 'local_database.dart';
import 'dart:developer';
class SyncService {
  static Future<void> loadInitialDataIfNeeded() async {
    final localDb = LocalDatabase();
    final apiService = ApiService();

    final hasHeroes = localDb.getHeroes().isNotEmpty;
    final hasMaps = localDb.getMaps().isNotEmpty;

    if (hasHeroes && hasMaps) {
      log('Dane są już w bazie. Pomijam pobieranie z API.', name: 'SyncService');
      return;
    }

    log('Baza jest pusta. Pobieram i zapisuję dane z API...', name: 'SyncService');
    await apiService.fetchAndSaveData();
  }
}