import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logHeroClick(String heroName) async {
      await _analytics.logEvent(
        name: 'hero_opened',
        parameters: {'hero_name': heroName},
      );
  }
  static Future<void> logFavouriteAdded(String hero_name) async {
    await _analytics.logEvent(
      name: 'favourite_added',
      parameters: {
        'hero_name': hero_name,
      },

    );
  }
  static Future<void> logReturnToHomeScreen() async {
    await _analytics.logEvent(
      name: 'return_to_home',
    );
  }
}