import 'package:flutter/material.dart';
import 'package:overwatch_list_app/screens/home_screen.dart';
import 'package:overwatch_list_app/services/data_sync_service.dart';
import 'services/local_database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox(LocalDatabase.mapsBoxName);
  await Hive.openBox(LocalDatabase.heroesBoxName);
  await Hive.openBox(LocalDatabase.favoritesBoxName);
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Overwatch List',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFF99E1A),
          secondary: const Color(0xFFF99E1A),
          surface: const Color(0xFF111111),
          background: const Color(0xFF0A0A0A),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF111111),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Color(0xFFF99E1A)),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF111111),
          selectedItemColor: Color(0xFFF99E1A),
          unselectedItemColor: Color(0xFF555555),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF99E1A),
            foregroundColor: const Color(0xFF0A0A0A),
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF141414),
          labelStyle: const TextStyle(color: Color(0xFF888888)),
          hintStyle: const TextStyle(color: Color(0xFF444444)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF222222)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF222222)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFF99E1A)),

          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF141414),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF222222)),
          ),
          elevation: 0,
        ),
        dividerColor: const Color(0xFF1A1A1A),
      ),
      home: const HomeScreen(),
    );
  }
}
