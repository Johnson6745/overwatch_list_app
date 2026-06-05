import 'package:flutter/material.dart';

class HeroFilterScreen extends StatefulWidget {
  const HeroFilterScreen({super.key});

  @override
  State<HeroFilterScreen> createState() => _HeroFilterScreenState();
}

class _HeroFilterScreenState extends State<HeroFilterScreen> {
  String? _selectedRole;
  final TextEditingController _nameController = TextEditingController();

  final _roles = [
    {'label': 'Tank', 'color': const Color(0xFF378ADD)},
    {'label': 'Damage', 'color': const Color(0xFFE24B4A)},
    {'label': 'Support', 'color': const Color(0xFF639922)},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FILTRUJ POSTACIE')),
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
                hintText: 'Wpisz nazwę postaci...',
                prefixIcon: Icon(Icons.search, color: Color(0xFF555555), size: 20),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(color: Color(0xFF1A1A1A)),
            const SizedBox(height: 24),
            const Text('ROLA',
                style: TextStyle(fontSize: 11, letterSpacing: 1.5,
                    color: Color(0xFFF99E1A), fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _roles.map((role) {
                final label = role['label'] as String;
                final color = role['color'] as Color;
                final isSelected = _selectedRole == label;

                return GestureDetector(
                  onTap: () => setState(() =>
                  _selectedRole = isSelected ? null : label),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? color.withOpacity(0.15) : const Color(0xFF141414),
                      border: Border.all(
                          color: isSelected ? color : const Color(0xFF222222)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(label,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? color : const Color(0xFF666666),
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
                      setState(() => _selectedRole = null);
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
                      'role': _selectedRole,
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