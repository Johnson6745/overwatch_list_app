import 'package:flutter/material.dart';
import 'package:overwatch_list_app/screens/home_screen.dart';
import 'package:overwatch_list_app/services/data_sync_service.dart';
import 'services/local_database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:provider/provider.dart';
import 'services/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox(LocalDatabase.mapsBoxName);
  await Hive.openBox(LocalDatabase.heroesBoxName);
  await Hive.openBox(LocalDatabase.favoritesBoxName);
  await Hive.openBox(LocalDatabase.heroDetailsBoxName);

  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  await Hive.openBox('settings_box');

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'Overwatch List',
      theme: themeProvider.themeData,
      home: const HomeScreen(),
    );
  }
}
