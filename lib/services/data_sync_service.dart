import 'api_service.dart';
import 'local_database.dart';

class SyncService {
  static Future<void> loadInitialDataIfNeeded() async {
    final localDb = LocalDatabase();
    final apiService = ApiService();

    final hasHeroes = localDb.getHeroes().isNotEmpty;
    final hasMaps = localDb.getMaps().isNotEmpty;

    if (hasHeroes && hasMaps) {
      print('SyncService: Dane są już w bazie. Pomijam pobieranie z API.');
      return;
    }

    print('SyncService: Baza jest pusta. Pobieram i zapisuję dane z API...');
    await apiService.fetchAndSaveData();
  }
}