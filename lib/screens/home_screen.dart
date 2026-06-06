import 'package:flutter/material.dart';
import 'package:overwatch_list_app/screens/settings_screen.dart';
import 'package:overwatch_list_app/services/analytics_service.dart';
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
  bool _hasError = false;
  @override
  void initState() {
    super.initState();
    AnalyticsService.logReturnToHomeScreen();
    _init();
  }

  Future<void> _init() async {
    try {
      await SyncService.loadInitialDataIfNeeded();
    } catch (e) {
      debugPrint('Błąd inicjalizacji: $e');
      if (mounted) setState(() => _hasError = true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: theme.colorScheme.primary),
        ),
      );
    }

    if (_hasError) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off_rounded,
                    size: 64, color: theme.colorScheme.primary.withOpacity(0.5)),
                const SizedBox(height: 24),
                Text(
                  'Brak połączenia',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nie udało się pobrać danych.\n '
                      'Sprawdź połączenie z internetem.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                      _hasError = false;
                    });
                    _init();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Spróbuj ponownie'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                  ),
                ),
              ],
            ),
          ),
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
            Text(
              'Overwatch',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'DATABASE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 4,
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 48),
            _buildMenuButton(
              context: context,
              title: 'Postacie',
              subtitle: 'Przeglądaj bohaterów',
              icon: Icons.person_outline,
              accentColor: theme.colorScheme.primary,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HeroesScreen())),
            ),
            const SizedBox(height: 12),
            _buildMenuButton(
              context: context,
              title: 'Mapy',
              subtitle: 'Przeglądaj mapy',
              icon: Icons.map_outlined,
              accentColor: const Color(0xFF378ADD),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MapScreen())),
            ),
            const SizedBox(height: 12),
            _buildMenuButton(
              context: context,
              title: 'Ulubione',
              subtitle: 'Twoja kolekcja',
              icon: Icons.favorite_outline,
              accentColor: const Color(0xFFD4537E),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const FavoritesScreen())),
            ),
            const SizedBox(height: 12),
            _buildMenuButton(
              context: context,
              title: 'Ustawienia',
              subtitle: 'Motyw i dane',
              icon: Icons.settings_outlined,
              accentColor: theme.colorScheme.onSurface.withOpacity(0.5),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);

    return Material(
      color: theme.cardTheme.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor),
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
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: theme.dividerColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}