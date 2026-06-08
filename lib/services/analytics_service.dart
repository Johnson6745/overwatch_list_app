import 'dart:developer';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logHeroClick(String heroName) async {
      await _analytics.logEvent(
        name: 'hero_opened',
        parameters: {'hero_name': heroName},
      );
      log('Kliknieto ${heroName}', name: 'AnalyticsService');
  }
  static Future<void> logFavouriteAdded(String hero_name) async {
    await _analytics.logEvent(
      name: 'favourite_hero_added',
      parameters: {
        'hero_name': hero_name,
      },
    );
    log('Dodano do ulubionych ${hero_name}', name: 'AnalyticsService');
  }
  static Future<void> logReturnToHomeScreen() async {
    await _analytics.logEvent(
      name: 'return_to_home',
    );
  }
  static Future<void> logFavouriteMapAdded(String map_name) async {
    await _analytics.logEvent(
      name: 'favourite_map_added',
      parameters: {
        'map_name': map_name,
      },

    );
    log('Dodano do ulubionych ${map_name}', name: 'AnalyticsService');
  }
}

