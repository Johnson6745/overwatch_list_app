import 'package:flutter/material.dart';

class MapFilterScreen extends StatefulWidget {
  const MapFilterScreen({super.key});

  @override
  State<MapFilterScreen> createState() => _MapFilterScreenState();
}

class _MapFilterScreenState extends State<MapFilterScreen> {
  String? _selectedGamemode;
  final TextEditingController _nameController = TextEditingController();

  final _gamemodes = [
    'Control', 'Escort', 'Hybrid', 'Push', 'Flashpoint', 'Clash',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FILTRUJ MAPY')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('NAZWA',
                style: TextStyle(fontSize: 11, letterSpacing: 1.5,
                    color: Color(0xFFF99E1A), fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Wpisz nazwę mapy...',
                prefixIcon: Icon(Icons.search, color: Color(0xFF555555), size: 20),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(color: Color(0xFF1A1A1A)),
            const SizedBox(height: 24),
            const Text('TRYB GRY',
                style: TextStyle(fontSize: 11, letterSpacing: 1.5,
                    color: Color(0xFFF99E1A), fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _gamemodes.map((mode) {
                final isSelected = _selectedGamemode == mode;
                return GestureDetector(
                  onTap: () => setState(() =>
                  _selectedGamemode = isSelected ? null : mode),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFF99E1A).withOpacity(0.15)
                          : const Color(0xFF141414),
                      border: Border.all(
                          color: isSelected
                              ? const Color(0xFFF99E1A)
                              : const Color(0xFF222222)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(mode,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? const Color(0xFFF99E1A)
                              : const Color(0xFF666666),
                        )),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _nameController.clear();
                      setState(() => _selectedGamemode = null);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF666666),
                      side: const BorderSide(color: Color(0xFF222222)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Wyczyść'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, {
                      'name': _nameController.text,
                      'gamemode': _selectedGamemode,
                    }),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Zastosuj filtry'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}