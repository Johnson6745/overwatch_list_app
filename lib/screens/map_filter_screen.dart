import 'package:flutter/material.dart';

class MapFilterScreen extends StatefulWidget {
  const MapFilterScreen({super.key});

  @override
  State<MapFilterScreen> createState() => _MapFilterScreenState();
}

class _MapFilterScreenState extends State<MapFilterScreen> {
  String? _selectedGamemode;
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filtruj mapy')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Wpisz nazwę mapy'),
            ),
            DropdownButtonFormField<String>(
              hint: const Text('Wybierz gamemode'),
              value: _selectedGamemode,
              items: ['Control', 'Escort', 'Hybrid', 'Push', 'Flashpoint', 'Clash'].map((gamemode) =>
                  DropdownMenuItem(value: gamemode, child: Text(gamemode))).toList(),
              onChanged: (val) => setState(() => _selectedGamemode = val),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'name': _nameController.text,
                  'gamemode': _selectedGamemode,
                });
              },
              child: const Text('Zastosuj filtry'),
            ),
          ],
        ),
      ),
    );
  }
}