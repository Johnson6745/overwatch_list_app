import 'package:flutter/material.dart';

class HeroFilterScreen extends StatefulWidget {
  const HeroFilterScreen({super.key});

  @override
  State<HeroFilterScreen> createState() => _HeroFilterScreenState();
}

class _HeroFilterScreenState extends State<HeroFilterScreen> {
  String? _selectedRole;
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filtruj Postacie')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Wpisz nazwę postaci'),
            ),
            DropdownButtonFormField<String>(
              hint: const Text('Wybierz Rolę'),
              value: _selectedRole,
              items: ['Tank', 'Damage', 'Support'].map((role) =>
                  DropdownMenuItem(value: role, child: Text(role))).toList(),
              onChanged: (val) => setState(() => _selectedRole = val),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'name': _nameController.text,
                  'role': _selectedRole,
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