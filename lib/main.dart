import 'package:flutter/material.dart';
import 'package:overwatch_list_app/screens/home_screen.dart';
import 'package:overwatch_list_app/services/data_sync_service.dart';
import 'services/local_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox(LocalDatabase.mapsBoxName);
  await Hive.openBox(LocalDatabase.heroesBoxName);
  await Hive.openBox(LocalDatabase.favoritesBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Overwatch List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        )),
      home: const HomeScreen(),
    );
  }
}
