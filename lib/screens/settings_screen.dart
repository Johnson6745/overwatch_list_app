import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../app_themes.dart';
import '../services/theme_provider.dart';
import '../services/api_service.dart';
import '../services/local_database.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isSyncing = false;

  Future<void> _refreshData() async {
    setState(() => _isSyncing = true);
    try {
      final db = LocalDatabase();
      await db.saveMaps([]);
      await db.saveHeroes([]);
      await Hive.box(LocalDatabase.heroDetailsBoxName).clear();
      await ApiService().fetchAndSaveData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dane odświeżone pomyślnie'),
            backgroundColor: Color(0xFF639922),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Błąd podczas odświeżania danych'),
            backgroundColor: Color(0xFFE24B4A),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSyncing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final accent = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('USTAWIENIA')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _sectionLabel('MOTYW APLIKACJI', accent),
          const SizedBox(height: 12),
          ...AppTheme.values.map((theme) {
            final isSelected = themeProvider.currentTheme == theme;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _ThemeOption(
                theme: theme,
                isSelected: isSelected,
                accent: accent,
                onTap: () => themeProvider.setTheme(theme),
              ),
            );
          }),

          const SizedBox(height: 32),
          Divider(color: Theme.of(context).dividerColor),
          const SizedBox(height: 32),

          _sectionLabel('DANE', accent),
          const SizedBox(height: 12),
          _buildDataTile(context, accent),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text, Color accent) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w500,
        color: accent,
      ),
    );
  }

  Widget _buildDataTile(BuildContext context, Color accent) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: accent.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: _isSyncing
              ? Padding(
            padding: const EdgeInsets.all(8),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: accent,
            ),
          )
              : Icon(Icons.sync, color: accent, size: 20),
        ),
        title: const Text(
          'Odśwież dane z API',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'Pobiera aktualne mapy i postacie',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        trailing: _isSyncing
            ? null
            : Icon(Icons.chevron_right,
            color: Theme.of(context).dividerColor, size: 20),
        onTap: _isSyncing ? null : _refreshData,
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final AppTheme theme;
  final bool isSelected;
  final Color accent;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.theme,
    required this.isSelected,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final name = AppThemes.getName(theme);
    final icon = AppThemes.getIcon(theme);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? accent : Theme.of(context).dividerColor,
            width: isSelected ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isSelected ? accent : Colors.grey, size: 20),
            const SizedBox(width: 14),
            Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? accent : null,
              ),
            ),
            const Spacer(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? accent : Colors.grey,
                  width: 2,
                ),
                color: isSelected ? accent : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}