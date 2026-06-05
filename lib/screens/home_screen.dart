import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import '../services/data_sync_service.dart';
import 'character_screen.dart';
import 'maps_screen.dart';
import 'favourites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      await SyncService.loadInitialDataIfNeeded();
    } catch (e) {
      debugPrint('Błąd inicjalizacji: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFF99E1A)),
        ),
      );
    }



    return Scaffold(

      appBar: AppBar(title: const Text('OVERWATCH LIST')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Overwatch',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
            ),
            const SizedBox(height: 4),
            const Text(
              'DATABASE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 4,
                color: Color(0xFFF99E1A),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 48),
            _buildMenuButton(
              title: 'Postacie',
              subtitle: 'Przeglądaj bohaterów',
              icon: Icons.person_outline,
              accentColor: const Color(0xFFF99E1A),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HeroesScreen())),
            ),
            const SizedBox(height: 12),
            _buildMenuButton(
              title: 'Mapy',
              subtitle: 'Przeglądaj mapy',
              icon: Icons.map_outlined,
              accentColor: const Color(0xFF378ADD),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MapScreen())),
            ),
            const SizedBox(height: 12),
            _buildMenuButton(
              title: 'Ulubione',
              subtitle: 'Twoja kolekcja',
              icon: Icons.favorite_outline,
              accentColor: const Color(0xFFD4537E),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const FavoritesScreen())),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     FirebaseCrashlytics.instance.crash();
            //   },
            //   child: const Text("Test crash"),
            // ),
          ],
        ),
      ),

    );

  }

  Widget _buildMenuButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: const Color(0xFF141414),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF222222)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: accentColor, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: const TextStyle(fontSize: 12, color: Color(0xFF666666))),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF444444), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}